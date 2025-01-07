import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/custom_rectangle_checkbox.dart';
import 'package:partylux/Utils/Common/custom_switch_button.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/gradient_text.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/app_routes.dart';
import '../../Modules/My Business/Model/business_detail_model.dart';
import '../../Modules/My Business/View Model/mybusiness_vm.dart';
import 'common_image_view.dart';


class CustomDialog extends StatefulWidget {
  final UpcomingEvents data;
  final becomePartnerVM = Get.find<MyBusinessVM>();
  RxBool isActive = false.obs;

  CustomDialog({required this.data});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}



class _CustomDialogState extends State<CustomDialog> {

  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    if(widget.data.mediaType == "video"){
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.data.media!));
      chewieController = ChewieController(
          aspectRatio: 2.3,
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
          showControls: false,
          showOptions: false,
          allowFullScreen: false
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(

          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            image: DecorationImage(
              image: AssetImage(AppImages.imgBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.data.mediaType != "video"?SizedBox(
                height: AppSizer.getVerticalSize(250),
                width: double.maxFinite,
                child: ClipRRect(
                  child: CommonImageView(
                    url: widget.data.media,
                  ),), //will be change to image network when alpha completed
              ):Container(
                height: 180,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
              Expanded(child: Padding(
                padding: AppSizer.getPadding(left: 14,right: 14,top: 30,bottom: 30),
                child: Column(
                  children: [
                    Column(
                      children: [
                        GlassContainer(
                            gradientColors: [
                              AppColors.female.withOpacity(0.2),
                              AppColors.primaryText.withOpacity(0.2),
                            ],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppImages.icGradientCalendar),
                                SizedBox(width: AppSizer.getHorizontalSize(15),),
                                AppText(text: "${DateFormat('d MMM yyyy').format(DateTime.parse(widget.data.eventDate!))}",//"31 December 2024",
                                  fontSize: AppSizer.getFontSize(10),)
                              ],
                            )),
                        SizedBox(height: AppSizer.getVerticalSize(15),),
                        GlassContainer(
                            color: AppColors.male,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.imgTimer,color: AppColors.male,height: AppSizer.getVerticalSize(25),),
                                SizedBox(width: AppSizer.getHorizontalSize(15),),
                                AppText(text: "${calculateTime(widget.data.fromTime)} - ${calculateTime(widget.data.toTime)}",fontSize: AppSizer.getFontSize(10),)
                              ],
                            )),
                        SizedBox(height: AppSizer.getVerticalSize(25),),
                        AppText(
                          text: widget.data.description!,
                          fontSize: AppSizer.getFontSize(12),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.copperPlate2,
                          height: 1.8,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSizer.getVerticalSize(25),),
                        AppText(text: AppStrings.ticketFee,fontSize: AppSizer.getFontSize(14),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.copperPlate2,),
                        GradientText("\$${widget.data.admissionFee}",
                            fontSize: 28,
                            gradient: LinearGradient(
                                colors: [
                                  AppColors.female,
                                  AppColors.primaryText,
                                ]
                            )),
                        SizedBox(height: AppSizer.getVerticalSize(30),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => CustomRectangleCheckbox(selected: widget.isActive.value,
                              isBold: true,
                              onChanged: (bool value) {
                                widget.isActive.value = value;
                                widget.becomePartnerVM.onHideFlyer(flyerId: widget.data.sId!);
                                videoPlayerController.dispose();
                                chewieController.dispose();
                                Get.back();
                              },),),
                            SizedBox(width: AppSizer.getHorizontalSize(15),),
                            AppText(text: AppStrings.doNotShowAgain,fontSize: AppSizer.getFontSize(13),fontWeight: FontWeight.w500,fontFamily: AppFonts.copperPlate2,)
                          ],
                        ),
                        SizedBox(height: AppSizer.getVerticalSize(20),),
                      ],
                    ),
                    Spacer(),
                    CustomSwitchButton(
                      swipeText:AppStrings.txtSwipeToReserve,
                      onTrigger: () async{
                        videoPlayerController.dispose();
                        chewieController.dispose();
                        Get.back();

                        return widget.becomePartnerVM.reserveEvent(widget.data.admissionFee!>0?false:true,widget.data.eventDetails!.first.sId);
                      },
                      height: AppSizer.getVerticalSize(50),
                    )
                  ],
                ),
              ),)
            ],
          ),
        ),
        Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.back();
                },
                child: Container(
                    color: AppColors.midGrey.withOpacity(0.5),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(AppImages.imgClose,height: AppSizer.getVerticalSize(20),))))
      ],
    );
  }


  @override
  void dispose() {

    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}

String calculateTime(time){
  List<String> parts = time.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  return DateFormat('h:mm a').format(DateTime(2024, 1, 1, hour, minute));

}