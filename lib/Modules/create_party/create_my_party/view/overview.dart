import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/add_location_picker/model/local_location.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Utils/Common/checkbox.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
import 'package:partylux/Utils/Common/custom_switch_button.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/image_upload.dart';
import 'package:partylux/Utils/Common/photo_popup.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/widgets.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/Utils/date_time_util.dart';
import 'package:partylux/Utils/helper_functions.dart';

import '../../../../Constants/constants.dart';
import '../../../BecomePartner/Model/become_partner_model.dart';
import '../../../common/bottom_sheets/item_sheet/item_sheet.dart';

class OverviewView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  OverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreatePartyViewModel viewModel = Get.find<CreatePartyViewModel>();
    final double spacing = AppSizer.getVerticalSize(AppDimen.formBwSpacing);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: AppSizer.getVerticalSize(AppDimen.vertPadd),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: viewModel.title,
              textInputType: TextInputType.name,
              label: AppStrings.txtAddTitle,
              hintText: AppStrings.txtEnterPartyTitle,
              /*    onChanged: (val){
                viewModel.event.name=val;
              },*/
              onChanged: (v){
                if(v.startsWith(' ')){
                  viewModel.title.text = '';
                }
              },
              maxLength: 100,
              validator: (val) {
                return HelperFunction.emptyValitate(val!, field: AppStrings.txtAddTitle);
              },
            ),
            SizedBox(
              height: spacing,
            ),
            buildFieldValue(AppStrings.txtUploadCoverImage, Obx(() {
              return ImageUploadContainer(
                isCover: true,
                image: viewModel.coverImage.value,
                text: AppStrings.txtAddCoverImage,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext bc) {
                      return PhotoPopUpSheet(
                        callback: (val) {
                          viewModel.camera(val);
                          Get.back();
                        },
                      );
                    },
                  );
                },
              );
            })),
            SizedBox(
              height: spacing,
            ),
            buildFieldValue(
                AppStrings.txtEventDescription,
                Container(
                  height: AppSizer.getVerticalSize(AppDimen.descriptionFieldHeight),
                  child: CustomTextField(
                    controller: viewModel.description,
                    textInputType: TextInputType.text,
                    label: "",
                    textInputAction: TextInputAction.done,
                    hintText: AppStrings.txtEventDescription,
                    expands: true,
                    onChanged: (v){
                      if(v.startsWith(' ')){
                        viewModel.description.text = '';
                      }
                    },
                    maxLength: 250,
                    textAlignVertical: TextAlignVertical.top,
                    validator: (val) {
                      return HelperFunction.emptyValitate(val!, field: AppStrings.txtEventDescription);
                    },
                  ),
                )),

            SizedBox(
              height: spacing,
            ),
            Row(children: [
              Expanded(child:buildFieldValue(
                AppStrings.from,
                CustomTextField(
                  controller: viewModel.startDate,
                  // label: AppStrings.setDate,
                  readOnly: true,
                  //focusNode: _createFlyerVM.dateNode,
                  textInputType: TextInputType.name,
                  hintText: AppStrings.selectDate,
                  onTap: () {
                    CommonMethods.showCustomDatePicker(context, onDateSelect: (val) {

                      if(viewModel.endDate.text.isNotEmpty) {
                        if(val.isAtSameMomentAs(DateFormat(DateTimeUtil.dateTimeFormat6).parse(viewModel.endDate.text))){
                          viewModel.startDate.text =
                              DateTimeUtil.formatDateTime(val,
                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                        }else{
                          if (val.isBefore(DateFormat(DateTimeUtil.dateTimeFormat6).parse(viewModel.endDate.text))) {
                            viewModel.startDate.text =
                                DateTimeUtil.formatDateTime(val,
                                    outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                          }
                        }
                      }else{
                        viewModel.startDate.text =
                            DateTimeUtil.formatDateTime(val,
                                outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                      }

                      print(viewModel.startDate.text);
                    });
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDate,
                    ),
                  ),
                  validator: (val) {
                    return HelperFunction.emptyValitate(val!, field: AppStrings.selectDate);
                  },
                ),
              ),),
              SizedBox(width: AppSizer.getHorizontalSize(10),),
              Expanded(child:buildFieldValue(
                AppStrings.to,
                CustomTextField(
                  controller: viewModel.endDate,
                  // label: AppStrings.setDate,
                  readOnly: true,
                  //focusNode: _createFlyerVM.dateNode,
                  textInputType: TextInputType.name,
                  hintText: AppStrings.selectDate,
                  onTap: () {
                    CommonMethods.showCustomDatePicker(context, onDateSelect: (val) {
                      if(viewModel.startDate.text.isNotEmpty) {


                        if(val.isAtSameMomentAs(DateFormat(DateTimeUtil.dateTimeFormat6).parse(viewModel.startDate.text))){
                          viewModel.endDate.text =
                              DateTimeUtil.formatDateTime(val,
                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                        }else{
                          if (val.isAfter(DateFormat(DateTimeUtil.dateTimeFormat6).parse(viewModel.startDate.text))) {
                            viewModel.endDate.text =
                                DateTimeUtil.formatDateTime(val,
                                    outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                          }
                        }
                      }else{
                        viewModel.endDate.text =
                            DateTimeUtil.formatDateTime(val,
                                outputDateTimeFormat: DateTimeUtil.dateTimeFormat6);
                      }
                    });
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDate,
                    ),
                  ),
                  validator: (val) {
                    return HelperFunction.emptyValitate(val!, field: AppStrings.selectDate);
                  },
                ),
              ),),
            ],),


            SizedBox(
              height: spacing,
            ),

            Row(children: [
              Expanded(child: buildFieldValue(
                AppStrings.from,
                CustomTextField(
                  controller: viewModel.start_time,
                  //label: AppStrings.setDate,
                  readOnly: true,
                  //focusNode: _createFlyerVM.dateNode,
                  textInputType: TextInputType.name,
                  hintText: AppStrings.startTime,
                  onTap: () {
                    CommonMethods.showCustomTimePicker2(context, onTimeSelect: (val) {
                      viewModel.start_time.text=DateTimeUtil.formatDateTime(val,
                          outputDateTimeFormat: DateTimeUtil.dateTimeFormat4);
                      print(viewModel.start_time.text);
                    });
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDate,
                    ),
                  ),
                  validator: (val) {
                    return HelperFunction.emptyValitate(val!, field: AppStrings.startTime);
                  },
                ),
              ),),
              SizedBox(width: AppSizer.getHorizontalSize(10),),
              Expanded(child: buildFieldValue(
                AppStrings.to,
                CustomTextField(
                  controller: viewModel.end_time,
                  //label: AppStrings.setDate,
                  readOnly: true,
                  //focusNode: _createFlyerVM.dateNode,
                  textInputType: TextInputType.name,
                  hintText: AppStrings.endTime,
                  onTap: () {
                    CommonMethods.showCustomTimePicker2(context, onTimeSelect: (val) {
                      viewModel.end_time.text=DateTimeUtil.formatDateTime(val,
                          outputDateTimeFormat: DateTimeUtil.dateTimeFormat4);
                      print(viewModel.end_time.text);
                    });
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDate,
                    ),
                  ),
                  validator: (val) {
                    return HelperFunction.emptyValitate(val!, field: AppStrings.endTime);
                  },
                ),
              ),),
            ],),


            SizedBox(
              height: spacing,
            ),

            Visibility(
              visible: viewModel.arguments[Constants.paramFrom] != Constants.CATEGORY_HOUSE_PARTY,
              child: CustomTextField(
                controller: viewModel.businessController,
                label: AppStrings.selectBusiness,
                readOnly: true,
                dotted: true,
                focusNode: viewModel.businessNode,
                textInputType: TextInputType.name,
                hintText: AppStrings.selectBusiness,
                onTap: () {
                  Util.showBottomSheet2(context,
                      child: ItemSheet(
                          screenTitle: AppStrings.selectType,
                          initialItems: viewModel.myClubList,
                          onDone: (val){
                            viewModel.businessController.text=(val as BecomePartnerModel).getText();
                            viewModel.selectedBusiness=val;
                            viewModel.location.text = val.place!;
                            viewModel.event.location = LocalLocation(
                              type: "Point",
                              coordinates: val.location!.coordinates,
                              radius: val.location!.radius,
                              address: val.place!
                            );
                          },
                          onDispose: (val){
                            viewModel.myClubList = val;
                          },
                          onLoad: (page,search){
                            return viewModel.getBusinessList(page: page);
                          }));


                },
                suffix: Container(
                  width: 10,
                  height: 10,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: SvgPicture.asset(
                    AppImages.icDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: spacing,
            ),
            buildFieldValue(
              AppStrings.txtTicketPrice,
              Column(
                children: [
                  Obx(() {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: buildCheck(AppStrings.txtMale, AppStrings.txtFree, color: AppColors.blueText, value: viewModel.maleFree.value,
                                onChange: (val) {
                          viewModel.maleFree.value = val;
                          // viewModel.maleAmount.clear();
                        })),
                        Expanded(
                            child: buildField(
                                AppStrings.txtAmount,
                                AmountField(
                                  controller: viewModel.maleAmount,
                                  //enabled: !viewModel.maleFree.value,
                                  readOnly:viewModel.maleFree.value,
                                  onCheck:(val){
                                    viewModel.maleFree.value=!val;
                                  },
                                  validator: (val) {
                                    return !viewModel.maleFree.value ? HelperFunction.emptyValitate(val!,
                                        field: AppStrings.txtAmount) : null;
                                  },
                                ))),
                      ],
                    );
                  }),
                  SizedBox(
                    height: AppSizer.getVerticalSize(18),
                  ),
                  Obx(() {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: buildCheck(AppStrings.txtFemale, AppStrings.txtFree, color: AppColors.primary, value: viewModel.femaleFree.value,
                                onChange: (val) {
                          viewModel.femaleFree.value = val;
                          //  viewModel.femaleAmount.clear();
                        })),
                        Expanded(
                            child: buildField(
                                AppStrings.txtAmount,
                                AmountField(
                                  controller: viewModel.femaleAmount,
                                  readOnly: viewModel.femaleFree.value,
                                  onCheck:(val){
                                    viewModel.femaleFree.value=!val;
                                  },
                                  validator: (val) {
                                    return !viewModel.femaleFree.value ? HelperFunction.emptyValitate(val!, field: AppStrings.txtAmount) : null;
                                  },
                                ))),
                      ],
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: spacing,
            ),
            CustomTextField(
              controller: viewModel.location,
              readOnly: true,
              prefix: Container(
                width: 10,
                height: 10,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: CustomMonoIcon(
                  icon: AppImages.icLocation,
                  size: null,
                  isSvg: false,
                  color: AppColors.whiteText,
                ),
              ),
              label: AppStrings.txtPartyLocation,
              hintText: AppStrings.txtEnterLocation,
              onTap: () {
                if(viewModel.arguments[Constants.paramFrom] == Constants.CATEGORY_HOUSE_PARTY){
                  CommonMethods.showLocationPicker((loc) {
                    viewModel.location.text = loc.address!;
                    viewModel.event.location = loc;
                  });
                }

              },
              validator: (val) {
                return HelperFunction.emptyValitate(
                  val!,
                  field: AppStrings.txtPartyLocation,
                );
              },
            ),
            SizedBox(
              height: spacing,
            ),
            CustomSwitchButton(
              height: AppSizer.getVerticalSize(AppDimen.switchBtnHeight),
              onTrigger: () async {
                bool val = formKey.currentState!.validate();
                if (val) {
                  val=await viewModel.switchAction();
                }
                return val;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String field, Widget value, {Color color = AppColors.whiteText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          text: field,
          fontSize: AppSizer.getFontSize(11),
          color: color,
        ),
        SizedBox(
          height: AppSizer.getVerticalSize(7),
        ),
        value,
      ],
    );
  }

  Widget buildCheck(
    String text1,
    String text2, {
    Color color = AppColors.whiteText,
    bool value = false,
    required void Function(bool val) onChange,
  }) {
    return buildField(
        text1,
        Padding(
          padding: EdgeInsets.only(top: AppSizer.getVerticalSize(9)),
          child: CheckBoxField(
            initialValue: value,
            simpleTitle: text2,
            callback: onChange,
          ),
        ),
        color: color);
  }
}
