import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partylux/Constants/app_constants.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Utils/Network/tost.dart';
import '../../../Constants/integer.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Util.dart';
import '../Models/usermodel.dart';
import '../Service/auth_service.dart';

class RegisterViewModel extends GetxController with AuthService {
  Rx<TextEditingController> fullname = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  RxBool isCheckTerms = false.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<File> userImage = File("").obs;
  Rx<File> IDImage = File("").obs;

  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxBool obscureText2 = true.obs;
  RxBool obscureText = true.obs;
  RxString role = "user".obs;
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  void camera(isProfile) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera,imageQuality: AppInteger.IMAGE_QUALITY);
    if (photo != null) {
      if(isProfile){
        Util.compressFile(photo).then((value) {
          userImage.value = File(value!.path);
        });

      }else{
        Util.compressFile(photo).then((value) {
          IDImage.value = File(value!.path);
        });
      }
    } else {
      print('No image selected.');
    }
  }

// ================================ Gallery Open Method
  void photo(isProfile) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery,imageQuality: AppInteger.IMAGE_QUALITY);
    if (photo != null) {
      if(isProfile){
        Util.compressFile(photo).then((value) {
          userImage.value = File(value!.path);
        });
      }else{
        Util.compressFile(photo).then((value) {
          IDImage.value = File(value!.path);
        });
      }

    } else {
      print('No image selected.');
    }
  }

  void onRegister() async {
    if(isCheckTerms.value){
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        String? profileImageURL = "";
        String? profileIdURL = "";
        isLoading.value = true;
        if (userImage.value.path.isNotEmpty) {
          profileImageURL = await onUploadPicture(imagefile: userImage.value);
          if (IDImage.value.path.isNotEmpty) {
            profileIdURL = await onUploadPicture(imagefile: IDImage.value);
          }
        }

        UserModel result = await onRegisterService(
          name: fullname.value.text,
          email: email.value.text,
          password: password.value.text,
          role: role.value,
          userProfileImage: profileImageURL,
          userProfileId: profileIdURL,
        );
        if (result.email!=null) {

          isLoading.value = false;
          Get.toNamed(
            AppRoutes.OTP,
            arguments: [
              "register",
              email.value.text,
              result.userId
            ],
          );
        } else {
          isLoading.value = false;
        }

      }
    }else{
      Toast().error(massage: "Please Check Terms & Conditions");
    }

  }
}
