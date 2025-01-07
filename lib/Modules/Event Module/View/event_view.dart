import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../Constants/app_images.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';

class EventView extends StatelessWidget {
  EventView({super.key});

  final _eventVM = Get.find<EventViewModel>();


  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      isBodyPadding: true,
      isLeftAlign: false,
      appBarTitle: "",
      showLeading: true,
      leadingWidth: SizeConfig.screenWidth,
      leadingWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Image.asset(AppImages.imgSimpleLogo,width: SizeConfig.screenWidth/2,)),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
/*            AppText(
              text: "Here you can see your created Events your booking events and their History",
              overflow: TextOverflow.visible,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.05),*/
            Obx(
              () => Row(
                children: [
                  sectionButton(
                    title: 'My Events',
                    isActive: _eventVM.tapIndex.value == 0 ? true : false,
                    callback: () {
                      _eventVM.tapIndex.value = 0;
                    },
                  ),
                  const SizedBox(width: 8),
                  sectionButton(
                    title: AppStrings.txtReservations,
                    isActive: _eventVM.tapIndex.value == 1 ? true : false,
                    callback: () {
                      _eventVM.tapIndex.value = 1;
                    },
                  ),
                  const SizedBox(width: 8),
                  sectionButton(
                    title: 'History',
                    isActive: _eventVM.tapIndex.value == 2 ? true : false,
                    callback: () {
                      _eventVM.tapIndex.value = 2;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: _eventVM.tapIndex.value == 1?AppSizer.getVerticalSize(10):AppSizer.getVerticalSize(30)),
            Expanded(child: Obx(
                (){
                  return _eventVM.screens[_eventVM.tapIndex.value];
                }
            )),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  Widget sectionButton({
    required String title,
    required bool isActive,
    required Function callback,
  }) {
    return Expanded(
      flex: title == "Reservations" ? 3 : 2,
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Container( 
          padding: AppSizer.getPadding(top: 10,bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isActive ? null : AppColors.whiteText.withOpacity(0.10),
            gradient: isActive
                ? const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0, 1],
                    colors: [
                      AppColors.secondary,
                      AppColors.primary,
                    ],
                  )
                : null,
          ),
          child: Center(
            child: AppText(
              text: title,
              height: 0.9,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
