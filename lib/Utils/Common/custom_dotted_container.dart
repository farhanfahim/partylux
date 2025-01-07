import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';

class CustomDottedContainer extends StatelessWidget {

  final double dashlength,dashspacing;
  final Widget? child;
  final double? width,height;
  final double borderWidth;
  final double radius;
  final Color color;
  final BorderType borderType;
  const CustomDottedContainer({Key? key,this.dashlength=4,this.dashspacing=8,
    this.width,this.height,this.borderWidth=1,this.radius=0,this.borderType=BorderType.RRect,
    this.color=AppColors.black,
    this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: width,
      // height: height,
      child: DottedBorder(
        radius: Radius.circular(radius),
        color: color,
        strokeWidth: borderWidth,borderType: borderType,
        //borderPadding: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: height??0,),
        strokeCap: StrokeCap.butt,
        dashPattern:[dashlength,dashspacing],
/*              customPath: (size){
                  print("size is: $size");
                  var path=Path();
                  path.moveTo(0, size.height);
                  path.lineTo(10, size.height);
                  return path;
                },*/
        child: child??Container(),
      ),
    );
  }
}