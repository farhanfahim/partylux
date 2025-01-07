
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:uuid/uuid.dart';

class HelperFunction {
  static const String PASSWORD_VALIDATE = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

  static String? passwordValidate(String value) {
    value = value.trim();
    if (value.isEmpty || value == "") {
      return "Password required";
    }
   else if (value.length<6) {
      return "Password is too short. Minimum length is 6 characters.";
    }
    else if (!RegExp(PASSWORD_VALIDATE).hasMatch(value)) {
      return "Password must be consist on 1 Uppercase,1 Lowercase,\n1 Number and 1 Special Character";
    }
    else {
      return null;
    }
  }

  static String? newCurrentPasswordValidate(String value,String value2) {
    value = value.trim();
    if (value.isEmpty || value == "") {
      return "Password required";
    }
    else if (value.length<6) {
      return "Password is too short. Minimum length is 6 characters.";
    }
    else if (!RegExp(PASSWORD_VALIDATE).hasMatch(value)) {
      return "Password must be consist on 1 Uppercase,1 Lowercase,\n1 Number and 1 Special Character";
    }
    else if (value == value2) {
      return "Current and new passwords must be different.";
    }
    else {
      return null;
    }
  }

  static String? emptyValitate(String value, {String field = "This field"}) {
    if (value.isEmpty) {
      return "$field ${AppStrings.txtCannotBeEmpty}";
    } else {
      return null;
    }
  }


  // static String? passwordValidateWithRegix(String value) {
  //   RegExp regex =
  //   RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //
  //   // RegExp(r'^(?=.*[A-Z])([a-z0-9!@#\$&*~].*){8,}$');
  //
  //   if (value.isEmpty || value == "") {
  //     return "Password required";
  //   }
  //   if (!regex.hasMatch(value)) {
  //     // return 'Password must be 1 capital letter';
  //     return 'Password must be 8 characters, 1 capital, 1 numeric and 1 special character';
  //   } else {
  //     return null;
  //   }
  // }

  static String? dobValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Date of Birth field";
    } else {
      return null;
    }
  }

  static String? ethnicityValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Ethnicity cannot be empty";
    } else {
      return null;
    }
  }

  static String? genderValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Sex cannot be empty";
    } else {
      return null;
    }
  }

  static String? heightValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Height cannot be empty";
    } else {
      return null;
    }
  }

  static String? heightFeetValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Height cannot be empty";
    }
    // else if(int.parse(value) < 3){
    //   return "Height must be\nat-least 1 feet 8 inch.";
    // }
    else {
      return null;
    }
  }

  static String? heightInchesValidator(String value, {String? feet}) {
    if (value.isEmpty || value == "") {
      return "Height cannot be empty";
    }
    if (feet!.isEmpty || (int.parse(feet) == 1 && int.parse(value) < 8)) {
      return "Height must be\nat-least 1 feet 8 inch.";
    } else {
      return null;
    }
  }

  static String? weightValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Weight cannot be empty";
    }
    // else if(int.parse(value) < 55 || int.parse(value) > 662){
    //   return "Weight must be between 55-661 lb.";
    // }
    else {
      return null;
    }
  }

  static String? confirmPasswordValidate(String value, String otherPassword) {
    value = value.trim();
    if (value.isEmpty || value == "") {
      return "Confirm Password Required";
    }
    else if (value.length<6) {
      return "Confirm Password is too short. Minimum length is 6 characters.";
    }
    else if (!RegExp(PASSWORD_VALIDATE).hasMatch(value)) {
      return "Password must be consist on 1 Uppercase, 1 Lowercase,\n 1 Number and 1 Alphabet";
    } else if (value != otherPassword) {
      return "Password and Retype password must be same";
    } else {
      return null;
    }
  }

  static String? hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    // if (value.length == 0) {
    //   return 'URL cannot be empty';
    // }
    // else
    if (value.isNotEmpty && !regExp.hasMatch(value)) {
      return 'Please enter valid url';
    }
    return null;
  }

  static String? emailValidate(String value) {
    var emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (value.isEmpty || value == "") {
      return "Email required";
    }
    if (!emailRegex.hasMatch(value)) {
      return "Invalid Email Address";
    } else {
      return null;
    }
  }

  static String? fieldValidator(String value,String label ) {
    if (value.isEmpty || value == "") {
      return "$label is required!";
    } else {
      return null;
    }
  }

  static String? confirmDeleteValidator(String value ) {
    if (value.isEmpty || value == "") {
      return "Delete field cannot be empty";
    } else {
      return null;
    }
  }

  static String? fullNameFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return "Full name required";
    } else if (value.length > 51) {
      return 'Full Name required';
    } else {
      return null;
    }
  }

  static String? companyFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return "Company name required";
    } else if (value.length > 25) {
      return 'Company Name cannot be greater than 100 characters';
    } else {
      return null;
    }
  }

  static String? dotNumberFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return "Dot Number required";
    } else {
      return null;
    }
  }

  static String? mcNumberFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return "MC Number required";
    } else {
      return null;
    }
  }

  static String? bioFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Bio field required";
    } else {
      return null;
    }
  }

  static String? generalFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "msg_this_field_is_required".tr;
    } else {
      return null;
    }
  }

  static String? contactNumberFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return null;
    }
    if (value.length < 10) {
      return "Contact number must be greater than 10";
    } else {
      return null;
    }
  }

  static String? otpCodeValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Verification code required";
    }
    if (value.length < 4) {
      return "Verification code must be of 4 digits";
    } else {
      return null;
    }
  }

  static String? cardHolderNameFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Card holder name field cannot be empty";
    } else {
      return null;
    }
  }

  static String? cardNumberFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Card number field cannot be empty";
    }
    if (value == "0000 0000 0000 0000") {
      return "Invalid card number";
    }
    if (value.length < 19) {
      return "Invalid card number";
    } else {
      return null;
    }
  }

  static String? cVVFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "CVV field cannot be empty";
    }
    if (value == "000") {
      return "Invalid CVV number";
    }
    if (value == "0000") {
      return "Invalid CVV number";
    }
    if (value.length < 3) {
      return "Invalid CVV number";
    } else {
      return null;
    }
  }

  static String? expiryFieldValidator(String value,bool expiry) {
    if (value.isEmpty || value == "") {
      return "Expiry field cannot be empty";
    }if (value.length < 5 || expiry == false) {
      return "Invalid expiry ";
    } else {
      return null;
    }
  }

  static String? nameFieldValidators(String value) {
    if (value.isEmpty || value == "") {
      return "Name field cannot be empty";
    } else {
      return null;
    }
  }

  static String? promoCodeValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Promo code field cannot be empty";
    } else {
      return null;
    }
  }

  static String? cancelReasonValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Detail field in required";
    } else {
      return null;
    }
  }

}


class RandomGenerator{

  static String generateRandomString(){
    //math.Random.secure();
    return "";
  }

  static String generateRandomString2(){
    var uuid = Uuid();
    return uuid.v1();
  }

}