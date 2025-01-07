import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/profile_vm.dart';
import 'package:partylux/Utils/Common/profile_section_tile.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/Components/user_detail_tile.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../../../Utils/Common/custom_alert_dialog.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Utils/Common/custom_info_dialog.dart';
import '../../../../Utils/Theme/app_config.dart';
import '../../../../Utils/buttons/dg_main_button.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final _profileVM = Get.find<ProfileViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      isLeftAlign: false,
      hideAppBar: true,
      body: SafeArea(
        child: _profileVM.userProfileData.value.sId!=null
            ?Column(
          children: [
            SizedBox(height: 30),
            UserDetailTile(),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                controller: _profileVM.scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                children: [
                          Obx(() => _profileVM.userProfileData.value.role == "business"?
                          AppButton.mainButton(
                            widget:SvgPicture.asset(
                                AppImages.icAdd
                            ),
                            context,
                            text: AppStrings.createFlyer,
                            loading:false,
                            onPressed: () {
                              Get.toNamed(AppRoutes.createFlyer);
                            },
                          ):Container(),
                          ),
                  SizedBox(height: _profileVM.userProfileData.value.role == "business" ? SizeConfig.screenWidth * 0.015 : 0),
                  ProfileSectionTile(
                    title: AppStrings.profile,
                    iconPath: AppImages.icProfile,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.My_PROFILE,
                      );
                    },
                  ),
                  ProfileSectionTile(
                    title: AppStrings.myBusiness,
                    iconPath: AppImages.icBusiness,
                    onTap: () {
                      if (_profileVM.userProfileData.value.role == "business") {
                        Get.toNamed(AppRoutes.myBusinessView);
                      } else {
                        Get.toNamed(AppRoutes.becomeAPartnerView);
                      }
                    },
                  ),
                  ProfileSectionTile(
                    title: AppStrings.barcodeTicketScanner,
                    iconPath: AppImages.icBarcode,
                    onTap: () {
                      Get.toNamed(AppRoutes.barcodeScanner);
                    },
                  ),
                  _profileVM.userProfileData.value.role != "business"
                      ? ProfileSectionTile(
                          title: AppStrings.myTicker,
                          iconPath: AppImages.icTicket,
                          onTap: () {
                            Get.toNamed(AppRoutes.ticketView);
                          },
                        )
                      : Container(),
                  ProfileSectionTile(
                    title: AppStrings.notification,
                    iconPath: AppImages.icNotification,
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationView);
                    },
                  ),
                  /* ProfileSectionTile(
                    title: AppStrings.wallet,
                    iconPath: AppImages.icWallet,
                    onTap: () {
                      Get.toNamed(AppRoutes.walletView);
                    },
                  ),*/
                  ProfileSectionTile(
                    title: AppStrings.paymentMethod,
                    iconPath: AppImages.icPayment,
                    onTap: () {
                      Get.toNamed(AppRoutes.paymentMethodView,);
                    },
                  ),
                  ProfileSectionTile(
                    title: AppStrings.aboutUs,
                    iconPath: AppImages.icAbout,
                    onTap: () {
                      Get.toNamed(AppRoutes.aboutView);
                    },
                  ),
                  ProfileSectionTile(
                    title: "Account Delete",
                    isPng: true,
                    iconPath: AppImages.imgDeleteAccount,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ct) {
                            return CustomAlertDialog(
                              title: AppStrings.deleteAccount,
                              content: AppStrings.areYouSureYouWantToDelete,
                              firstButtonContent: AppStrings.cancel,
                              secondButtonContent: AppStrings.delete,
                              secondBtnColor: AppColors.redMidText,
                              first: () {
                                Get.back();
                              },
                              second: () async {
                                Get.back();
                                _profileVM.deleteAccount();
                              },
                            );
                          });
                    },
                  ),
                  ProfileSectionTile(
                    isPng: true,
                    title: AppStrings.logout,
                    iconPath: AppImages.imgLogout,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ct) {
                            return CustomAlertDialog(
                              title: AppStrings.logout,
                              content: AppStrings.areYouSureYouWantToLogout,
                              firstButtonContent: AppStrings.cancel,
                              secondButtonContent: AppStrings.logout,
                              secondBtnColor: AppColors.redMidText,
                              first: () {
                                Get.back();
                              },
                              second: () async {
                                _profileVM.logout();
                              },
                            );
                          });
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        )
            :Center(child: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),),
      ),
    );
  }
}
