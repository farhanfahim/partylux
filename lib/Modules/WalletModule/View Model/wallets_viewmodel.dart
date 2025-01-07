import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/WalletModule/Model/wallet_model.dart';
import 'package:partylux/Modules/WalletModule/Service/wallet_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';

class WalletViewModel extends GetxController with WalletService {
  @override
  void onInit() {
    super.onInit();
    onFatchMyWallet();
  }

  Rx<MyWalletModel> myWalletData = MyWalletModel.fromEmpty().obs;
  RxBool isLoading = false.obs;
  TextEditingController withDrawController = TextEditingController();
  Rx<TextEditingController> walletController = TextEditingController().obs;
  RxString currentUserEmail = "".obs;

  void onFatchMyWallet() async {
    isLoading.value = true;
    myWalletData.value = await getWallet();
    myWalletData.refresh();
    isLoading.value = false;
    currentUserEmail.value = await DatabaseHandler().getCurrentEmail();
  }
}
