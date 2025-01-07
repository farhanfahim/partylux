import 'package:get/get.dart';
import 'package:partylux/Modules/AboutModule/Model/faqs_model.dart';
import 'package:partylux/Modules/AboutModule/Service/faqs_service.dart';

class FAQsViewModel extends GetxController with FAQsService {
  RxList<Faqsmodel> faqsList = <Faqsmodel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataFAQs();
  }

  getDataFAQs() async {
    faqsList.value = await onGetFAQs();
    faqsList.refresh();
    print("faqsList.value.length ${faqsList.length}");
  }
}
