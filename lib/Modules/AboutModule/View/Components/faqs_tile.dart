import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';

import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/AboutModule/Model/faqs_model.dart';
import 'dart:math' as math;
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/Theme/app_config.dart';
import '../../../../Utils/Theme/app_text.dart';

class FaqsTile extends StatefulWidget {
  final Faqsmodel faqsModel;
  FaqsTile({
    Key? key,
    required this.faqsModel,
  }) : super(key: key);

  @override
  State<FaqsTile> createState() => _FaqsTileState();
}

class _FaqsTileState extends State<FaqsTile> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: SizedBox(
        child: Column(children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isShow = !isShow;
              });
            },
            child: Material(
              elevation: 4,
              color: AppColors.whiteText.withOpacity(0.1),
                borderRadius: isShow?BorderRadius.only(topLeft :Radius.circular(10),topRight: Radius.circular(10)):BorderRadius.circular(10),
              child: Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteText.withOpacity(0.05),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    child: AppText(
                      color: AppColors.iconColor,
                      text: widget.faqsModel.question,
                      fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                      height: 1,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                      Image(
                        image: AssetImage(AppImages.imgArrowDown),
                        height: 20,
                        width: 20,
                        color: AppColors.whiteText,

                      ),
                ]),
              ),
            ),
          ),
          if (isShow)
            Container(
              width: SizeConfig.screenWidth ,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: AppColors.whiteText.withOpacity(0.1),
              ),
              child: AppText(
                text: widget.faqsModel.answer,
                color: AppColors.iconColor,
                fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w400,
              ),
            )
        ]),
      ),
    );
  }
}

//  SizedBox(
//           child: Column(children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isShow = !isShow;
//                 });
//               },
//               child: Container(
//                 height: 64,
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: AppColors.whiteText.withOpacity(0.1),
//                 ),
//                 child:
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   Expanded(
//                     child: AppText(
//                         text: widget.faqsModel.question,
//                         // color: AppColor.white,

//                         fontSize: 12,
//                         overflow: TextOverflow.clip,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   isShow
//                       ? ImageIcon(
//                           const AssetImage(
//                               "assets/icon_assets/about/arrow_down_round.png"),
//                           color: AppColors.whiteText,
//                           size: 25,
//                         )
//                       : ImageIcon(
//                           const AssetImage(
//                               "assets/icon_assets/about/arrow_up.png"),
//                           color: AppColors.whiteText,
//                           size: 25,
//                         )
//                 ]),
//               ),
//             ),
//             if (isShow)
//               Container(
//                 width: SizeConfig.screenWidth,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 margin: EdgeInsets.only(
//                   top: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: AppColors.whiteText.withOpacity(0.1),
//                 ),
//                 child: AppText(
//                     text: widget.faqsModel.answer,
//                     // color: AppColor.white,

//                     fontSize: 12,
//                     overflow: TextOverflow.clip,
//                     fontWeight: FontWeight.w700),
//                 // Html(
//                 //   style: {
//                 //     "body": Style(
//                 //       fontSize: FontSize(12.0),
//                 //       fontWeight: FontWeight.w400,
//                 //       color: AppColors.whiteText,
//                 //     ),
//                 //   },
//                 //   data:
//                 //       """<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>""",
//                 // ),
//               )
//           ]),
//         ),
