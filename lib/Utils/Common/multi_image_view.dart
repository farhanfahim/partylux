// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Common/photo_popup.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import '../../Constants/color.dart';
import '../Theme/app_text.dart';
import 'common_image_view.dart';

class MultiImageView extends StatelessWidget {

  RxList<String> arrOfImage = List<String>.empty().obs;
  RxInt imageCount =5.obs;
  MultiImageView(this.arrOfImage);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            openCameraSheet(context);
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const [8, 7],
            color: AppColors.darkgrey,
            strokeWidth: 1,

            radius: Radius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteText.withOpacity(0.10),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(10))),
              height: AppSizer.getVerticalSize(140),
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Obx(() =>
                  arrOfImage.length>0
                      ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: arrOfImage[0].contains("https://")?CommonImageView(
                        url: arrOfImage[0],
                        height: AppSizer.getVerticalSize(140),
                        width: double.maxFinite,
                        fit: BoxFit.cover):CommonImageView(
                        file: File(arrOfImage[0].isNotEmpty ? arrOfImage[0] : ""),
                        height: AppSizer.getVerticalSize(140),
                        width: double.maxFinite,
                        fit: BoxFit.cover),) : Container(),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.imgGallery,
                        height: AppSizer.getSize(28),
                        width: AppSizer.getSize(28),
                      ),
                      SizedBox(height: 10,),
                      AppText(
                        text: "Upload Images",
                        color: AppColors.whiteText,
                        fontSize: AppSizer.getFontSize(13),
                      ),
                      SizedBox(height: 5,),
                      AppText(
                        text: "(Cover Image)",
                        color: AppColors.iconColor,
                        fontSize: AppSizer.getFontSize(11),
                      ),
                    ],
                  ),
                  Obx(() => arrOfImage.length>0
                      ? Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: (){
                        removeImage(0);
                      },
                      child: Container(
                          width:AppSizer.getSize(18),
                          height:AppSizer.getSize(18),
                          decoration: BoxDecoration(
                            color: AppColors.midGrey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding:AppSizer.getPadding(all: 2),
                            child: Image.asset(
                                AppImages.imgClose
                            ),
                          )
                      ),
                    ),
                  ) : Container(),)


                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: AppSizer.getSize(80.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return getAddImageView(
                    imagePath: arrOfImage.length>1?arrOfImage[1]:"",
                    onRemove: () {

                      removeImage(1);
                    },
                    onTapPick: () {
                      openCameraSheet(context);
                    });
              }),
              SizedBox(width: 10),
              Obx(() {
                return getAddImageView(
                    imagePath: arrOfImage.length>2?arrOfImage[2]:"",
                    onRemove: () {

                      removeImage(2);
                    },
                    onTapPick: () {
                      openCameraSheet(context);
                    });
              }),
              SizedBox(width: 10),
              Obx(() {
                return getAddImageView(
                    imagePath: arrOfImage.length>3?arrOfImage[3]:"",
                    onRemove: () {
                      removeImage(3);
                    },
                    onTapPick: () {
                      openCameraSheet(context);
                    });
              }),
              SizedBox(width: 10),
              Obx(() {
                return getAddImageView(
                    imagePath: arrOfImage.length>4?arrOfImage[4]:"",
                    onRemove: () {
                      removeImage(4);
                    },
                    onTapPick: () {
                      openCameraSheet(context);
                    });
              }),
            ],
          ),
        )
      ],
    );
  }

  // ================================ Camera Open Method
  void camera(isProfile) async {
/*    final pickedFile = await ImagesPicker.openCamera(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh16x9,
        cropType: CropType.rect,
      ),
    );*/
    final pickedFile = await ImagePickers.openCamera(
        compressSize: 500,
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (pickedFile != null ) {
      if(arrOfImage.length<5) {
        arrOfImage.add(pickedFile.path!);
        imageCount.value--;
      }
   /*   pickedFile.forEach((element) {
        if(arrOfImage.length<5) {
          arrOfImage.add(element.path);
          imageCount.value--;
        }
      });*/
    } else {
      print('No image selected.');
    }
  }

  // ================================ Gallery Open Method
  void photo(isProfile) async {

/*    final pickedFile = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh16x9,
        cropType: CropType.rect,
      ),
      count: imageCount.value
    );*/

    final pickedFile = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: imageCount.value,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: AppColors.backgroundColor),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if (pickedFile != null ) {
      pickedFile.forEach((element) {
        //arrOfImage.add(element.path);
        arrOfImage.add(element.path!);
        imageCount.value--;
      });
    } else {
      print('No image selected.');
    }

  }

  openCameraSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return PhotoPopUpSheet(
          callback: (val) {
            if (val == "take") {
              camera(false);
            } else if (val == "photo") {
              photo(false);
            }
            Get.back();
          },
        );
      },
    );
  }

  removeImage(pos){
    imageCount.value++;
    arrOfImage.removeAt(pos);
    arrOfImage.refresh();
  }

  Widget getAddImageView({String? imagePath,Function()? onRemove, Function()? onTapPick}) {
    return Expanded(
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [8, 7],
        radius: const Radius.circular(10),
        color: AppColors.darkgrey,
        strokeWidth: 1,
        child: Container(
          decoration: BoxDecoration(color: AppColors.whiteText.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          height: AppSizer.getSize(80),
          // width: getSize(78),
          child: Stack(
            children: [
              // Obx(() =>
              imagePath!.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(AppSizer.getHorizontalSize(10.00)),
                child: imagePath.contains("https://")?CommonImageView(
                    url: imagePath,
                    height: AppSizer.getVerticalSize(140),
                    width: double.maxFinite,
                    fit: BoxFit.cover):CommonImageView(
                    file: File(imagePath.isNotEmpty ? imagePath : ""),
                    height: AppSizer.getSize(80),
                    width: AppSizer.getSize(80),
                    fit: BoxFit.cover),
              ) : Align(
                alignment: Alignment.center,
                child: Container(

                ),
              ),

              InkWell(
                  onTap: onTapPick,
                  child: Container(
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: AppSizer.getSize(80),
                    width: AppSizer.getSize(80),
                  )),
              imagePath.isNotEmpty
                  ? Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                      width:AppSizer.getSize(18),
                      height:AppSizer.getSize(18),
                      decoration: BoxDecoration(
                        color: AppColors.midGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding:AppSizer.getPadding(all: 2),
                        child: Image.asset(
                            AppImages.imgClose
                        ),
                      )
                  ),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }



}
