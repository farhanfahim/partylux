import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/extensions.dart';

import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../Auth Module/Models/usermodel.dart';

class TopFiveLiveBusinessTile extends StatelessWidget {
  final BecomePartnerModel data;
  final UserModel currentUser;
  const TopFiveLiveBusinessTile(
      {super.key, required this.data, required this.currentUser});

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String dayOfWeek = getDayOfWeek(now.weekday);
    var currentBusinessDay = data.businessWeek!.where((obj) => obj.bussinessDay == dayOfWeek).toList();

    print(data.bussinessName);
    print(currentBusinessDay.first.toJson());
    return GestureDetector(
      onTap: () {
        if(currentUser.sId == data.userId) {
          Get.toNamed(
              AppRoutes.showMyBusiness, arguments: [data.id, "live", true]);
        }else{
          Get.toNamed(
              AppRoutes.showMyBusiness, arguments: [data.id, "live", false]);
        }
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.20,
        margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [

                Container(
                  height: SizeConfig.screenWidth * 0.20,
                  width: SizeConfig.screenWidth * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: cachedNetworkImage(
                    data.photos!.first,
                    context: context,
                    borderRadius: 100,
                  ),
                ),
                Positioned(top:5,right:9,child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.redText,
                  ),
                ),),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.02),
              child: AppText(
                text: data.bussinessName!, //"Club Party",
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amountCalculate({
    required String amount,
    required bool isFree,
  }) {
    return AppText(
      text: isFree ? "Free" : amount,
      fontSize: SizeConfig.screenWidth * 0.045,
      
    );
  }

  String dateFormater(String date) {
    String? result;
    if (date.length > 15) {
      result = DateFormat('hh:mm a').format(DateTime.parse(date));
    } else {
      result = date;
    }
    return result;
  }

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thursday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
      default:
        return "invalid day";
    }
  }
}
