// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/profile_vm.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../../Constants/integer.dart';
import '../../../../Utils/Util.dart';
import '../Service/profile_service.dart';

class UpdateProfileViewModel extends GetxController with ProfileService {

  Rx<UserModel> userData = UserModel.fromEmpty().obs;

  final ImagePicker _picker = ImagePicker();


  Rx<File> userImage = File("").obs;


  RxString networkUserImage = "".obs;
  Rx<TextEditingController> fullname = TextEditingController().obs;

  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> aboutus = TextEditingController().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  RxString gender = "male".obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  RxString countryCode = "+1".obs;
  RxString? phoneNumber = ''.obs;

  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  RxList<String> hobbies = <String>[].obs;
  RxList<String> intrests = <String>[].obs;
  final FocusNode focusPass=FocusNode();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxString currentUserEmail = "".obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    getUserDetail();



  }

// ================================ Get UserData form Local

  void getUserDetail() async {

    currentUserEmail.value = await DatabaseHandler().getCurrentEmail();
    userData.value = await DatabaseHandler().getUserData();
    print("pref token: ${ await DatabaseHandler().getToken()}");
    UserModel result = await getUserProfile();
    print("o-b-j-e-c-t");
    fullname.value.text = userData.value.username!;
    email.value.text = currentUserEmail.value;
    networkUserImage.value = result.profileImage!;

    if(userData.value.profile!=null){
      aboutus.value.text = userData.value.profile!.description!;
      age.value.text = userData.value.profile!.age!;
      gender.value = userData.value.profile!.gender!.isNotEmpty ? userData.value.profile!.gender! : "male";
      countryCode.value = userData.value.profile!.phoneCode!.isNotEmpty ? userData.value.profile!.phoneCode! : "+1";;
      location.value.text = userData.value.profile!.location!;
      hobbies.value = userData.value.profile!.hobbies!;
      intrests.value = userData.value.profile!.interests!;
      getPhoneNumber(userData.value.profile!.phoneNumber!,userData.value.profile!.phoneCode!);
    }


  }

  void getPhoneNumber(String mobileNumber,String dialCode) async {

    try {

      String? isoCode = await PhoneNumber.getISO2CodeByPrefix(dialCode);
      PhoneNumber? number = await PhoneNumber.getRegionInfoFromPhoneNumber(mobileNumber,isoCode!);
      initialPhone.value = PhoneNumber(isoCode: isoCode);
      phone.value.text = number.parseNumber().substring(1);
      phoneNumber!.value = number.parseNumber().substring(1);
    } catch(e) {
      print("This phone number is not a valid number $e");
    }
  }


// ================================ Camera Open Method

  void camera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera,imageQuality: AppInteger.IMAGE_QUALITY);
    if (photo != null) {
      Util.compressFile(photo).then((value) {
        userImage.value = File(value!.path);
      });
    } else {
      print('No image selected.');
    }
  }

// ================================ Gallery Open Method
  void photo() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery,imageQuality: AppInteger.IMAGE_QUALITY);
    if (photo != null) {
      Util.compressFile(photo).then((value) {
        userImage.value = File(value!.path);
      });
    } else {
      print('No image selected.');
    }
  }

  /*Future<void> _cropImage(path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath:path,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      userImage.value = File(croppedFile.path);
    }
  }*/

// ================================ Create Profile Method

  void createProfile() async {
    if (userImage.value.path.isEmpty && networkUserImage.isEmpty) {
      Toast().error(massage: "Please Choose your Display Picture");
      return;
    }
    if (age.value.text == "") {
      Toast().error(massage: "Please enter your Age");
      return;
    }
    if (int.parse(age.value.text) <= 0) {
      Toast().error(massage: "Please enter valid age");
      return;
    }
    if (phone.value.text == "") {
      Toast().error(massage: "Please enter your phone number");
      return;
    }
    String? profileImageURL;
    isLoading.value = true;
    if (userImage.value.path.isNotEmpty) {
      print("with Image");
      profileImageURL = await onUploadPicture(imagefile: userImage.value);
    }

    print("withoutImage");
    Map data = {
      "profileImage": profileImageURL ?? networkUserImage.value,
      "fullName": fullname.value.text,
      "email": email.value.text,
      "phoneCode": countryCode.value,
      "phoneNumber": phoneNumber!.value,
      "description": aboutus.value.text,
      "gender": gender.value,
      "age": age.value.text,
      "location": location.value.text,
      "hobbies": hobbies,
      "interests": intrests,
    };

    log("userID=<< $data");
    UserModel result = await onCreateProfile(data: data);
    if (result.userId!.isNotEmpty) {
      isLoading.value = false;
      print("object---->>>>>>>>");
      if(result.role == "user"){
        Get.offAllNamed(AppRoutes.SUCCESSFULLY_SETUP_PROFILE);
      }else{
        Get.offAllNamed(AppRoutes.NAV_ROOT);
      }
    } else {
      isLoading.value = false;
    }

    print("Update Profile");
  }

  // ================================ Create Profile Method

  void updateProfile(bool isSetupProfile) async {
    if (age.value.text == "") {
      Toast().error(massage: "Please enter your Age");
      return;
    }
    if (int.parse(age.value.text) <= 0) {
      Toast().error(massage: "Please enter valid age");
      return;
    }
    if (phone.value.text == "") {
      Toast().error(massage: "Please enter your phone number");
      return;
    }
    String? profileImageURL;
    isLoading.value = true;
    if (userImage.value.path.isNotEmpty) {
      print("with Image");
      profileImageURL = await onUploadPicture(imagefile: userImage.value);
    }
    print(profileImageURL);
    print("userID ${userData.value.sId}");
    print("withoutImage");
    print(userData.value.sId);
    userData.value.username = fullname.value.text;
    userData.value.profileImage = userImage.value.path;
    userData.value.profile!.age = age.value.text;
    userData.value.profile!.description = aboutus.value.text;
    userData.value.profile!.phoneCode = countryCode.value;
    userData.value.email = email.value.text;
    userData.value.profile!.location = location.value.text;
    userData.value.profile!.gender = gender.value;
    userData.value.profile!.hobbies = hobbies.value;
    userData.value.profile!.interests = intrests.value;
    userData.value.profile!.phoneNumber = phoneNumber!.value;
    userData.value.profileImage = profileImageURL ?? networkUserImage.value;

    Map updatedProfile = UserModel.toJsonUpdateProfile(userData.value);
    print(updatedProfile);

    UserModel result = await onUpdateProfile(
      data: updatedProfile,
    );
    isLoading.value = false;
    print("Update Profile");
    Get.find<ProfileViewModel>().userProfileData.value = result;
    networkUserImage.value = result.profileImage!;
    getPhoneNumber(userData.value.profile!.phoneNumber!,userData.value.profile!.phoneCode!);
    Get.back();
  }
}
