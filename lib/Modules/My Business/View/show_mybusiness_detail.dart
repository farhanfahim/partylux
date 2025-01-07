import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/My%20Business/View%20Model/mybusiness_vm.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:readmore/readmore.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/dimens.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/common_image_view.dart';
import '../../../Utils/Common/custom_button.dart';
import '../../../Utils/Common/custom_chips.dart';
import '../../../Utils/Common/custom_glass_dialog.dart';
import '../../../Utils/Common/custom_switch_button.dart';
import '../../../Utils/Common/glassmorphic_container.dart';
import '../../../Utils/Common/icons.dart';
import '../../../Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/gradient_text.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/date_time_util.dart';
import '../../Home Module/View/Components/shimmer_view.dart';
import '../../My Event Section/View/Components/map_tile.dart';
import '../../My Event Section/View/Components/social_tile.dart';
import '../../My Event Section/View/Components/upcoming_tile.dart';
import 'Component/business_center_stacked_tile.dart';
import 'Component/my_business_slider_tile.dart';

class ShowMyBusinessDetail extends StatefulWidget {
  ShowMyBusinessDetail({super.key});

  @override
  State<ShowMyBusinessDetail> createState() => _ShowMyBusinessDetailState();
}

class _ShowMyBusinessDetailState extends State<ShowMyBusinessDetail> {
  final _becomePartnerVM = Get.isRegistered<MyBusinessVM>()
      ? Get.find<MyBusinessVM>()
      : Get.put(MyBusinessVM());


  String data = Get.arguments[0];
  final String eventType = Get.arguments[1];
  final bool isEdit = Get.arguments[2];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      isBodyPadding: false,
      hideAppBar: true,
      safeTop: true,
      body: Obx(() => _becomePartnerVM.isLoading.value == false?Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.45,
                child: Stack(
                  children: [
                    MyBusinessSliderTile(eventImagesList: _becomePartnerVM.businessDetailModel.value.photos!),
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
                        text: _becomePartnerVM.businessDetailModel.value.bussinessCategory!,
                        fontSize: AppSizer.getFontSize(18),
                        fontWeight: FontWeight.w600,
                      ),
                      actions: [
                        Visibility(
                          visible: isEdit?false:true,
                          child: Center(
                            child: Padding(
                              padding: AppSizer.getPadding(right: 15),
                              child: GestureDetector(
                                  onTap: () {
                                    _becomePartnerVM.favouriteBusiness(_becomePartnerVM.businessDetailModel.value.sId!);
                                  },
                                  child: GlassContainer(
                                      width: 40,
                                      height: 35,
                                      padding: AppSizer.getPadding(all: 6),
                                      child: _becomePartnerVM.isFavouriteLocal.value?
                                      CommonImageView(
                                        imagePath: AppImages.icStarFill,
                                        width: AppSizer.getSize(18),
                                        height: AppSizer.getSize(18),
                                      ):CommonImageView(
                                        svgPath: AppImages.icStar,
                                        width: AppSizer.getSize(24),
                                        height: AppSizer.getSize(24),
                                      ),
                                  )),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BusinessCenterStackedTile(
                        profileData: _becomePartnerVM.businessDetailModel.value.userDetail!,
                        eventType: eventType,
                        data: _becomePartnerVM.businessDetailModel.value,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: AppSizer.getPadding(left: 14,right: 14,top: 10),
                  child: Obx(
                        () => SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _becomePartnerVM.currentBusinessDay.first.endTime!.isNotEmpty?Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      AppText(
                                        text: DateTimeUtil.parseDateTime(_becomePartnerVM.currentBusinessDay.first.startTime!,DateTimeUtil.serverDateTimeFormat3,'h:mm a',isutc: true),
                                        fontSize: AppSizer.getFontSize(15),
                                        fontFamily: AppFonts.copperPlate,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteText,
                                      ),
                                      AppText(
                                        text: " - ",
                                        fontSize: AppSizer.getFontSize(15),
                                        fontFamily: AppFonts.copperPlate,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteText,
                                      ),
                                      AppText(
                                        text: DateTimeUtil.parseDateTime(_becomePartnerVM.currentBusinessDay.first.endTime!,DateTimeUtil.serverDateTimeFormat3,'h:mm a',isutc: true),
                                        fontSize: AppSizer.getFontSize(15),
                                        fontFamily: AppFonts.copperPlate,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: DateTimeUtil.parseDateTime(DateTime.now().toString(),DateTimeUtil.serverDateTimeFormat3,'EEEE',isutc: true),

                                          style: TextStyle(
                                              fontSize: AppSizer.getFontSize(14),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: AppFonts.copperPlate
                                          ),
                                          children: [
                                            TextSpan(
                                              text: DateTimeUtil.parseDateTime(DateTime.now().toString(),DateTimeUtil.serverDateTimeFormat3,' d MMM ',isutc: true),

                                              style: TextStyle(
                                                  fontSize: AppSizer.getFontSize(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: AppFonts.copperPlate,
                                                  color: eventType != Constants.EVENT_CLOSED ? AppColors.primaryText : AppColors.grey4
                                              ),
                                            ),
                                            TextSpan(
                                              text: DateTimeUtil.parseDateTime(DateTime.now().toString(),DateTimeUtil.serverDateTimeFormat3,'y',isutc: true),
                                              style: TextStyle(
                                                  fontSize: AppSizer.getFontSize(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: AppFonts.copperPlate
                                              ),
                                            )
                                          ]
                                      )),
                                ),
                              ),
                            ],
                          ):Container(),

                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          CustomChips(itemList: _becomePartnerVM.businessDetailModel.value.entertainment!,),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          CustomChips(itemList: _becomePartnerVM.businessDetailModel.value.music!,),
                          Visibility(
                            visible: _becomePartnerVM.businessDetailModel.value.maxParticipants!>0,
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed(

                                  AppRoutes.peopleJoinedView,
                                  arguments: [
                                    _becomePartnerVM.businessDetailModel.value.maxParticipants,
                                    _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveTotalCount,
                                    _becomePartnerVM.businessDetailModel.value.sId,
                                  "business"],
                                );
                              },
                              child: Padding(
                                padding: AppSizer.getPadding(top: 15),
                                child: GlassContainer(
                                    color: AppColors.primaryText,
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveTotalCount!.toString(),
                                              style: TextStyle(
                                                  fontSize: AppSizer.getFontSize(13),
                                                  fontFamily: AppFonts.copperPlate2,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryText
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: " People are Partying",
                                                  style: TextStyle(
                                                      fontSize: AppSizer.getFontSize(13),
                                                      color: AppColors.iconColor
                                                  ),
                                                )
                                              ]),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: AppSizer.getVerticalSize(10),),

                                        Container(
                                          height: AppSizer.getVerticalSize(40),
                                          width: MediaQuery.sizeOf(context).width * 0.25,
                                          child: Stack(
                                            children: List.generate(_becomePartnerVM.listOfUsers.length >
                                                5
                                                ? 5
                                                : _becomePartnerVM.listOfUsers.length, (index) {
                                              return Positioned(
                                                left: index * 20,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    Get.toNamed(
                                                        AppRoutes.imageView,
                                                        arguments: [ _becomePartnerVM.listOfUsers[index].profileImage!=null? _becomePartnerVM.listOfUsers[index].profileImage!:"",]
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
                                                      _becomePartnerVM.listOfUsers[index].profileImage!,
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
                            visible: true,
                            child: Padding(
                              padding:AppSizer.getPadding(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      liveTag(),
                                      AppText(
                                        text: "  Ratio",
                                        fontSize: AppSizer.getFontSize(12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizer.getVerticalSize(15),),
                                  GlassContainer(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "${_becomePartnerVM.businessDetailModel.value.liveParticipants!.liveMaleCount}",
                                                style: TextStyle(
                                                    fontSize: AppSizer.getFontSize(12),
                                                    fontFamily: AppFonts.copperPlate2,
                                                    fontWeight: FontWeight.w700
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: " Men",
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
                                              height: AppSizer.getVerticalSize(40),
                                              child: Stack(
                                                children: List.generate(_becomePartnerVM.listOfMales.length >
                                                    5
                                                    ? 5
                                                    : _becomePartnerVM.listOfMales.length, (index) {
                                                  return Positioned(
                                                    left: index * 20,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Get.toNamed(
                                                            AppRoutes.imageView,
                                                            arguments: [ _becomePartnerVM.listOfMales[index].profileImage!=null? _becomePartnerVM.listOfMales[index].profileImage!:"",]
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
                                                          _becomePartnerVM.listOfMales[index].profileImage!,
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
                                                0,
                                                _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveMaleCount,
                                                _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveFemaleCount,
                                                _becomePartnerVM.businessDetailModel.value.sId,
                                                "business"],

                                              );

                                            },child: AppText(text: "View",
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
                                                text: "${_becomePartnerVM.businessDetailModel.value.liveParticipants!.liveFemaleCount}",
                                                style: TextStyle(
                                                    fontSize: AppSizer.getFontSize(12),
                                                    fontFamily: AppFonts.copperPlate2,
                                                    fontWeight: FontWeight.w700
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: " Women",
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
                                              height: AppSizer.getVerticalSize(40),
                                              child: Stack(
                                                children: List.generate(_becomePartnerVM.listOfFemales.length >
                                                    5
                                                    ? 5
                                                    : _becomePartnerVM.listOfFemales.length, (index) {
                                                  return Positioned(
                                                    left: index * 20,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Get.toNamed(
                                                            AppRoutes.imageView,
                                                            arguments: [ _becomePartnerVM.listOfFemales[index].profileImage!=null? _becomePartnerVM.listOfFemales[index].profileImage!:"",]
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
                                                          _becomePartnerVM.listOfFemales[index].profileImage!,
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
                                                1,
                                                _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveMaleCount,
                                                _becomePartnerVM.businessDetailModel.value.liveParticipants!.liveFemaleCount,
                                                _becomePartnerVM.businessDetailModel.value.sId,
                                                "business"],

                                              );
                                            },
                                            child: AppText(text: "View",
                                                fontSize: AppSizer.getFontSize(12),
                                                color: AppColors.female),
                                          )

                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(25),),
                          AppText(
                            text: "Location",
                            color: AppColors.whiteText,
                            fontSize: AppSizer.getFontSize(12),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          MapTileView(
                            Lat: _becomePartnerVM.businessDetailModel.value.location!.coordinates![0].toString(),
                            Lng: _becomePartnerVM.businessDetailModel.value.location!.coordinates![1].toString(),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(10),),
                          Row(
                            children: [
                              CommonImageView(
                                svgPath: AppImages.icLocation2,
                              ),
                              SizedBox(width: AppSizer.getHorizontalSize(10),),
                              Expanded(child: AppText(text: _becomePartnerVM.businessDetailModel.value.place!,fontSize: AppSizer.getFontSize(10),)),
                            ],
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          AppText(
                            text: "Description",
                            color: AppColors.whiteText,
                            fontSize: AppSizer.getFontSize(12),
                            fontWeight: FontWeight.w700,
                          ),

                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          ReadMoreText(
                            _becomePartnerVM.businessDetailModel.value.note!,
                            trimLines: 2,
                            style: TextStyle(
                              color: AppColors.iconColor,
                              fontSize: AppSizer.getFontSize(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.copperPlate2,
                              height: 1.6,
                            ),
                            colorClickableText: AppColors.blueText,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'read less',
                            moreStyle: TextStyle(
                              color: AppColors.blueText,
                              fontSize: AppSizer.getFontSize(12),
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.visible,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          GlassContainer(
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
                                          amount: _becomePartnerVM.userData.value.profile!.gender!.toLowerCase() == "male"
                                              ? "\$${_becomePartnerVM.businessDetailModel.value.admissionFee!.male!.amount}"
                                              : "\$${_becomePartnerVM.businessDetailModel.value.admissionFee!.female!.amount}",
                                          isFree: _becomePartnerVM.userData.value.profile!.gender!.toLowerCase() == "male"
                                              ? _becomePartnerVM.businessDetailModel.value.admissionFee!.male!.free!
                                              : _becomePartnerVM.businessDetailModel.value.admissionFee!.female!.free!,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Visibility(
                            visible: _becomePartnerVM.businessDetailModel.value.upcomingEvents!.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: AppSizer.getVerticalSize(15),),
                                AppText(text: AppStrings.upcomingEvent,
                                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),),
                                SizedBox(
                                  height: 12,
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: _becomePartnerVM.businessDetailModel.value.upcomingEvents!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Visibility(
                                        visible: _becomePartnerVM.businessDetailModel.value.upcomingEvents![index].eventDetails!.isNotEmpty,
                                        child: GestureDetector(
                                            onTap: (){
                                              _becomePartnerVM.openFlyer( _becomePartnerVM.businessDetailModel.value.upcomingEvents![index],0);
                                            },
                                            child: UpcomingTile(profileData:_becomePartnerVM.userData.value,upcomingEvents:_becomePartnerVM.businessDetailModel.value.upcomingEvents![index])));
                                  },
                                ),
                              ],
                            )
                          ),


                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          _becomePartnerVM.businessDetailModel.value.social!.length>0?AppText(text: AppStrings.ourSocialUrl,
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),):Container(),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _becomePartnerVM.businessDetailModel.value.social!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SocialTile(social:_becomePartnerVM.businessDetailModel.value.social![index]);
                              },
                            ),
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(80),),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: isEdit,
            child: GlassContainer(
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
                            Get.toNamed(AppRoutes.createBusiness,arguments: [_becomePartnerVM.businessDetailModel.value.bussinessCategory,_becomePartnerVM.businessDetailModel.value] )!.then((value) {
                              _becomePartnerVM.getBusinessDetail(_becomePartnerVM.businessDetailModel.value.sId!);
                            });
                          }),
                    ),
                    SizedBox(width: AppSizer.getHorizontalSize(10),),
                    Expanded(
                      child: CustomButton(
                          label: AppStrings.delete,
                          color: Colors.black.withOpacity(0.1),
                          onPressed: (){
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context){
                                  return CustomGlassDialog(
                                      title: _becomePartnerVM.businessDetailModel.value.bussinessName!,
                                      showContent: true,
                                      content: AppStrings.areYouSureYouWantToCancelBusiness,
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
                                        _becomePartnerVM.onDeleteBusiness(businessID: _becomePartnerVM.businessDetailModel.value.sId!).then((value) => {
                                          EasyLoading.dismiss(),
                                          Get.offAllNamed(AppRoutes.NAV_ROOT)
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
            ),
          )
        ],
      ):viewEventDetailShimmer(),)
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
          text: "Live",
          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

        ),
      ),
    );
  }
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


