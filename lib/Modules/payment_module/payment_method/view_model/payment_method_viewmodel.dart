import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/payment_module/add_card/model/card_model.dart';
import 'package:partylux/Modules/payment_module/add_card/service/card_service.dart';
import 'package:partylux/Modules/payment_module/payment_method/service/payment_service.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/page_model.dart';

import '../../../../Utils/Network/api_client.dart';
import '../../../../Utils/Network/api_urls.dart';
import '../../../../Utils/Network/cache_handler.dart';
import '../../../Auth Module/Models/usermodel.dart';
import '../../../TicketModule/Model/ticket_model.dart';
import '../../stripe_connect/view/connect_view.dart';


class PaymentMethodViewModel extends GetxController with CardService,PaymentService{

  late bool isPayment;
  final Rx<CardModel> selCard=CardModel().obs;

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  PageModel<CardModel>? cards;

  final RxBool isLoading=false.obs;

  String? order_id;

  final RxBool isOrderLoaded=false.obs;

  RxBool isDataLoading = false.obs;
  Rx<TicketModel>? orderModel = TicketModel().obs;

  Rx<UserModel> userData = UserModel.fromEmpty().obs;


  @override
  void onInit(){
    var arguments=Get.arguments;
    isPayment=arguments?[Constants.paramFrom]??false;
    order_id=arguments?[Constants.paramFrom2]??null;
    print("order id is: $order_id");
    super.onInit();
    if(order_id!=null) {
      getSingleOrderDetail(order_id!);
    }else{
      isDataLoading.value = true;
    }
    getUserDetail();
  }


  void getUserDetail() async {
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();

  }

  Future<void> advance() async{
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    String? url=await onConnectAccount({"country":"US"});
    EasyLoading.dismiss();
    if(url!=null) {
      AppNavigator.navigateTo(ConnectView(
        url: url,
        onMessage: (val) async{
          AppNavigator.pop();
          bool stat=await setConnectAccount(val);

        },
      ));
    }
  }

  Future<bool> setConnectAccount(String id) async{
    print("connect id: $id");
    bool stat=false;
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    stat=await onUpdateConnectAccount({"connected_account_id":id});
    if(stat){
      userData.value.connectedAccountId=id;
      await DatabaseHandler().setUserData(userData.value.toJson());
      userData.refresh();
    }
    EasyLoading.dismiss();
    return stat;
  }

  Future<bool> disconnectAccount(String id) async{
    print("connect id: $id");
    bool stat=false;
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    stat=await onUpdateConnectAccount({"connected_account_id":null});
    if(stat){
      userData.value.connectedAccountId=null;
      await DatabaseHandler().setUserData(userData.value.toJson());
      userData.refresh();
    }
    EasyLoading.dismiss();
    return stat;
  }


  Future<PageModel<CardModel>?> getCards({String search = "", int page = 1,}) {
    return getUserCards(page: page, search: search,paginate: false);
  }

  Future<void> deleteCard(CardModel card) async{
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    bool stat=await onDeleteCard(card.sId!);
    EasyLoading.dismiss();
    if(stat){
      pageKey.currentState?.removeItem(card);
    }
  }

/*  Future<void> nativePayCheckout(String? pay_id) async{
    if(pay_id!=null){
      Map<String,dynamic> body={
        "order_id": order_id!.sId!,
      };
    }
  }*/

  Future<void> orderCheckOut(String? pay_id) async{
    if(order_id!=null && pay_id!=null){
      isLoading.value=true;
      Map<String,dynamic> body={
        "order_id": order_id,
        "pm_id":pay_id,
      };

      print("orderCheckOut: ${jsonEncode(body)}");
      bool val=await onOrderCheckout(body);
      isLoading.value=false;
      if(val){
        AppNavigator.navigateToNamedReplace(AppRoutes.successView,arguments: {
          "type":Constants.PUSH_PAYMENT,
          "orderId":order_id!
        });
      }
    }
  }

  void getSingleOrderDetail(
      String orderId,
      ) async {
    try {
      var response = await API().get(ApiManager.GET_SINGLE_ORDERS + "$orderId");
      if (response == null) {} else if (response.data["error"] == false) {
        orderModel!.value = TicketModel.fromJson(response.data["data"]);
        print(response.data["data"]);
        isDataLoading.value = true;
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
  }

}