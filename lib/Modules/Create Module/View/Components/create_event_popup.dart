import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class CreateEventPopup extends StatelessWidget {
  final Function noCallback;
  final Function yesCallback;
  const CreateEventPopup({
    super.key,
    required this.noCallback,
    required this.yesCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth * 0.75,
      width: SizeConfig.screenWidth * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0, 1],
          colors: [
            AppColors.primary.withOpacity(0.5),
            AppColors.secondary.withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  color: AppColors.transparent,
                  size: SizeConfig.screenWidth * 0.08,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  "assets/icon_assets/successfullycreateEvent.png",
                  height: SizeConfig.screenWidth * 0.25,
                  width: SizeConfig.screenWidth * 0.25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                splashRadius: 24,
                icon: Icon(
                  Icons.close,
                  color: AppColors.whiteText,
                  size: SizeConfig.screenWidth * 0.08,
                ),
              ),
            ],
          ),
          const Spacer(),
          AppText(
            text: "Would you like to add premium\nVIP access cards",
            textAlign: TextAlign.center,
            fontSize: SizeConfig.screenWidth * 0.04,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.back();
                      yesCallback();
                    },
                    child: Container(
                      height: SizeConfig.screenWidth * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.backgroundColor,
                      ),
                      child: Center(
                        child: AppText(
                          text: "Yes",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.back();
                      noCallback();
                    },
                    child: Container(
                      height: SizeConfig.screenWidth * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteText,
                      ),
                      child: Center(
                        child: AppText(
                          text: "No",
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
