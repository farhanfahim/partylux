import 'package:get/get.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';

class CategorySelectionViewModel extends GetxController {

  final RxString selected=EventModel.CATEGORY_CLUB.obs;

  @override
  void onInit() {
    super.onInit();
  }


}