import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BankAccountInfoViewModel extends GetxController {

  Rx<TextEditingController> accountNumberController = TextEditingController().obs;
  Rx<TextEditingController> routeNumberController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

  }

}
