import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../View Model/location_radius_vm.dart';
class LocationRadiusView extends StatefulWidget {
  LocationRadiusView({Key? key}) : super(key: key);

  @override
  State<LocationRadiusView> createState() => _LocationRadiusViewState();
}

class _LocationRadiusViewState extends State<LocationRadiusView> {


  final _updateVM = Get.find<LocationRadiusViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: true,
        showBackBtn: true,
        appBarTitle: "Set Radius",
        body: SizedBox.expand(
          child: Column(
            children: [

              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Container(
                width: SizeConfig.screenWidth ,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteText.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:22.0,top: 15),
                      child: AppText(
                        text:"Map Radius", //"Club Party",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [ 
                        Obx(() => Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 1,
                              thumbColor: AppColors.primary,
                            ),
                            child: Slider(
                              value:_updateVM.min.value,
                              activeColor: AppColors.primary,
                              inactiveColor: AppColors.whiteText,
                              max: 50.0,
                              min: 0.0,
                              onChanged: (double newValue) {
                                _updateVM.min.value = newValue;
                              },
                            ),
                          ),
                        ),),
                        Obx(() => AppText(
                          text:"${_updateVM.min.value.toStringAsFixed(0)} MI", //"Club Party",
                          fontSize: SizeConfig.screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                        ),),
                        SizedBox(width: 20,)

                      ],
                    )

                  ],
                ),
              ),
              Spacer(),

              AppButton.mainButton(
                context,
                text: "Update",
                loading: _updateVM.isLoading.value,
                onPressed: () async {
                  await DatabaseHandler().setRadius(_updateVM.min.value);
                  Get.back();
                },
              ),
              SizedBox(height: 40,)
            ],
          ),
        ));
  }
}
