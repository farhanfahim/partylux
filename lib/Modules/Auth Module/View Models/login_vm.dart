import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Service/auth_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../../Constants/constants.dart';
import '../../../Utils/Network/tost.dart';
import '../../../Utils/Util.dart';
import '../Models/usermodel.dart';

class LoginViewModel extends GetxController with AuthService {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  final _database = FirebaseDatabase.instance.reference();

  RxBool obscureText = true.obs;
  RxString role = UserModel.ROLE_USER.obs;
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  FirebaseMessaging? _firebaseMessaging = FirebaseMessaging.instance;

  void onLogin() async {


      if (formKey.currentState!.validate()) {
        _firebaseMessaging!.getToken().then((token) async {

          isLoading.value = true;
          UserModel result = await onLoginService(
            email: email.value.text,
            password: password.value.text,
            role: role.value,
          );
          isLoading.value = false;
          if (result.userId!=null) {

            isLoading.value = false;
            await DatabaseHandler().setOnBoarding(true);
            if (!result.isVerified!) {
              Get.toNamed(AppRoutes.OTP, arguments: [
                "register",
                email.value.text,
                result.userId
              ],);
            } else if (result.authToken!.isNotEmpty) {
              await onSetorUpdateFCMToken(fcmToken: token!);
              if (!result.isProfile!) {
                Get.toNamed(AppRoutes.UPDATE_PROFILE, arguments: [false],);
              }else {
                Get.offAllNamed(AppRoutes.NAV_ROOT);
              }
            }
          } else {
            isLoading.value = false;
          }
        });

      }


  }

  void SignInWithAppleButton() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    if(credential != null && credential.userIdentifier != null) {

      final userId = credential.userIdentifier!.replaceAll(".", "");
      Map userMap =  Map();
      if(credential.email != null) {
        final fullName = credential.givenName! + " " + credential.familyName!;

        await _database.child(userId).set(
            {"email": credential.email, "fullName": fullName});

        userMap["uid"] = userId;
        userMap["fullName"] = fullName;
        userMap["email"] = credential.email;

        final fb.AuthCredential authCredential =
        fb.OAuthProvider('apple.com').credential(
          accessToken: credential.authorizationCode,
          idToken: credential.identityToken,
        );
        print(userId);
        await _auth.signInWithCredential(authCredential);
      }
      else {
        DatabaseEvent snapshot = await _database.child(userId).once();

        Map<String, dynamic> item = Map<String, dynamic>();
        if(snapshot.snapshot.children.isNotEmpty){
          if(snapshot.snapshot.children.first.key == 'email') {
            item['email'] = snapshot.snapshot.children.first.value;
          }
          if(snapshot.snapshot.children.last.key == 'fullName') {
            item['fullName'] = snapshot.snapshot.children.last.value;
          }
        }
        print('item ${item}');

        if (item != null && item["email"] != null) {

          userMap["uid"] = userId;
          userMap["fullName"] = item["fullName"];
          userMap["email"] = item["email"];

        } else {
          Util.showToast("Please open up the Setting app in your iPhone and tap on your name at the top. Then press Password & Security, then Apps using Apple ID They listed all the apps there and you can delete your app to revoke access and try to run app again.");
        }
      }

      UserModel result = await OnSocialLogin(
          uID: userMap['uid'],
          userName: userMap['fullName'],
          userLoginType: 'apple',
          email: userMap['email']
      );
      if (result.authToken!.isNotEmpty) {
        var token= await _firebaseMessaging!.getToken();
        await onSetorUpdateFCMToken(fcmToken: token!);
        await DatabaseHandler().setOnBoarding(true);
        if (!result.isProfile!) {
          Get.toNamed(
            AppRoutes.UPDATE_PROFILE,
            arguments: [false],
          );
        } else {
          Get.offAllNamed(AppRoutes.NAV_ROOT);
        }
      }

    } else {
      Util.showToast("Login Error");
    }

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void SignInWithGoogleButton() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in

      print("user: ${googleUser.displayName} ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("google auth: ${googleAuth.accessToken} ${googleAuth.idToken}");
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      print(user.displayName.toString());
      print(user.email.toString());
      print(user.uid.toString());

      UserModel result = await OnSocialLogin(
        uID: user.uid.toString(),
        userName: user.displayName.toString(),
        userLoginType: 'google',
        email: user.email!,
      );
      if (result.authToken!.isNotEmpty) {
        var token= await _firebaseMessaging!.getToken();
        await onSetorUpdateFCMToken(fcmToken: token!);
        await DatabaseHandler().setOnBoarding(true);
        if (!result.isProfile!) {
          Get.toNamed(
            AppRoutes.UPDATE_PROFILE,
            arguments: [false],
          );
        } else {
          Get.offAllNamed(AppRoutes.NAV_ROOT);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
