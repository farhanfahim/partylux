import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';
import 'Components/categories_tile.dart';
import 'Components/home_main_tile.dart';
import 'Components/shimmer_view.dart';
import 'Components/top_live_business_tile.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeVM = Get.find<HomeViewModel>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showLeading: true,
      isLeftAlign: true,
      isTopPadding: 10,
      leadingWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Image.asset(AppImages.imgSimpleLogo,width: SizeConfig.screenWidth/2,)),
      leadingWidth: SizeConfig.screenWidth,
        basicAppTrailingIcon:Row(
          children: [

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.HOME_SEARCH);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: SizeConfig.screenWidth * 0.10,
                height: SizeConfig.screenWidth * 0.10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.feildBGColor.withOpacity(0.1),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
                  child: Image.asset(AppImages.imgSearch),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationView);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: SizeConfig.screenWidth * 0.10,
                height: SizeConfig.screenWidth * 0.10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.feildBGColor.withOpacity(0.1),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
                  child: Image.asset(AppImages.imgNotificationPng),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.enableLocationServices);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: SizeConfig.screenWidth * 0.10,
                height: SizeConfig.screenWidth * 0.10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.feildBGColor.withOpacity(0.10),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
                  child: Image.asset(AppImages.icLocation),
                ),
              ),
            ),
          ],
        ),
      body: Obx(
        () => RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            _homeVM.getUserDetail();
          },
          child: Column(
            children: [
              HomeMainTile(
                username: _homeVM.userData.value.username!,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  shrinkWrap: true,
                  children: [
                    Visibility(
                      visible:  _homeVM.topLiveClubsList.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: "Top ",
                                  style: TextStyle(
                                    fontFamily:AppFonts.copperPlate2,
                                    overflow: TextOverflow.visible,
                                    color: AppColors.redText,
                                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppStrings.clubs,
                                      style: TextStyle(
                                        fontFamily: AppFonts.copperPlate2,
                                        overflow: TextOverflow.visible,
                                        color: AppColors.whiteText,
                                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              liveTag(),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenWidth * 0.05),
                          SizedBox(
                              height: SizeConfig.screenWidth * 0.30,
                              width: SizeConfig.screenWidth,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _homeVM.topLiveClubsList.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return TopFiveLiveBusinessTile(
                                    data: _homeVM.topLiveClubsList[index],
                                    currentUser:
                                        _homeVM.userData.value,
                                  );
                                },
                              )),
                          SizedBox(height: SizeConfig.screenWidth * 0.05),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _homeVM.topLiveBarsList.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: "Top ",
                                  style: TextStyle(
                                    fontFamily:AppFonts.copperPlate2,
                                    overflow: TextOverflow.visible,
                                    color: AppColors.redText,
                                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppStrings.bars,
                                      style: TextStyle(
                                        fontFamily: AppFonts.copperPlate2,
                                        overflow: TextOverflow.visible,
                                        color: AppColors.whiteText,
                                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              liveTag(),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenWidth * 0.05),
                          SizedBox(
                              height: SizeConfig.screenWidth * 0.30,
                              width: SizeConfig.screenWidth,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _homeVM.topLiveBarsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TopFiveLiveBusinessTile(
                                    data: _homeVM.topLiveBarsList[index],
                                    currentUser: _homeVM.userData.value,
                                  );
                                },
                              )),
                          SizedBox(height: SizeConfig.screenWidth * 0.05),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: AppStrings.events,
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap:(){
                            _homeVM.navigateViewAllEvents();

                          },child: AppText(
                            text: AppStrings.seeAllEvents,
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.04),
                    Container(
                      height: SizeConfig.screenWidth * 0.095,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _homeVM.arrOfEvents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                              padding: AppSizer.getPadding(right: 5),
                              child: categoriesButton(
                                title: _homeVM.arrOfEvents[index],
                                isAvtive: _homeVM.selectedEvent.value == _homeVM.arrOfEvents[index],
                                callback: () {
                                  _homeVM.selectedEvent.value = _homeVM.arrOfEvents[index];
                                  if(_homeVM.selectedEvent.value == AppStrings.clubs){
                                    _homeVM.getEvent(length: 6,categoryType: Constants.CATEGORY_CLUB);
                                  }
                                  if(_homeVM.selectedEvent.value == AppStrings.houseParty){
                                    _homeVM.getEvent(length: 6,categoryType: Constants.CATEGORY_HOUSE_PARTY);
                                  }
                                  if(_homeVM.selectedEvent.value == AppStrings.bars){
                                    _homeVM.getEvent(length: 6,categoryType: Constants.CATEGORY_BAR);
                                  }
                                  if(_homeVM.selectedEvent.value == AppStrings.beach){
                                    _homeVM.getEvent(length: 6,categoryType: Constants.CATEGORY_BEACH);
                                  }

                                },
                              ),
                            ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.05),
                    SizedBox(
                      height: SizeConfig.screenWidth * 0.85,
                      width: SizeConfig.screenWidth,
                      child: _homeVM.eventCategoryList.isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _homeVM.eventCategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriesTile(
                            data: _homeVM.eventCategoryList[index],
                            currentUser: _homeVM.userData.value,
                          );

                        },
                      )
                          : _homeVM.isAllHomeLoading.value? categiriesShimmer()
                          :Center(
                        child: AppText(
                            text: AppStrings.noEventFound),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector categoriesButton({
    required String title,
    required bool isAvtive,
    required Function callback,
  }) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: SizeConfig.screenWidth*0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isAvtive
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0, 1],
                  colors: [
                    AppColors.secondary,
                    AppColors.primary,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0],
                  colors: [
                    AppColors.whiteText.withOpacity(0.1),
                  ],
                ),
        ),
        child: Center(
          child: AppText(
            text: title,
            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            
          ),
        ),
      ),
    );
  }
  Container liveTag() {
    return Container(
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
          text: AppStrings.live,
          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
          
        ),
      ),
    );
  }
}
