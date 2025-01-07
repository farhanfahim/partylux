// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/My%20Event%20Section/View%20Model/myevent_vm.dart';
import 'package:partylux/Modules/My%20Event%20Section/View/Components/center_stacked_tile.dart';
import 'package:partylux/Modules/My%20Event%20Section/View/Components/myevent_slider_tile.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/custom_chips.dart';
import 'package:partylux/Utils/Common/custom_glass_dialog.dart';
import 'package:partylux/Utils/Common/gradient_container.dart';
import 'package:partylux/Utils/Common/gradient_text.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:readmore/readmore.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/cechednetworlimage.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/Common/checkbox.dart';
import '../../../Utils/Common/chipInTile.dart';
import '../../../Utils/Common/custom_switch_button.dart';
import '../../../Utils/Common/glassmorphic_container.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../../Utils/date_time_util.dart';
import '../../Home Module/View/Components/shimmer_view.dart';
import 'Components/map_tile.dart';

class MyEventView extends StatelessWidget {
  MyEventView({super.key});

  final _myEventVM = Get.find<MyEventViewModel>();

  @override
  Widget build(BuildContext context) {
    final eventType=_myEventVM.eventType;
    return CustomScaffold(
      isBodyPadding: false,
      hideAppBar: true,
      safeTop: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => _myEventVM.isLoading.value == false?Column(
              children: [
                Container(
                  height: AppSizer.getVerticalSize(350),
                  child: Stack(
                    children: [
                      MyEventSliderTile(eventImagesList: ['${_myEventVM.eventDetailModel.value.eventProfile}']),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        leading:
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: CustomMonoIcon(
                                icon: AppImages.imgArrowLeft,
                                color: AppColors.whiteText,isSvg: false,size: 30),
                            )),
                        title: AppText(
                          text: AppStrings.event,
                          fontSize: AppSizer.getFontSize(18),
                          fontWeight: FontWeight.w600,
                        ),
                        actions: [
                          Visibility(
                            visible: eventType.value == Constants.EVENT_PRIVATE && _myEventVM.chipInList.isNotEmpty,
                            child: Center(
                              child: Padding(
                                padding: AppSizer.getPadding(right: 10),
                                child: GestureDetector(
                                    onTap: () {
                                      Util.showBottomSheet(
                                          context,
                                          screenTitle:AppStrings.chipIn,
                                          saveTap:(){
                                            Get.back();
                                          },
                                          widget:ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: _myEventVM.chipInList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 10.0),
                                                child: ChipInTile(image: _myEventVM.chipInList[index].image!, text: _myEventVM.chipInList[index].code!,onTap: (){
                                                  Clipboard.setData(ClipboardData(text: _myEventVM.chipInList[index].code!)).then((value) {
                                                    Util.showToast(AppStrings.textCopied);
                                                  });
                                                },)
                                              );
                                            },
                                          ));
                                    },
                                    child: GlassContainer(
                                        width: 90,
                                        height: 35,
                                        color: AppColors.male,
                                        padding: AppSizer.getPadding(all: 6),
                                        child: AppText(text: AppStrings.chipIn_,color: AppColors.male,textAlign: TextAlign.center,fontSize: AppSizer.getFontSize(14),))),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: eventType.value != Constants.EVENT_MY_EVENT,
                            child: Center(
                              child: Padding(
                                padding: AppSizer.getPadding(right: 15),
                                child: GestureDetector(
                                    onTap: () {
                                     _myEventVM.favouriteEvent(_myEventVM.eventDetailModel.value.sId!);
                                    },
                                    child: GlassContainer(
                                        width: 40,
                                        height: 35,
                                        padding: AppSizer.getPadding(all: 6),
                                        child: _myEventVM.isFavouriteLocal.value?
                                        CommonImageView(
                                          imagePath: AppImages.icStarFill,
                                          width: AppSizer.getSize(17),
                                          height: AppSizer.getSize(15),
                                        ):CommonImageView(
                                          svgPath: AppImages.icStar,
                                          width: AppSizer.getSize(24),
                                          height: AppSizer.getSize(24),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CenterStackedTile(
                          profileData: _myEventVM.eventDetailModel.value.userDetail!,
                         eventType: eventType.value,
                         data: _myEventVM.eventDetailModel.value,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: AppSizer.getPadding(left: 14,right: 14,top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                              visible: eventType.value != Constants.EVENT_MY_EVENT,
                              child: Padding(
                                padding: AppSizer.getPadding(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: _myEventVM.eventDetailModel.value.name!,fontSize: AppSizer.getFontSize(20),fontWeight: FontWeight.w700,fontFamily: AppFonts.copperPlate,),
                                    SizedBox(height: AppSizer.getVerticalSize(15),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                              text: DateTimeUtil.parseDateTime(_myEventVM.eventDetailModel.value.startDateTime!,DateTimeUtil.serverDateTimeFormat2,"EEEE",isutc: true),
                                              style: TextStyle(
                                                fontSize: AppSizer.getFontSize(16),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppFonts.copperPlate
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: DateTimeUtil.parseDateTime(_myEventVM.eventDetailModel.value.startDateTime!,DateTimeUtil.serverDateTimeFormat2," d MMM ",isutc: true),
                                                  style: TextStyle(
                                                      fontSize: AppSizer.getFontSize(16),
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: AppFonts.copperPlate,
                                                    color: eventType.value != Constants.EVENT_CLOSED ? AppColors.primaryText : AppColors.grey4
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: DateTimeUtil.parseDateTime(_myEventVM.eventDetailModel.value.startDateTime!,DateTimeUtil.serverDateTimeFormat2,"y",isutc: true),
                                                  style: TextStyle(
                                                      fontSize: AppSizer.getFontSize(16),
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: AppFonts.copperPlate
                                                  ),
                                                )
                                              ]
                                            )),
                                        AppText(
                                          text: DateTimeUtil.parseDateTime(_myEventVM.eventDetailModel.value.startDateTime!,DateTimeUtil.serverDateTimeFormat2,"h:mm a",isutc: true),
                                          fontSize: AppSizer.getFontSize(16),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppSizer.getVerticalSize(15),),
                                    Row(
                                      children: [
                                        CustomMonoIcon(icon: AppImages.icWarning,color: Colors.red,),
                                        SizedBox(width: AppSizer.getHorizontalSize(5),),
                                        Expanded(child: AppText(text:
                                        Util.isDatePassed(_myEventVM.eventDetailModel.value.startDateTime!,_myEventVM.eventDetailModel.value.endDateTime!) == 1
                                            ? AppStrings.thisEventStarts
                                            :Util.isDatePassed(_myEventVM.eventDetailModel.value.startDateTime!,_myEventVM.eventDetailModel.value.endDateTime!) == 2
                                            ? AppStrings.thisEventEnds
                                            :AppStrings.thisEventPassed,
                                          color: Colors.red,fontSize: AppSizer.getFontSize(10),)),
                                        SizedBox(width: AppSizer.getHorizontalSize(15),),
                                        Container(
                                          padding: AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.midGrey,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: Util.isDatePassed(_myEventVM.eventDetailModel.value.startDateTime!,_myEventVM.eventDetailModel.value.endDateTime!)==1
                                                ? AppColors.male
                                                : Util.isDatePassed(_myEventVM.eventDetailModel.value.startDateTime!,_myEventVM.eventDetailModel.value.endDateTime!)==2
                                                ? AppColors.male:AppColors.grey4
                                                ,width: 0.5)
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              text: Util.getDays(_myEventVM.eventDetailModel.value.endDateTime!),
                                              style: TextStyle(
                                                fontFamily: AppFonts.copperPlate,
                                                fontSize: AppSizer.getFontSize(20)
                                              ),
                                              children: [
                                                TextSpan(text: "D",
                                                    style: TextStyle(
                                                  color: Util.getDays(_myEventVM.eventDetailModel.value.endDateTime!) != "0" ? AppColors.male : AppColors.grey4
                                                )),
                                                TextSpan(text: " : "),
                                                TextSpan(text: Util.getHour(_myEventVM.eventDetailModel.value.endDateTime!)),
                                                TextSpan(text: "H",style: TextStyle(
                                                    color: Util.getHour(_myEventVM.eventDetailModel.value.endDateTime!) != "0" ? AppColors.male : AppColors.grey4
                                                )),
                                                TextSpan(text: " : "),
                                                TextSpan(text: Util.getMinutes(_myEventVM.eventDetailModel.value.endDateTime!)),
                                                TextSpan(text: "M",style: TextStyle(
                                                    color: Util.getMinutes(_myEventVM.eventDetailModel.value.endDateTime!) != "0" ? AppColors.male : AppColors.grey4
                                                )),
                                              ]
                                            ),
                                          )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          AppText(
                            text: AppStrings.entertainment,
                            fontSize: AppSizer.getFontSize(12),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          CustomChips(itemList: _myEventVM.eventDetailModel.value.entertainment!,),
                          Visibility(
                            visible: _myEventVM.eventDetailModel.value.getTotalOrdersSummary!.isNotEmpty,
                //child: Container(),
                            child: GestureDetector(
                              onTap: (){


                                if(eventType.value == Constants.EVENT_MY_EVENT &&
                                    _myEventVM.eventDetailModel.value.eventType == Constants.EVENT_PRIVATE &&
                                    _myEventVM.listOfOrderRequest.isNotEmpty) {
                                  Get.toNamed(
                                    AppRoutes.participantsTab,
                                    arguments: [
                                      _myEventVM.eventDetailModel.value.maxParticipants,
                                      _myEventVM.eventDetailModel.value.totalCount,
                                      _myEventVM.eventDetailModel.value.sId,],
                                  )!.then((value) => {
                                    if(value){
                                      _myEventVM.getEventDetail(Get.arguments[0]),
                                    }
                                  });
                                }else{
                                  Get.toNamed(
                                    AppRoutes.peopleJoinedView,
                                    arguments: [
                                      _myEventVM.eventDetailModel.value.maxParticipants,
                                      _myEventVM.eventDetailModel.value.totalCount,
                                      _myEventVM.eventDetailModel.value.sId,
                                    "event"],
                                  );

                                }

                              },
                              child: Padding(
                                padding: AppSizer.getPadding(top: 15),
                                child: GlassContainer(
                                  color: AppColors.primaryText,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "${_myEventVM.eventDetailModel.value.totalCount}",
                                            style: TextStyle(
                                              fontSize: AppSizer.getFontSize(13),
                                              fontFamily: AppFonts.copperPlate2,
                                              fontWeight: FontWeight.w700
                                            ),
                                            children: [
                                              TextSpan(
                                                text: _myEventVM.eventDetailModel.value.maxParticipants==10000?" ":"/${_myEventVM.eventDetailModel.value.maxParticipants} ",
                                                style: TextStyle(
                                                    fontSize: AppSizer.getFontSize(13),
                                                    fontFamily: AppFonts.copperPlate2,
                                                    fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryText
                                                ),
                                              ),
                                              TextSpan(
                                                text:  eventType.value != Constants.EVENT_MY_EVENT
                                                    ?AppStrings.peopleHaveReserve
                                                    : AppStrings.peopleHavePurchase,
                                                style: TextStyle(
                                                    fontSize: AppSizer.getFontSize(13),
                                                    fontFamily: AppFonts.copperPlate2,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.grey4
                                                ),
                                              )
                                            ]),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: AppSizer.getVerticalSize(5),),
                                      Container(
                                        height: AppSizer.getSize(35),
                                        width: AppSizer.getSize(_myEventVM.listOfUsers.length>1?23:35)*(_myEventVM.listOfUsers.length ),
                                        child: Stack(
                                          children: List.generate(
                                              _myEventVM.listOfUsers.length > 5
                                                  ? 5
                                                  : _myEventVM.listOfUsers.length, (index) {
                                            return Positioned(
                                              left: index * 20,
                                              child: GestureDetector(
                                                onTap: (){
                                                  Get.toNamed(
                                                    AppRoutes.imageView,
                                                    arguments: [ _myEventVM.listOfUsers[index].profileImage!=null? _myEventVM.listOfUsers[index].profileImage!:"",]
                                                  );

                                                },
                                                child: Container(
                                                  height: AppSizer.getSize(35),
                                                  width: AppSizer.getSize(35),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors.grey4.withOpacity(0.08),
                                                          width: 4)),
                                                  child: cachedNetworkImage(
                                                    _myEventVM.listOfUsers[index].profileImage!=null? _myEventVM.listOfUsers[index].profileImage!:"",
                                                    radius: 18, context: context,

                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  )),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _myEventVM.eventDetailModel.value.getTotalOrdersSummary!.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: AppSizer.getPadding(top: 15),
                                  child: AppText(
                                    text: AppStrings.genderRatios,
                                    fontSize: AppSizer.getFontSize(12),
                                  ),
                                ),
                                SizedBox(height: AppSizer.getVerticalSize(15),),
                                GlassContainer(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: "${_myEventVM.eventDetailModel.value.maleCount}",
                                              style: TextStyle(
                                                  fontSize: AppSizer.getFontSize(12),
                                                  fontFamily: AppFonts.copperPlate2,
                                                  fontWeight: FontWeight.w700
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: AppStrings.male_,
                                                  style: TextStyle(
                                                      fontSize: AppSizer.getFontSize(12),
                                                      fontFamily: AppFonts.copperPlate2,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.male
                                                  ),
                                                ),
                                              ]),
                                          textAlign: TextAlign.center,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: AppSizer.getMargin(left: 15),
                                            height: AppSizer.getSize(35),
                                            child: Stack(
                                              children: List.generate(
                                                  _myEventVM.listOfMales.length >
                                                      5
                                                      ? 5
                                                      : _myEventVM.listOfMales.length, (index) {
                                                return Positioned(
                                                  left: index * 20,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Get.toNamed(
                                                          AppRoutes.imageView,
                                                          arguments: [ _myEventVM.listOfMales[index].profileImage!=null? _myEventVM.listOfMales[index].profileImage!:"",]
                                                      );
                                                    },
                                                    child: Container(
                                                      height: AppSizer.getSize(35),
                                                      width: AppSizer.getSize(35),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              color: AppColors.grey4.withOpacity(0.08),
                                                              width: 4)),
                                                      child: cachedNetworkImage(
                                                        _myEventVM.listOfMales[index].profileImage!=null? _myEventVM.listOfMales[index].profileImage!:"",
                                                        radius: 18, context: context,

                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){

                                            Get.toNamed(
                                              AppRoutes.genderRatiosTab, arguments: [
                                                0,
                                              _myEventVM.eventDetailModel.value.maleCount,
                                              _myEventVM.eventDetailModel.value.femaleCount,
                                              _myEventVM.eventDetailModel.value.sId,
                                              "event"],

                                            );
                                          },
                                          child: AppText(text: AppStrings.view,
                                              fontSize: AppSizer.getFontSize(12),
                                              color: AppColors.male),
                                        )

                                      ],
                                    )),
                                SizedBox(height: AppSizer.getVerticalSize(10),),
                                GlassContainer(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: "${_myEventVM.eventDetailModel.value.femaleCount}",
                                              style: TextStyle(
                                                  fontSize: AppSizer.getFontSize(12),
                                                  fontFamily: AppFonts.copperPlate2,
                                                  fontWeight: FontWeight.w700
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: AppStrings.female_,
                                                  style: TextStyle(
                                                      fontSize: AppSizer.getFontSize(12),
                                                      fontFamily: AppFonts.copperPlate2,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.female
                                                  ),
                                                ),
                                              ]),
                                          textAlign: TextAlign.center,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: AppSizer.getMargin(left: 15),
                                            height:AppSizer.getSize(35),
                                            child: Stack(
                                              children: List.generate(
                                                  _myEventVM.listOfFemales.length >
                                                      5
                                                      ? 5
                                                      : _myEventVM.listOfFemales.length, (index) {
                                                return Positioned(
                                                  left: index * 20,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Get.toNamed(
                                                          AppRoutes.imageView,
                                                          arguments: [ _myEventVM.listOfFemales[index].profileImage!=null? _myEventVM.listOfFemales[index].profileImage!:"",]
                                                      );
                                                    },
                                                    child: Container(
                                                      height: AppSizer.getSize(35),
                                                      width: AppSizer.getSize(35),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              color: AppColors.grey4.withOpacity(0.08),
                                                              width: 4)),
                                                      child: cachedNetworkImage(
                                                        _myEventVM.listOfFemales[index].profileImage!=null? _myEventVM.listOfFemales[index].profileImage!:"",

                                                        radius: 18, context: context,

                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap:(){

                                            Get.toNamed(
                                              AppRoutes.genderRatiosTab, arguments: [
                                                1,
                                              _myEventVM.eventDetailModel.value.maleCount,
                                              _myEventVM.eventDetailModel.value.femaleCount,
                                              _myEventVM.eventDetailModel.value.sId,
                                            "event"],

                                            );
                                          },child: AppText(text: AppStrings.view,
                                              fontSize: AppSizer.getFontSize(12),
                                              color: AppColors.female),
                                        )

                                      ],
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          AppText(
                            text: AppStrings.desc,
                            color: AppColors.whiteText,
                            fontSize: AppSizer.getFontSize(12),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          ReadMoreText(
                            _myEventVM.eventDetailModel.value.note!,
                            trimLines: 2,
                            style: TextStyle(
                              color: AppColors.iconColor,
                              fontSize: AppSizer.getFontSize(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.copperPlate2,
                              height: 1,
                            ),
                            colorClickableText: AppColors.blueText,
                            trimCollapsedText: AppStrings.readMore,
                            trimExpandedText: AppStrings.readLess,
                            moreStyle: TextStyle(
                              color: AppColors.blueText,
                              fontSize: AppSizer.getFontSize(12),
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.visible,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          AppText(
                            text: AppStrings.location,
                            color: AppColors.whiteText,
                            fontSize: AppSizer.getFontSize(12),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          MapTileView(
                            Lat: _myEventVM.eventDetailModel.value.location!.coordinates![0].toString(),
                            Lng: _myEventVM.eventDetailModel.value.location!.coordinates![1].toString(),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          Row(
                            children: [
                              CommonImageView(
                                svgPath: AppImages.icLocation2,
                              ),
                              SizedBox(width: AppSizer.getHorizontalSize(10),),
                              Expanded(child: AppText(text: _myEventVM.eventDetailModel.value.place!,fontSize: AppSizer.getFontSize(10),)),
                            ],
                          ),

                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          Visibility(
                            visible: eventType.value != Constants.EVENT_MY_EVENT && eventType.value != Constants.EVENT_PENDING && eventType.value != Constants.EVENT_PENDING  && eventType.value != Constants.EVENT_CLOSED,
                            child: GlassContainer(
                                color: AppColors.primaryText,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(text: AppStrings.entryFees),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          amountCalculate(
                                            amount: _myEventVM.userData.value.profile!.gender!.toLowerCase() == "male"
                                                ? "\$${_myEventVM.eventDetailModel.value.admissionFee!.male!.amount!.toStringAsFixed(2)}"
                                                : "\$${_myEventVM.eventDetailModel.value.admissionFee!.female!.amount!.toStringAsFixed(2)}",
                                            isFree: _myEventVM.userData.value.profile!.gender!.toLowerCase() == "male"
                                                ? _myEventVM.eventDetailModel.value.admissionFee!.male!.free!
                                                : _myEventVM.eventDetailModel.value.admissionFee!.female!.free!,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                           SizedBox(height: AppSizer.getVerticalSize(eventType.value != Constants.EVENT_CLOSED ? 90 : 20),)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ):viewEventDetailShimmer(),
          ),
          Obx(() => _myEventVM.isLoading.value == false?Container(
              height: AppSizer.getVerticalSize(eventType.value == Constants.EVENT_OTHER || eventType.value == Constants.EVENT_PRIVATE?120:80),
              alignment: Alignment.bottomCenter,
              width: double.maxFinite,
              child: eventType.value == Constants.EVENT_MY_EVENT
                  ? GlassContainer(
                  borderRadius: 0,
                  padding: AppSizer.getPadding(left: 20,right: 20,top: 14,bottom: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            label: AppStrings.edit,
                            gradientColors: [
                              AppColors.primaryText,
                              AppColors.female,
                            ],
                            onPressed: (){
                              AppNavigator.navigateToNamed(AppRoutes.createParty,arguments: {
                                Constants.paramFrom:_myEventVM.eventDetailModel.value.eventCategory,
                                Constants.paramFrom2: true,
                                Constants.paramFrom3: _myEventVM.eventModel,
                              })!.then((value) {
                                _myEventVM.getEventDetail(_myEventVM.eventId);
                              });
                            }),
                      ),
                      SizedBox(width: AppSizer.getHorizontalSize(10),),
                      Expanded(
                        child: CustomButton(
                            label: AppStrings.eventCancel,
                            color: Colors.black.withOpacity(0.1),
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context){
                                    return CustomGlassDialog(
                                        title: _myEventVM.eventDetailModel.value.name!,
                                        showContent: true,
                                        firstButtonContent: 'Yes',
                                        secondButtonContent: "No I'm Not",
                                        firstCallback: () {
                                          EasyLoading.show(
                                            status: 'Please Wait . . .',
                                            indicator: CupertinoActivityIndicator(
                                              color: AppColors.whiteText,
                                              radius: SizeConfig.screenWidth * 0.05,
                                            ),
                                          );
                                          _myEventVM.onDeleteEvent(eventID: _myEventVM.eventDetailModel.value.sId!).then((value)  {
                                          EasyLoading.dismiss();
                                            if(value){
                                              Get.offAllNamed(AppRoutes.NAV_ROOT);
                                            }
                                          });
                                        },
                                        secondCallback: () {
                                          Get.back();
                                        }
                                    );
                                  });
                            }),
                      ),

                    ],

                  )
              )
                  : eventType.value == Constants.EVENT_RESERVED || eventType.value == Constants.EVENT_PAYMENT
                  ? GlassContainer(
                color: AppColors.transparent,
                borderRadius: 0,
                padding: AppSizer.getPadding(all: 10),
                child: Row(
                  children: [
                  /*  Expanded(
                      child: GradientContainer(
                        margin:  AppSizer.getMargin(top: 5,bottom: 5),
                        gradientColors: [
                          AppColors.grey4,
                          AppColors.grey4,
                        ],
                        child: AppText(text: AppStrings.cancel,color: AppColors.grey4,fontSize: AppSizer.getFontSize(14),),
                        onPressed:(){
                          _myEventVM.onCancelEvent(eventID: _myEventVM.eventDetailModel.value.sId!);
                        },
                      ),
                    ),
                    SizedBox(width: AppSizer.getHorizontalSize(10),),*/
                    Expanded(
                      child: GradientContainer(
                          margin:  AppSizer.getMargin(top: 5,bottom: 5),
                          onPressed: (){

                            if(eventType == Constants.EVENT_PAYMENT){
                              AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
                                Constants.paramFrom: true,
                                Constants.paramFrom2: Get.arguments[2],
                              });

                            }else{
                              Get.toNamed(
                                AppRoutes.ticketDetailView,
                                arguments: [Get.arguments[2],"business"],
                              );
                            }



                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(eventType == Constants.EVENT_RESERVED)Image.asset(AppImages.icGradientTicket),
                              SizedBox(width: AppSizer.getHorizontalSize(10),),
                              GradientText(
                                  eventType == Constants.EVENT_PAYMENT?AppStrings.payNow:AppStrings.viewTicket,
                                  fontSize: 14,
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.female,
                                        AppColors.primaryText,
                                      ]
                                  ))
                            ],
                          )),
                    ),
                  ],
                ),
              )
                  : eventType.value == Constants.EVENT_PENDING
                  ? GradientContainer(
                margin:  AppSizer.getMargin(left: 10,right: 10,top: 15,bottom: 15),
                onPressed: (){},
                gradientColors: [
                  AppColors.orangeColor,
                  AppColors.orangeColor,
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: AppStrings.pending,color: AppColors.orangeColor,fontSize: AppSizer.getFontSize(14),),
                    SizedBox(width: AppSizer.getHorizontalSize(10),),
                    CustomMonoIcon(icon: AppImages.icRevote,color: AppColors.orangeColor,size: AppSizer.getVerticalSize(25),)
                  ],
                ),
              )
                  : eventType.value == Constants.EVENT_OTHER || eventType.value == Constants.EVENT_PRIVATE
                  ?GlassContainer(
                color: AppColors.transparent,
                borderRadius: 0,
                padding: AppSizer.getPadding(all: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckBoxField(
                          isRichText: true,
                          richText1: "Please agree to our ",
                          richText2: "Terms & Conditions",
                          richText3: "\nPrivacy Policy.",
                          richTextCallBack: (String val) {
                            if (val == "Terms & Conditions") {
                              Get.toNamed(
                                AppRoutes.customPrivacyView,
                                arguments: ["Terms & Conditions"],
                              );
                            } else {
                              Get.toNamed(
                                AppRoutes.customPrivacyView,
                                arguments: ["Privacy Policy"],
                              );
                            }
                          },
                          callback: (val) {
                            _myEventVM.isCheckTerms.value = val;
                          },
                        ),
                        SizedBox(height: 5,),
                        CustomSwitchButton(
                          height: AppSizer.getVerticalSize(AppDimen.switchBtnHeight),
                          onTrigger: () async {
                            return _myEventVM.reserveEvent(
                                _myEventVM.userData.value.profile!.gender!.toLowerCase() == "male"
                                    ? _myEventVM.eventDetailModel.value.admissionFee!.male!.free!
                                    : _myEventVM.eventDetailModel.value.admissionFee!.male!.free!,
                                eventType.value,context);
                          },
              ),
                      ],
                    ),
                  )
                  :const SizedBox.shrink()

          ):Container(),)
        ],
      ),
    );
  }

  Widget amountCalculate({
    required String amount,
    required bool isFree,
  }) {
    return GradientText(
        isFree ? "Free" : amount, gradient: LinearGradient(
        colors: [
          AppColors.female,
          AppColors.primaryText,
        ]
    ));
  }
}
