import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/payment_module/add_card/service/card_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/service/payment/stripe_service.dart';

class AddCardViewModel extends GetxController with CardService{

  final CardFormEditController cardController = CardFormEditController();
  final CardEditController cardEditController = CardEditController();

  final RxBool isLoading=false.obs,isComplete=false.obs;

  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  @override
  void onInit() {
    getUserDetail();
    super.onInit();
  }


  Future<void> getUserDetail() async {
    userData.value = await DatabaseHandler().getUserData();
   // userData.value.userEmail=await DatabaseHandler().getCurrentEmail();
    print("user email: ${userData.value.role} ${userData.value.email}");
  }

  Future<void> addCard() async{
    isLoading.value=true;
    String? pm_id=await StripeService.createPaymentMethod(userData.value.email!);
    bool stat=false;
    if(pm_id!=null) {
      stat=await onCreateCard({"pm_id":pm_id});
    }
    isLoading.value=false;
    if(stat){
      AppNavigator.pop(result: stat);
    }
  }


}