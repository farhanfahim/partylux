import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/checkbox.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/custom_dotted_container.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/radio_button.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class TypeSelectContainer extends StatelessWidget {
  final String type;
  final bool selected;
  final void Function()? onTap;
  const TypeSelectContainer({Key? key,required this.type,this.selected=false,
    this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.textFieldRadius);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(16),
            horizontal:AppSizer.getHorizontalSize(22),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Row(children: [
        RadioButton().single(selected),
        SizedBox(width: AppSizer.getHorizontalSize(23),),
        AppText(text: type,fontSize: AppSizer.getFontSize(16),color: AppColors.whiteText,),
      ],),),
    );
  }
}


class SettingTile extends StatelessWidget {

  final String icon,text;
  RxBool? isChecked;
  final void Function()? onTap;
  SettingTile({Key? key,required this.text,required this.icon,this.onTap,this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconsize=AppSizer.getVerticalSize(30);
    final double radius=AppSizer.getRadius(AppDimen.conRadius);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(12)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
            color: AppColors.feildBGColor.withOpacity(0.10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Row(
          children: [
            CustomMonoIcon(icon: icon, size: iconsize,color: AppColors.whiteText,),
            Spacer(),
           Obx(() =>  CommonImageView(
             imagePath: isChecked!.value?AppImages.imgPartyCheck:AppImages.imgPartyUncheck,

             height: AppSizer.getVerticalSize(16),
             fit: BoxFit.contain,
           ),)

          ],
        ),
        SizedBox(height: AppSizer.getVerticalSize(2),),
        Row(
          children: [
            Expanded(child: AppText(text: text,fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),fontWeight: FontWeight.w400,)),
            CustomMonoIcon(icon: AppImages.imgArrowRight,size: AppSizer.getVerticalSize(12),
              isSvg: false,color: AppColors.iconColor,)
          ],
        ),
      ],),),
    );
  }
}


class AmountField extends CustomTextField{

  final void Function(bool val) onCheck;
  AmountField({super.enabled,super.validator,super.controller,
    required this.onCheck,super.readOnly,}):super(fillColor:AppColors.midGrey,
      hintText: "\$",
      dotted: true,textInputType: TextInputType.number);

  @override
  Widget? get prefix {
    return Container(width: 10,height: 10,
      padding: const EdgeInsets.only(left:9,),
      child: CheckBoxField(
        //initialValue: super.enabled!,
        initialValue: !super.readOnly!,
        simpleTitle: "",
        callback: onCheck,
      ),
    );
  }

  @override
  EdgeInsets get contentPadding => EdgeInsets.symmetric(horizontal: super.contentPadding.horizontal,
      vertical: 0);

}


class PaymentItem extends StatelessWidget {
  
  final String image,text;
  final TextEditingController controller;
  final void Function(String val)? onChanged;
  const PaymentItem({Key? key,required this.image,required this.text,this.onChanged,
    required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height=AppSizer.getVerticalSize(41);
    return Container(child: Row(children: [
      CommonImageView(
        width: height,height: height,
        imagePath: image,),
      SizedBox(width: AppSizer.getHorizontalSize(60),),
      Expanded(child: PaymentField(hintText: text,controller:controller,onChanged: onChanged,))
    ],),);
  }
}


class PaymentField extends CustomTextField{

  PaymentField({super.hintText,super.controller,super.onChanged,}):super(filled: false);

  @override
  InputBorder get enabledBorder {
    return UnderlineInputBorder(borderSide: const BorderSide(width: 0.3,color: AppColors.iconColor));
  }

  @override
  InputBorder get focusedBorder {
    return enabledBorder;
  }
  
  @override
  // TODO: implement contentPadding
  EdgeInsets get contentPadding => EdgeInsets.symmetric(horizontal: 0,vertical: AppSizer.getVerticalSize(7));

}

class CopyContainer extends StatelessWidget {

  final String text;
  final void Function()? onCopy;
  final Color bgColor;
  final Color? iconColor;
  const CopyContainer({Key? key,required this.text,this.onCopy,
    this.bgColor=AppColors.greenColor,this.iconColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconsize=AppSizer.getVerticalSize(27);
    final double radius=AppSizer.getRadius(AppDimen.conRadius);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizer.getVerticalSize(7),
          horizontal: AppSizer.getHorizontalSize(17)),
      decoration: BoxDecoration(color: bgColor,borderRadius: BorderRadius.circular(radius),),
      child: Row(children: [
      Expanded(child: AppText(text: text,fontWeight: FontWeight.w400,
        fontSize: AppSizer.getFontSize(13),)),
      GestureDetector(onTap: onCopy,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomMonoIcon(icon: AppImages.icCopy,size: iconsize,color: iconColor,),
        ),)
    ],),);
  }
}
