// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/AboutModule/Service/faqs_service.dart';

class SupportViewModel extends GetxController with FAQsService {
  // RxList<Faqsmodel> faqsList = <Faqsmodel>[].obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> message = TextEditingController().obs;
  Rx<TextEditingController> name = TextEditingController().obs;

  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getDataFAQs() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      bool result = await onPostSupport(
        email: email.value.text,
        message: message.value.text,
        name: name.value.text,
      );
      isLoading.value = false; 
    }
  }
}
