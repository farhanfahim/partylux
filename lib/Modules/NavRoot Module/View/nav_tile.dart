import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class NavBarTile extends StatefulWidget {
  final bool isSelected;
  final String title;
  final Widget icon;
  final VoidCallback callback;
  const NavBarTile(
      {Key? key,
      required this.callback,
      required this.isSelected,
      required this.title,
      required this.icon})
      : super(key: key);

  @override
  _NavBarTileState createState() => _NavBarTileState();
}

class _NavBarTileState extends State<NavBarTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          widget.callback();
        },
        child: Container(
          color: Colors.transparent,
          // height: 45,

          width: SizeConfig.screenWidth / 5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 10,
                child: Container(
                  width: 32,
                  height:  32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: widget.isSelected?AppColors.navBarColorActive:AppColors.transparent,
                        blurRadius: widget.isSelected?20:0,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon,
                  if (widget.title.isNotEmpty)
                    const SizedBox(
                      height: 4,
                    ),
                  if (widget.title.isNotEmpty)
                    AppText(
                      text: widget.title,
                      color: widget.isSelected
                          ? AppColors.primaryText
                          : AppColors.iconColor,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12)
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
