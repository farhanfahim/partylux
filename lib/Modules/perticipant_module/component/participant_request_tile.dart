import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Notification/Model/notification_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Util.dart';
import '../../../Constants/app_routes.dart';
import '../../../Utils/Common/cechednetworlimage.dart';
import '../../people_joined/model/order_model.dart';

Widget ParticipantRequestTile({

  required BuildContext context,
  required User data,
  required Function() accept,
  required Function() reject,
}) {
  return Container(
    padding: AppSizer.getPadding(left: 16,top: 10,right: 16,bottom: 10),
    margin: AppSizer.getMargin(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.whiteText.withOpacity(0.1),
    ),
    child: Row(
      children: [
        Container(
          width:AppSizer.getSize(44),
          height:AppSizer.getSize(44),
          decoration: BoxDecoration(
            color: AppColors.female.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: GestureDetector(
            onTap: (){
              Get.toNamed(
                  AppRoutes.imageView,
                  arguments: [  data.profileImage!,]
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: cachedNetworkImage(
                  data.profileImage!,
                  context: context),
            ),
          ),
        ),

        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      text: data.username!,
                      fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                    ),
                  ),

                  GestureDetector(
                    onTap: reject,
                    child: Container(
                      width:AppSizer.getSize(30),
                      height:AppSizer.getSize(30),
                      decoration: BoxDecoration(
                        color: AppColors.whiteText.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding:AppSizer.getPadding(all: 5),
                        child: Image.asset(
                          AppImages.imgClose
                        ),
                      )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: accept,
                    child: Container(
                      width:AppSizer.getSize(30),
                      height:AppSizer.getSize(30),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0, 1],
                          colors: [
                            AppColors.primary,
                            AppColors.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding:AppSizer.getPadding(all: 6),
                        child: Image.asset(
                          AppImages.imgCheck
                        ),
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
