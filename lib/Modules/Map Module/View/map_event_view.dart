// ignore_for_file: unused_shown_name, invalid_use_of_protected_member

import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show ByteData, NetworkAssetBundle, Uint8List, rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Custom Views/custom_scaffold.dart';
import '../View Model/map_view_model.dart';
class MapView extends StatelessWidget {
  MapView({Key? key}) : super(key: key);

  final _mapVM = Get.put(MapEventViewModel());


  @override
  Widget build(BuildContext context) {

    return Obx(() => CustomScaffold(
      isBodyPadding: false,
      isLeftAlign: true,
      showBackBtn: false,
      appBarTitle:"All Events",
      appbarTextColor:AppColors.primaryText,
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenWidth * 0.095,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: 16,
                  right: SizeConfig.screenWidth * 0.05 / 2,
                ),
                scrollDirection: Axis.horizontal,
                children: [

                  customButton(
                    title: "Clubs",
                    isActive: _mapVM.checkActive == 0 ? true : false,
                    callback: () async {
                      _mapVM.customInfoWindowController.hideInfoWindow!();
                      _mapVM.checkActive.value = 0;
                      _mapVM.getEvent(categoryType:Constants.CATEGORY_CLUB);

                    },
                  ),
                  customButton(
                    title: "Parties",
                    isActive: _mapVM.checkActive == 1 ? true : false,
                    callback: () async {
                      _mapVM.customInfoWindowController.hideInfoWindow!();
                      _mapVM.checkActive.value = 1;
                      _mapVM.getEvent(categoryType:Constants.CATEGORY_HOUSE_PARTY);


                    },
                  ),
                  customButton(
                    title: "Bars",
                    isActive: _mapVM.checkActive == 2 ? true : false,
                    callback: () {
                      _mapVM.customInfoWindowController.hideInfoWindow!();
                      _mapVM.checkActive.value = 2;
                      _mapVM.getEvent(categoryType:Constants.CATEGORY_BAR);

                    },
                  ),
                  customButton(
                    title: "Beaches",
                    isActive: _mapVM.checkActive == 3 ? true : false,
                    callback: () {
                      _mapVM.customInfoWindowController.hideInfoWindow!();
                      _mapVM.checkActive.value = 3;
                      _mapVM.getEvent(categoryType:Constants.CATEGORY_BEACH);

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    markers: _mapVM.markers.value,
                    onMapCreated: _mapVM.onMapCreated,
                    onCameraMove: (v){
                      _mapVM.customInfoWindowController.onCameraMove!();
                    },
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(28.4212, 70.2989),
                      zoom: 16.0,
                    ),
                    onTap: (v){

                      _mapVM.customInfoWindowController.hideInfoWindow!();
                    },
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    // set this to false
                    mapType: MapType.normal,
                    circles: _mapVM.circles.value,
                  ),
                  CustomInfoWindow(
                    width: AppSizer.getHorizontalSize(_mapVM.windowWidth.value),
                    height: AppSizer.getVerticalSize(80),
                    controller:  _mapVM.customInfoWindowController,
                  ),
                  Positioned(
                    bottom:-20,
                    right: 20,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                    onTap: (){
                      print(_mapVM.checkActive.value);
                       if(_mapVM.checkActive.value == 0){
                        Get.toNamed(AppRoutes.mapListingView,arguments:  Constants.CATEGORY_CLUB);
                      }else if(_mapVM.checkActive.value == 1){
                        Get.toNamed(AppRoutes.mapListingView,arguments: Constants.CATEGORY_HOUSE_PARTY);
                      }else if(_mapVM.checkActive.value == 2){
                        Get.toNamed(AppRoutes.mapListingView,arguments:  Constants.CATEGORY_BAR);
                      }else if(_mapVM.checkActive.value == 3){
                        Get.toNamed(AppRoutes.mapListingView,arguments:  Constants.CATEGORY_BEACH);
                      }

                    },
                    child: Container(
                      width: AppSizer.getHorizontalSize(42),
                      height: AppSizer.getHorizontalSize(35),
                      margin: EdgeInsets.only(left: 20,bottom: 50),
                      decoration: BoxDecoration(
                        color: AppColors.midGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.topLeft,
                      child: Center(
                          child: Image.asset(AppImages.imgMenu,width: AppSizer.getHorizontalSize(24),)
                      ),
                    ),
                  ),)
                ],
              ),
            ),

            SizedBox(height: 80,),
          ],
        ),
      ),
    ));
  }

  GestureDetector customButton({
    required String title,
    required bool isActive,
    required Function callback,
  }) {
    return GestureDetector(

      behavior: HitTestBehavior.opaque,
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isActive
              ? const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0, 1],
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          )
              : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0],
            colors: [
              AppColors.midGrey,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.03,
          vertical: SizeConfig.screenWidth * 0.03,
        ),
        margin: EdgeInsets.only(right: 10),
        child: Center(
          child: AppText(
            text: title,
            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
          ),
        ),
      ),
    );
  }

}

