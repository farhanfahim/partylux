import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/griddelegate.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/strings.dart';

class HomeViewAllFilterView extends StatelessWidget {
  HomeViewAllFilterView({super.key});

  final _homeVM = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      appBarTitle: "Filters",
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20),
            AppText(
              text: "Location",
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16)
            ),
            SizedBox(height: AppSizer.getVerticalSize(10)),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 3,
                  height: 45,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: _homeVM.arrFilter.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => tileFilter(
                    title: _homeVM.arrFilter[index].distance == 0.5?"nearest":_homeVM.arrFilter[index].distance!.toStringAsFixed(0)+" km",
                    isActive: _homeVM.arrFilter[index].isLocationSelected!.value,
                    callback: (val) {


                      if(_homeVM.arrFilter[index].isLocationSelected!.value){
                        _homeVM.arrFilter[index].isLocationSelected!.value = false;
                        _homeVM.isLocationSelected.value = false;
                      }else{
                        _homeVM.arrFilter.forEach((item) {
                          item.isLocationSelected!.value = false;
                        });
                        _homeVM.arrFilter[index].isLocationSelected!.value = true;
                        _homeVM.isLocationSelected.value = true;
                      }
                      _homeVM.locationFilter.value = _homeVM.arrFilter[index].distance!;

                    },
                  ));
                },
              ),
            ),
            SizedBox(height: AppSizer.getVerticalSize(20)),
            AppText(
              text: AppStrings.txtMaxCapacity,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16)
            ),
            SizedBox(height: AppSizer.getVerticalSize(10)),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 3,
                    height: 45,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemCount: _homeVM.arrFilter.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() => tileFilter(
                      title: _homeVM.arrFilter[index].maxPeople==50000? "unlimited":"${_homeVM.arrFilter[index].minPeople} - ${_homeVM.arrFilter[index].maxPeople}",
                      isActive: _homeVM.arrFilter[index].isPeopleSelected!.value,
                      callback: (val) {
                        if(_homeVM.arrFilter[index].isPeopleSelected!.value){
                          _homeVM.arrFilter[index].isPeopleSelected!.value = false;
                          _homeVM.isCapacitySelected.value = false;
                        }else{
                          _homeVM.arrFilter.forEach((item) {
                            item.isPeopleSelected!.value = false;
                          });
                          _homeVM.arrFilter[index].isPeopleSelected!.value = true;
                          _homeVM.isCapacitySelected.value = true;
                        }

                        _homeVM.peopleCapacityMin.value = _homeVM.arrFilter[index].minPeople!;
                        _homeVM.peopleCapacityMax.value = _homeVM.arrFilter[index].maxPeople!;
                      },
                    ));
                  }),
            ),
            SizedBox(height: AppSizer.getVerticalSize(20)),
            AppText(
                text: "Booking Price",
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16)
            ),
            FlutterSlider(
                      values: [double.parse(_homeVM.priceRangeMin.value.toString()) , double.parse(_homeVM.priceRangeMax.value.toString())],
                      max: 1000,
                      min: 0,
                      tooltip: FlutterSliderTooltip(
                          alwaysShowTooltip:true,
                        positionOffset: FlutterSliderTooltipPositionOffset(top:48.0),
                        format: (v){
                          double.parse(v);
                            return "${double.parse(v).toStringAsFixed(0)}\$";
                          },
                        textStyle: TextStyle(
                          fontFamily: AppFonts.lexendDica,
                          overflow: TextOverflow.visible,
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w400,
                          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                        ),
                        boxStyle: FlutterSliderTooltipBox(
                          decoration: BoxDecoration(
                              color: AppColors.transparent
                          ),
                        )
                      ),
                      handler: FlutterSliderHandler(
                          decoration: BoxDecoration(
                            color: AppColors.transparent
                          ),
                          child: Container(
                            width: AppSizer.getSize(18),
                            height: AppSizer.getSize(18),
                        decoration: BoxDecoration(
                         color: AppColors.primary,
                          border: Border.all(color: AppColors.whiteText,width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      )),
                      rightHandler: FlutterSliderHandler(
                          decoration: BoxDecoration(
                              color: AppColors.transparent
                          ),
                          child: Container(
                            width: AppSizer.getSize(18),
                            height: AppSizer.getSize(18),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              border: Border.all(color: AppColors.whiteText,width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )),
                      trackBar:FlutterSliderTrackBar(
                          inactiveTrackBar: BoxDecoration(
                          color: AppColors.midGrey
                      ),
                        activeTrackBar: BoxDecoration(
                            color: AppColors.primaryText
                        ),
                          activeTrackBarHeight:6,
                          inactiveTrackBarHeight:6
                      ),
                      maximumDistance: 1000,
                      rangeSlider: true,
                      handlerAnimation: FlutterSliderHandlerAnimation(
                          curve: Curves.elasticOut,
                          reverseCurve: null,
                          duration: Duration(milliseconds: 700),
                          scale: 1.4),
                      onDragging: (handlerIndex, lowerValue, upperValue) {

                        _homeVM.priceRangeMin.value = lowerValue.toInt();
                        _homeVM.priceRangeMax.value = upperValue.toInt();
                      },
                    ),
            Spacer(),
            Obx(
              () => AppButton.mainButton(
                context,
                text: "Apply",
                loading: _homeVM.isLoadingFilter.value,
                onPressed: () {
                  _homeVM.isFilterApply.value = true;
                  Get.back();
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget tileFilter({
    required String title,
    required Function callback,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        callback(title);
      },
      child: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isActive ? null : AppColors.midGrey,
          gradient: isActive
              ? LinearGradient(
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
            color: isActive ?AppColors.whiteText:AppColors.iconColor,
            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12)
          ),
        ),
      ),
    );
  }
}
