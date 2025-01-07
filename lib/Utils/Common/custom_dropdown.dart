import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/models/dropdown.dart';

import 'sizer.dart';

class DropDownField extends StatelessWidget {
  final String hintText;
  final List<DropDownItem>? items;
  final void Function(DropDownItem? t) onValueChanged;
  final DropDownItem? selected_value;
  final double? fontsize;
  final double elevation;
  final double? radius;
  final Color hintcolor;
  final Color dropdownColor,bgColor;

  DropDownField(
      {this.hintText = "",
      this.items,
      required this.onValueChanged,
      this.selected_value,
      this.hintcolor = AppColors.iconColor,this.dropdownColor=AppColors.black2,
        this.bgColor=AppColors.midGrey,
      //    this.default_value,
      this.fontsize,
      this.elevation = 0,
      this.radius});

  @override
  Widget build(BuildContext context) {
    final double font = fontsize ?? AppSizer.getFontSize(10);
    final double radius=this.radius??AppSizer.getRadius(AppDimen.dropdownRadius);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: elevation),
      child: buildContainer(
        DropdownButtonHideUnderline(
          child: DropdownButton<DropDownItem>(
            //menuMaxHeight: 40,
            icon: buildArrow(),
            borderRadius: BorderRadius.circular(radius),
            isDense: true,
            isExpanded: true, //alignment: Alignment.center,
            dropdownColor: dropdownColor,
            hint: AppText(
              text: hintText,
              fontSize: font,
              color: hintcolor,
            ),
            value: selected_value,
            // isExpanded: true,
            // icon: Expanded(child:Container(child:Text("a"))),

            items: items != null
                ? items!.map<DropdownMenuItem<DropDownItem>>((DropDownItem it) {
                    return DropdownMenuItem(
                      value: it,
                      child: buildItem(it.getText(), font),
                    );
                  }).toList()
                : [
                    /*    DropdownMenuItem(
                child: Center(child: const ContentLoading()),
              )*/
                  ],
            onChanged: onValueChanged,
          ),
        ),radius
      ),
    );
  }

  Widget buildItem(String it, double font) {
    return AppText(
      text: it,
      fontSize: font,
      color: AppColors.whiteText,
      //fontColor: AppColors.THEME_COLOR_WHITE,
    );
  }

  Widget buildContainer(Widget child,double radius) {
    return Container(
      //height: 20,
      padding: contentPadding,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 1,color: AppColors.iconColor)),
      child: child,
    );
  }

  Widget buildArrow() {
    return CustomMonoIcon(
      icon: AppImages.icDropdown,
      color: null,
      size: AppSizer.getVerticalSize(12),
    );
  }

  EdgeInsets get contentPadding {
    return EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(13),
        vertical: AppSizer.getVerticalSize(3));
  }
}
