import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/add_location_picker/view_model/add_location_picker_view_model.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/location_items.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import '../../../Constants/app_constants.dart';
import '../../../Constants/app_fonts.dart';
import '../model/local_location.dart';

class AddLocationPickerView extends GetView<AddLocationPickerViewModel> {
  AddLocationPickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double paddHorz = AppSizer.getHorizontalSize(AppDimen.horzPadd);
    return CustomScaffold(
        appbarColor: AppColors.bottomsheetLogout,
        appBarTitle: AppStrings.txtAddLocation,
        isLeftAlign: true,
        showBackBtn: true,
        isBodyPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.bottomsheetLogout,
              padding: EdgeInsets.only( left: paddHorz, right: paddHorz),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [


                  Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
                        child: GooglePlaceAutoCompleteTextField(
                          textEditingController:  controller.search.value,
                          googleAPIKey:AppConstants.map_apikey,
                          boxDecoration:BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          textStyle: TextStyle(
                              fontFamily: AppFonts.copperPlate2,
                              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                              color: AppColors.whiteText),
                          inputDecoration:  InputDecoration(
                            fillColor: AppColors.feildBGColor.withOpacity(0.10),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Container(
                              width: 10,
                              height: 10,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              child: CustomMonoIcon(
                                icon: AppImages.imgSearch,
                                size: null,
                                isSvg: false,
                                color: AppColors.grey4,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16.5),
                            hintText: AppStrings.txtSearchLocation,
                            filled: true,

                            hintStyle: TextStyle(
                                fontFamily: AppFonts.copperPlate2,
                                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                                color: AppColors.iconColor),
                          ),
                          debounceTime: 400,
                          isLatLngRequired: true,

                          getPlaceDetailWithLatLng: (Prediction prediction) async {

                            controller.predication.value = prediction;
                            controller.lat.value = double.parse(prediction.lat.toString());
                            controller.lng.value = double.parse(prediction.lng.toString());
                            print("lat " + controller.lat.value.toString());
                            print("lnt " + controller.lng.value.toString());
                            print("place " + controller.predication.value!.description!);

                            controller.selectLocation(LocalLocation(
                                type: "Point",
                                coordinates: [
                                  controller.lat.value,
                                  controller.lng.value
                                ],
                                radius: "50",
                                address: controller.predication.value!.description
                            ));

                            controller.moveToCameraLocation(latLng: LatLng(double.parse(controller.lat.value.toString()),
                                double.parse(controller.lng.value.toString())));


                          },

                          itemClick: (Prediction prediction) {
                            controller.search.value.text = prediction.description ?? "";
                            controller.search.value.selection = TextSelection.fromPosition(
                                TextPosition(offset: prediction.description?.length ?? 0));
                            if(controller.search.value.text.length>0){
                              controller.showCancelBtn.value = true;
                            }else{
                              controller.showCancelBtn.value = false;
                            }
                            FocusScope.of(context).unfocus();


                          },
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              decoration:BoxDecoration(
                                  color: AppColors.backgroundColor

                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CustomMonoIcon(icon: AppImages.icLocation2, size: AppSizer.getVerticalSize(18),
                                    color: AppColors.primary,isSvg: true,),
                                  SizedBox(width: AppSizer.getHorizontalSize(7),),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(text: prediction.structuredFormatting!.mainText!,fontSize: AppSizer.getFontSize(12),),
                                        AppText(text: "${prediction.structuredFormatting!.secondaryText!=null?prediction.structuredFormatting!.secondaryText!:"-"}",
                                          fontSize: AppSizer.getFontSize(12),fontWeight: FontWeight.w400,
                                          color: AppColors.grey4,),
                                      ],),
                                  ),
                                ],
                              ),
                            );
                          },
                          isCrossBtnShown: false,
                        ),
                      ),),
                      controller.showCancelBtn.value?Padding(
                        padding: AppSizer.getPadding(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.showCancelBtn.value = false;
                            controller.search.value.text = "";
                            Util.hideKeyBoard(context);
                          },
                          child: Center(
                            child: AppText(
                              text: AppStrings.cancel,
                              overflow: TextOverflow.visible,
                              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                              height: 1,
                              fontWeight: FontWeight.w700,
                              color:AppColors.iconColor,
                            ),
                          ),
                        ),
                      ):Container(),
                    ],
                  ),),
                  SizedBox(height: AppSizer.getVerticalSize(17),),

                ],
              ),
            ),
            Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Obx(() {
                          return GoogleMap(
                            onMapCreated: controller.onMapCreated,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(28.4212, 70.2989),
                              zoom: 16.0,
                            ),
                            zoomControlsEnabled: false,
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                            mapType: MapType.normal,
                            circles: controller.circles.value,
                            onTap: (v) async {
                              controller.predication.value = null;
                              controller.mainText.value = "";
                              controller.secondaryText.value = "";
                              controller.moveToCameraLocation(latLng: v);
                              controller.getAddressFromLatLng(context,v.latitude,v.longitude).then((value) {
                                List<String> splitString =value.split(",");
                                controller.mainText.value = splitString[0];
                                controller.secondaryText.value = value;
                                controller.selectLocation(LocalLocation(
                                    type: "Point",
                                    coordinates: [
                                      v.latitude,
                                      v.longitude
                                    ],
                                    radius: "50",
                                    address: value
                                ));
                              });

                            },
                          );
                        }),
                      ),
                      Positioned(
                        bottom: AppSizer.getVerticalSize(AppDimen.locBottomPadd),
                        left: paddHorz,right: paddHorz,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){

                                controller.initCurrentLocation();
                                controller.showCancelBtn.value = false;
                                controller.search.value.text = "";
                                Util.hideKeyBoard(context);

                              },
                              child: Container(
                                width: AppSizer.getHorizontalSize(42),
                                height: AppSizer.getHorizontalSize(42),
                                margin: EdgeInsets.only( bottom: 20),
                                decoration: BoxDecoration(
                                  color: AppColors.bottomsheetLogout,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.topLeft,
                                child: Center(
                                     child: SvgPicture.asset(AppImages.currentLocation,
                                       color: AppColors.primary,
                                       width: AppSizer.getHorizontalSize(24),)
                                ),
                              ),
                            ),

                            Obx(
                                    () {
                                      if(controller.predication.value!=null) {
                                        controller.mainText.value = controller.predication.value!.structuredFormatting!.mainText!;
                                        controller.secondaryText.value = controller.predication.value!.structuredFormatting!.secondaryText != null ?
                                        controller.predication.value!.structuredFormatting!.secondaryText! : "-";
                                      }
                                  return Column(children: [
                                    controller.mainText.isNotEmpty ?Padding(
                                        padding: EdgeInsets.only(bottom: AppSizer.getVerticalSize(16)),
                                        child: SearchedLocationItem(mainText: controller.mainText.value,
                                          secondaryText: controller.secondaryText.value,)
                                    ):const SizedBox.shrink(),
                                    AppButton.mainButton(
                                      context,
                                      text: AppStrings.continueTxt,
                                      onPressed: () {
                                         Get.back(result: controller.location.value);

                                      },
                                      buttonColor: controller.mainText.isEmpty?AppColors.bottomsheetLogout:null,

                                    ),
                                  ],);
                                }
                            ),
                          ],
                        ),


                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
