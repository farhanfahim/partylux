import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/common_methods.dart';

class CustomSwitchButton extends StatefulWidget {
  final double height;
  final double radius;
  final double padding;
  final String? swipeText;
  final Future<bool> Function()? onTrigger;
  final bool vibrate;
  const CustomSwitchButton({
    Key? key,
    this.height = 30,
    this.radius = 20,
    //this.padding = 2,
    this.padding=2,
    this.onTrigger,
    this.swipeText,this.vibrate=false,
  }) : super(key: key);

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> with TickerProviderStateMixin {
  double position = 0;

  late Size size;

  late double width;

  late AnimationController animationController;

  bool triggered = false;

  @override
  void initState() {
    width = widget.height * 2.3;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppInteger.switchDurationMilli),
      reverseDuration: const Duration(milliseconds: AppInteger.switchDurationMilli),
    );
    animationController.addListener(() {
      setState(() {
        position = getFullWidth() * animationController.value;
      });
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        triggered = false;
      } else if (status == AnimationStatus.completed) {
        triggerFunction();
      }
    });
    super.initState();
  }

  void triggerFunction() async{
    if (!triggered) {
      bool? val=await widget.onTrigger?.call();
      triggered = true;
      if(val==false){
        animationController.reverse(
          from: position / getFullWidth(),
        );
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (con, cons) {
      size = cons.biggest;
      return Container(
        height: widget.height,
        width: size.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(width: 1, color: AppColors.primary),
          color: AppColors.midGrey,
        ),
        child: Stack(
          children: [
            buildDecoration(),
            Visibility(
              visible: position>0,
              child: Container(height: widget.height,
                width: position+width-widget.padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColors.primary,AppColors.black,]
                  )
                ),
                ),
            ),
            Positioned(
              left: position,
              child: GestureDetector(
                  onHorizontalDragUpdate: (drag) {
                    setPositon(drag.delta.dx);
                  },
                  onHorizontalDragEnd: (drag) {
                    checkPosition();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: buildTrigger()),
            ),
          ],
        ),
      );
    });
  }

  Widget buildDecoration() {
    final double fontsize = AppSizer.getFontSize(12);
    return Stack(
      children: [
        Center(
          child: CommonImageView(
            height: widget.height * 0.33,
            imagePath: AppImages.imgSpeedArrow,
          ),
        ),
        Align(
            alignment: FractionalOffset(0.95, 0.5),
            child: AppText(
              text: widget.swipeText ?? AppStrings.txtSwipeToParty,
              color: AppColors.white2,
              fontSize: fontsize,
            ))
      ],
    );
  }

  Widget buildTrigger() {
    //width = AppSizer.getHorizontalSize(100);
    return SizedBox(
      width: width,
      height: widget.height,
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Container(
          height: widget.height,
          padding: EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: AppColors.bottomsheetLogout,
          ),
          child: Container(
              child: CommonImageView(
            imagePath: AppImages.imgSimpleLogo,
            fit: BoxFit.contain,
          )),
        ),
      ),
    );
  }

  void checkPosition() {
    //double div = (size.width / 2)-(width/2);
    double div =(size.width-width)/2;
    if (position >= div) {
      animationController.forward(
        from: position / getFullWidth(),
      );
    } else if (position < div) {
      animationController.reverse(
        from: position / getFullWidth(),
      );
    }
  }

  void setPositon(double val) {
    double pos = position + val;
    if (pos >= 0 && pos <= getFullWidth()) {
      setState(() {
        position = pos;
      });
      if(widget.vibrate) {
        CommonMethods.vibrate();
      }
    }
  }

  double getFullWidth() {
    return size.width - width;
  }
}
