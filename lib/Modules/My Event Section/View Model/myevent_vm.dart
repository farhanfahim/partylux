import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/My%20Event%20Section/Service/my_event_service.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/navigation.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_glass_dialog.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../Home Module/View Model/home_vm.dart';
import '../Model/chip_in_model.dart';
import '../Model/event_detail_model.dart';

class MyEventViewModel extends GetxController with MyEventService {
  RxBool isLoading = true.obs;
  RxBool isBtnLoading = false.obs;
  RxBool isFavouriteLocal = false.obs;
  RxInt currentIndex = 0.obs;
  Rx<EventDetailModel> eventDetailModel = EventDetailModel().obs;
  RxList<UserDetails> listOfUsers = List<UserDetails>.empty().obs;
  RxList<UserDetails> listOfMales = List<UserDetails>.empty().obs;
  RxList<UserDetails> listOfFemales = List<UserDetails>.empty().obs;
  RxList<OrderModel> listOfOrderRequest = List<OrderModel>.empty().obs;
  final Rx<TextEditingController> partyCodeController = TextEditingController().obs;
  RxBool isCheckTerms = false.obs;

  EventModel? eventModel;

  RxList<ChipInModel> chipInList = List<ChipInModel>.empty().obs;
  Rx<UserModel> userData = UserModel.fromEmpty().obs;

  late String eventId;

  RxString eventType = "".obs;

  @override
  Future<void> onInit() async {
    var arguments = Get.arguments;
    print("get arguments: ${arguments}");
    eventId = arguments[0];
    eventType.value = arguments[1];
    super.onInit();
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();
    getEventDetail(eventId);
  }

  void getOrders(String id) async {
    await getPendingOrdersApi(eventId: id).then((value) {
      listOfOrderRequest.value = value;
      if (listOfOrderRequest.isNotEmpty) {
        showRequestPopUp();
      }
    });
  }

  onChangeSelectedPageIndex(int num) {
    currentIndex.value = num;
    currentIndex.refresh();
  }

  void getEventDetail(String id) async {
    await getEventDetailApi(id).then((value) {
      if (value != null) {
        isLoading.value = false;
        eventDetailModel.value = value;
        log("event detail json: ${jsonEncode(value.toJson())}");
        eventModel = EventModel.fromJson(value.toJson());
        print("share url: ${eventModel?.shareUrl}");

        print(eventDetailModel.value.startDateTime);
        if (eventType.value == Constants.EVENT_UN_KNOWN) {
          if (userData.value.sId == eventDetailModel.value.userId) {
            eventType.value = Constants.EVENT_MY_EVENT;
            getOrders(Get.arguments[0]);
          } else {
            // this event is other
          //  print(""eventDetailModel.value.eventType!);
           // eventType.value = Constants.EVENT_OTHER;
            print("new event: ${eventDetailModel.value.eventType!}");
            eventType.value=eventDetailModel.value.eventType!;
          }
        } else {
          if (eventType.value == Constants.EVENT_MY_EVENT) {
            getOrders(Get.arguments[0]);
          }
        }

        if (eventDetailModel.value.isFavourite!) {
          isFavouriteLocal.value = true;
        } else {
          isFavouriteLocal.value = false;
        }

        listOfUsers.clear();
        listOfMales.clear();
        listOfFemales.clear();
        for (var item in eventDetailModel.value.getTotalOrdersSummary!) {
          if (item.males!.length > 0) {
            for (var subItem in item.males!) {
              listOfUsers.add(subItem.userDetails!);
              listOfMales.add(subItem.userDetails!);
            }
          }
          if (item.females!.length > 0) {
            for (var subItem in item.females!) {
              listOfUsers.add(subItem.userDetails!);
              listOfFemales.add(subItem.userDetails!);
            }
          }
        }

        if (eventDetailModel.value.venmo!.isNotEmpty) {
          chipInList.add(ChipInModel(image: AppImages.imgVenmo, code: eventDetailModel.value.venmo!));
        }
        if (eventDetailModel.value.cashApp!.isNotEmpty) {
          chipInList.add(ChipInModel(image: AppImages.imgCashapp, code: eventDetailModel.value.cashApp!));
        }
        if (eventDetailModel.value.benifitPay!.isNotEmpty) {
          chipInList.add(ChipInModel(image: AppImages.imgBenefitPay, code: eventDetailModel.value.benifitPay!));
        }
      }
    });

    log(eventDetailModel.toJson().toString());
  }

  void deleteEvent({required BuildContext context, required String eventID}) async {
    bool isDeleteEvent = await onDeleteEvent(eventID: eventID);
    print("farahn");
    print(isDeleteEvent);
    if (isDeleteEvent) {
      Navigator.pop(context);
      Navigator.pop(context, true);
    }
  }

  Future<bool> reserveEvent(isFree, eventType, context) async {
    if (isCheckTerms.value) {
      print("event type: ${eventType}");
      if (eventType == Constants.EVENT_PRIVATE) {
        Util.showBottomSheet(context, screenTitle: AppStrings.partyCode, saveTap: () {
          Get.back();
        },
            widget: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: AppSizer.getPadding(left: 16, right: 16, top: 10, bottom: 10),
                  child: CustomTextField(
                    controller: partyCodeController.value,
                    maxLength: 100,
                    textAlign: TextAlign.center,
                    hintText: AppStrings.enterACode,
                  ),
                ),
                Obx(
                  () => Container(
                    padding: AppSizer.getPadding(left: 16, right: 16, top: 10, bottom: 10),
                    child: AppButton.mainButton(
                      context,
                      text: AppStrings.proceed,
                      loading: isBtnLoading.value,
                      onPressed: () {
                        isBtnLoading.value = true;
                        onReserveEvent(
                                gender: userData.value.profile!.gender!,
                                eventID: eventDetailModel.value.sId!,
                                enteranceCode: partyCodeController.value.text)
                            .then((value) {
                          isBtnLoading.value = false;
                          if (value != null) {
                            Toast().success(massage: "Your order has been placed. Please wait for the host approval");
                            AppNavigator.navigateToNamedUntil(AppRoutes.NAV_ROOT);
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ));
        return false;
      } else {
        EasyLoading.show(
          status: 'Please Wait . . .',
          indicator: CupertinoActivityIndicator(
            color: AppColors.whiteText,
            radius: SizeConfig.screenWidth * 0.05,
          ),
        );
        onReserveEvent(gender: userData.value.profile!.gender!, eventID: eventDetailModel.value.sId!, enteranceCode: "").then((value) async {
          EasyLoading.dismiss();
          if (value != null) {
            if (isFree) {
              Get.toNamed(
                AppRoutes.ticketDetailView,
                arguments: [value.sId, "business"],
              );
            } else {
              AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
                Constants.paramFrom: true,
                Constants.paramFrom2: value.sId,
              });
            }
          }
        });
        await Future.delayed(Duration(seconds: 2));
        return false;
      }
    } else {
      Toast().error(massage: "Please Check Terms & Conditions");
      return false;
    }
  }

  showRequestPopUp() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return CustomGlassDialog(
            title: listOfOrderRequest.length > 1
                ? "${listOfOrderRequest.first.user!.username} with ${listOfOrderRequest.length} people"
                : "${listOfOrderRequest.first.user!.username}",
            content: AppStrings.hasSendYou,
            showContent: true,
            firstButtonContent: AppStrings.view,
            image: AppImages.imgRequest,
            firstCallback: () {
              Get.back();
              Get.toNamed(
                AppRoutes.participantsTab,
                arguments: [
                  eventDetailModel.value.maxParticipants,
                  eventDetailModel.value.totalCount,
                  eventDetailModel.value.sId,
                ],
              )!
                  .then((value) => {
                        if (value)
                          {
                            getEventDetail(Get.arguments[0]),
                          }
                      });
              ;
            },
          );
        });
  }

  void favouriteEvent(String eventId) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    Map data = {"eventId": eventId};
    await onFavoriteEvent(data: data).then((value) async {
      if (value) {
        if (isFavouriteLocal.value) {
          isFavouriteLocal.value = false;
        } else {
          isFavouriteLocal.value = true;
        }
        EasyLoading.dismiss();
      }
    });
  }
}
