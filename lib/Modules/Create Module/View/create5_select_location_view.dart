import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/create_map_view.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class SelectLocationOnMap extends StatelessWidget {
  SelectLocationOnMap({super.key});

  final _createEventVM = Get.find<CreateViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
      isBodyPadding: false,
      showBackBtn: false,
      body: Stack(
        children: [
          const GoogleMapView(),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.whiteText,
                                size: SizeConfig.screenWidth * 0.06,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.05),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: "Set Event Location",
                      fontSize: SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.005),
                  AppTextField.search(context,
                      hintText: "Set Your Event Location by search",
                      controller: _createEventVM.searchController.value,
                      onChanged: (val) {
                    _createEventVM.autocomplete(val);
                  }),
                  Container(
                    height: 50.0 * _createEventVM.placesListData.length,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.black54,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _createEventVM.placesListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                          () => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _createEventVM.setPlace(
                                      _createEventVM.placesListData[index]);
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.transparent,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: AppText(
                                    text: _createEventVM
                                        .placesListData[index].name,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: SizeConfig.screenWidth * 0.033,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: index !=
                                    _createEventVM.placesListData.length - 1,
                                child: Divider(
                                  height: 0,
                                  thickness: 0.6,
                                  color: AppColors.whiteText,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Visibility(
                      visible: !_createEventVM.isKeyboard.value,
                      child: AppButton.mainButton(
                        context,
                        text: "Submit",
                        onPressed: () {
                          _createEventVM.onLocatioSubmit();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
