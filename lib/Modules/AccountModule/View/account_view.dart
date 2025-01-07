// ignore_for_file: unused_local_variable, unused_field
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/AboutModule/View/Components/about_us_tile.dart';
import 'package:partylux/Modules/AccountModule/View%20Model/accountviewmodel.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/profile_vm.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/app_routes.dart';
import '../../../Constants/app_images.dart';
import 'Components/account_delete_bottom_sheet.dart';

class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);

  final _profileVM = Get.find<ProfileViewModel>();
  final _accountVM = Get.find<AccountViewModel>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        body: SizedBox.expand(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              primaryAppBar(
                context: context,
                title: "Account Details",
                subTitle:
                    "Here you can filter  the events and\nget your desired event ",
                callback: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Column(
                children: [
                  Visibility(
                    visible:
                        _profileVM.userProfileData.value.role! != "business",
                    child: Column(
                      children: [
                        aboutUsTile(
                          context: context,
                          title: "Become A Partner",
                          image: AppImages.imgIcPartner,
                          callback: () {
                            Get.toNamed(AppRoutes.becomeAPartnerView);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  aboutUsTile(
                      context: context,
                      title: "Membership",
                      image: AppImages.imgMembership,
                      callback: () {
                        Get.toNamed(AppRoutes.memberShipView);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  aboutUsTile(
                    context: context,
                    title: "Account Delete",
                    image: AppImages.imgDeleteAccount,
                    callback: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.transparent,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: accountDeleteBottomSheet(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              // AppButton.mainButton(
              //   context,
              //   text: "Save",
              //   onPressed: () {},
              // ),
            ],
          ),
        ));
  }
}
