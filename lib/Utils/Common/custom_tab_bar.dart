import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<TabbarItem> items;
  final double fontsize;
  final double radius;
  final double height;
  final Color selectColor, unselectColor;
  final bool scrollable;
  final EdgeInsets labelPadding, indicatorPadding;
  final Border? border;
  final Color indicatorColor;
  final double indicatorWeight;
  const CustomTabBar(
      {Key? key,
        required this.controller,
        required this.items,
        this.fontsize = 14,
        this.radius = 0,
        this.scrollable = false,
        this.indicatorPadding = EdgeInsets.zero,
        this.indicatorWeight = 3,
        this.labelPadding = EdgeInsets.zero,
        this.border,
        this.indicatorColor = AppColors.primary,
        required this.height,
        this.selectColor = AppColors.whiteText,
        this.unselectColor = AppColors.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontsize = AppSizer.getFontSize(this.fontsize);
    return Container(
      height: height,
      //  padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(radius),
          border: border,
        //  border: Border.all(width: 1, color: color)
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(height: indicatorWeight,width: double.infinity,color: AppColors.midGrey,)),
          Positioned.fill(
            child: TabBar(
              controller: controller, isScrollable: scrollable,
              padding: EdgeInsets.zero,
              labelPadding: labelPadding,
              //  labelPadding: EdgeInsets.symmetric(horizontal: 90),

              labelColor: selectColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: indicatorPadding,
              labelStyle: TextStyle(
                  fontSize: fontsize,
                  fontFamily: AppFonts.copperPlate2,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: unselectColor,
              unselectedLabelStyle: TextStyle(
                  fontSize: fontsize,
                  fontFamily: AppFonts.copperPlate2,
                fontWeight: FontWeight.w700,
              ),
              indicatorColor: indicatorColor,
              indicatorWeight: indicatorWeight,
              //indicatorSize: TabBarIndicatorSize.tab,
              /*  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: AppColor.THEME_COLOR_PRIMARY1),*/
              tabs: List.generate(items.length, (index) => buildItem(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index){
    var item=items[index];
    return item;
  }
}


abstract class TabbarItem extends StatelessWidget {
  TabbarItem({Key? key}) : super(key: key);
}

class CustomTabBarItem extends TabbarItem {

  final String title;
  final Color color;
  double? sidePadding;
  CustomTabBarItem({Key? key, this.title = "",this.color=Colors.red,this.sidePadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizer.getPadding(left: sidePadding??0,right: sidePadding??0),
      child: Tab(
        text: title,
      ),
    );
  }
}