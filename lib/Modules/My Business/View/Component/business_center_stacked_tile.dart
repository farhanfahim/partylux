import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/gradient_container.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/dimens.dart';
import '../../Model/business_detail_model.dart';


class BusinessCenterStackedTile extends StatelessWidget {

  final UserDetail profileData;
  final String? eventType;
  final BusinessDetailModel? data;

  const BusinessCenterStackedTile({super.key,required this.eventType,required this.profileData,this.data});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      isTransparent: true,
      margin: AppSizer.getMargin(left: 14,right: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: AppSizer.getSize(45),
                width: AppSizer.getSize(45),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.grey4.withOpacity(0.08),
                        width: 4)),
                child: cachedNetworkImage(
                  data!.businessProfile!,
                  radius: 18, context: context,

                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: AppText(text: data!.bussinessName!.toUpperCase(),fontSize: AppSizer.getFontSize(18),maxLines: 1,overflow: TextOverflow.ellipsis,)),

              SizedBox(width: 10,),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0],
                        colors: [
                          AppColors.redText,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(10) ,vertical: AppSizer.getVerticalSize(3)),
                    child: Center(
                      child: AppText(
                        text: "Live",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

                      ),
                    ),
                  )
                ],
              )
            ],
          ),

        ],
      )
    );
  }
}
