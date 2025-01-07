import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart'; 
import '../../../Utils/Common/custom_glass_dialog.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../Home Module/View/Components/shimmer_view.dart';
import '../View Model/notification_vm.dart';
import 'Components/notification_tile.dart';


class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);
  final _notificatioVM = Get.find<NotificationViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showBackBtn:true,
        appBarTitle: "Notifications",
        isLeftAlign: true,
        showLeading: true,
        basicAppTrailingIcon: GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.notificationSetting);
          },
          child: Padding(
            padding: AppSizer.getPadding(all: 15),
            child: Image.asset(
              AppImages.imgSetting,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       /*     AppText(
              text: "Here you can see your all notifications",
              overflow: TextOverflow.visible,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),
            SizedBox(height: 10,),*/

            Obx(() => _notificatioVM.listOfNotification.isNotEmpty
                ? Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async {
                      _notificatioVM.listOfNotification.clear();
                      _notificatioVM.isLoading.value = true;
                      _notificatioVM.getNotification();
                    },
                    child: SingleChildScrollView(
                      child: Column(
              children: [
                      Visibility(
                        visible:_notificatioVM.listOfNotification.first.types!.today!.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            AppText(
                              text: "Today",
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                            ),
                            SizedBox(height: 15,),
                            ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _notificatioVM.listOfNotification.first.types!.today!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10.0),
                                  child: notificationTile(
                                    context: context,
                                    data: _notificatioVM.listOfNotification.first.types!.today![index],
                                    callback: (String notiID) async {
                                      await showDialog(
                                        context: context,
                                        useSafeArea: false,
                                        builder: (context) =>
                                            NotificationDeleteTileView(
                                              callback: () async {
                                                Navigator.pop(context);
                                                EasyLoading.show(
                                                  status: 'Please Wait . . .',
                                                  indicator: CupertinoActivityIndicator(
                                                    color: AppColors.whiteText,
                                                    radius: SizeConfig.screenWidth * 0.05,
                                                  ),
                                                );
                                                await _notificatioVM.deleteNotification(notiID).then((value) {
                                                  EasyLoading.dismiss();
                                                  _notificatioVM.listOfNotification.first.types!.today!.removeAt(index);
                                                  _notificatioVM.listOfNotification.refresh();
                                                });

                                              },
                                            ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:_notificatioVM.listOfNotification.first.types!.yesterday!.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            AppText(
                              text: "Yesterday",
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                            ),
                            SizedBox(height: 15,),
                            ListView.builder(

                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: _notificatioVM.listOfNotification.first.types!.yesterday!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10.0),
                                  child: notificationTile(
                                    context: context,
                                    data: _notificatioVM.listOfNotification.first.types!.yesterday![index],
                                    callback: (String notiID) async {
                                      await showDialog(
                                        context: context,
                                        useSafeArea: false,
                                        builder: (context) =>
                                            NotificationDeleteTileView(
                                              callback: () async {
                                                Navigator.pop(context);
                                                EasyLoading.show(
                                                  status: 'Please Wait . . .',
                                                  indicator: CupertinoActivityIndicator(
                                                    color: AppColors.whiteText,
                                                    radius: SizeConfig.screenWidth * 0.05,
                                                  ),
                                                );
                                                await _notificatioVM.deleteNotification(notiID).then((value) {
                                                  EasyLoading.dismiss();
                                                  _notificatioVM.listOfNotification.first.types!.yesterday!.removeAt(index);
                                                  _notificatioVM.listOfNotification.refresh();
                                                });
                                              },
                                            ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:_notificatioVM.listOfNotification.first.types!.thisWeek!.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            AppText(
                              text: "This Week",
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                            ),
                            SizedBox(height: 15,),
                            ListView.builder(

                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: _notificatioVM.listOfNotification.first.types!.thisWeek!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10.0),
                                  child: notificationTile(
                                    context: context,
                                    data: _notificatioVM.listOfNotification.first.types!.thisWeek![index],
                                    callback: (String notiID) async {
                                      await showDialog(
                                        context: context,
                                        useSafeArea: false,
                                        builder: (context) =>
                                            NotificationDeleteTileView(
                                              callback: () async {
                                                Navigator.pop(context);
                                                EasyLoading.show(
                                                  status: 'Please Wait . . .',
                                                  indicator: CupertinoActivityIndicator(
                                                    color: AppColors.whiteText,
                                                    radius: SizeConfig.screenWidth * 0.05,
                                                  ),
                                                );
                                                await _notificatioVM.deleteNotification(notiID).then((value) {
                                                  EasyLoading.dismiss();
                                                  _notificatioVM.listOfNotification.first.types!.thisWeek!.removeAt(index);
                                                  _notificatioVM.listOfNotification.refresh();
                                                });
                                              },
                                            ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:_notificatioVM.listOfNotification.first.types!.older!.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            AppText(
                              text: "Older",
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                            ),
                            SizedBox(height: 15,),
                            ListView.builder(

                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              reverse: true,
                              itemCount: _notificatioVM.listOfNotification.first.types!.older!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10.0),
                                  child: notificationTile(
                                    context: context,
                                    data: _notificatioVM.listOfNotification.first.types!.older![index],
                                    callback: (String notiID) async {
                                      await showDialog(
                                        context: context,
                                        useSafeArea: false,
                                        builder: (context) =>
                                            NotificationDeleteTileView(
                                              callback: () async {
                                                Navigator.pop(context);
                                                EasyLoading.show(
                                                  status: 'Please Wait . . .',
                                                  indicator: CupertinoActivityIndicator(
                                                    color: AppColors.whiteText,
                                                    radius: SizeConfig.screenWidth * 0.05,
                                                  ),
                                                );
                                                await _notificatioVM.deleteNotification(notiID).then((value) {
                                                  EasyLoading.dismiss();
                                                  _notificatioVM.listOfNotification.first.types!.older!.removeAt(index);
                                                  _notificatioVM.listOfNotification.refresh();
                                                });
                                              },
                                            ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
                    ),
                  ),
                )
                : _notificatioVM.isLoading.value
                ? notificationShimmer()
                :Container(
              height: AppSizer.height*0.7,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Center(
                child: AppText(
                  text: "No Notifications",
                ),
              ),
            ),)
          ],
        ));
  }
}

class NotificationDeleteTileView extends StatelessWidget {
  final Function() callback;

  NotificationDeleteTileView({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: CustomGlassDialog(
          title: "You sure...?",
          firstButtonContent: 'Yes',
          secondButtonContent: "No I'm Not",
          showContent: false,
          firstCallback: callback,
        secondCallback: (){
          Get.back();
        },
      )
    );
  }
}

