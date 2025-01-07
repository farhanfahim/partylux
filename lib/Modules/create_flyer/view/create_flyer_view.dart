import 'package:chewie/chewie.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/common/bottom_sheets/item_sheet/item_sheet.dart';
import 'package:partylux/Modules/create_flyer/view_model/create_flyer_vm.dart';
import 'package:partylux/Utils/Common/image_upload.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/models/media.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/photo_popup.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../../Utils/date_time_util.dart';
import '../../../Utils/helper_functions.dart';

class CreateFlyerView extends StatelessWidget {
  CreateFlyerView({super.key});
  final _createFlyerVM = Get.find<CreateFlyerViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: false,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        appBarTitle: AppStrings.createAFlyer,
        isTopPadding: 30,
        body: ListView(
          children: [
            AppText(
              text: AppStrings.addMedia,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            ),
            SizedBox(height: 12),
            Obx(() {
              return _createFlyerVM.isVideo.value == false?ImageUploadContainer(
                isCover: true,
                image: Media(value:_createFlyerVM.coverMedia.value,imageType:ImageType.TYPE_FILE),
                text: AppStrings.addPromo,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext bc) {
                      return PhotoPopUpSheet(
                        isShowVideo: true,
                        callback: (val) {
                          _createFlyerVM.camera(val);
                          Get.back();
                        },
                      );
                    },
                  );
                },
              )
              : Stack(
                children: [

                  Container(
                    height: 180,
                    child: Chewie(
                      controller: _createFlyerVM.chewieController,
                    ),
                  ),
                  Positioned(
                    right:0,top:4,child: GestureDetector(
                    onTap: (){
                      _createFlyerVM.videoPlayerController.pause();
                      _createFlyerVM.coverMedia.value = "";
                      _createFlyerVM.isVideo.value = false;
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      color: AppColors.black.withOpacity(0.2),
                      child: Image.asset(
                        AppImages.imgClose,
                      ),
                    ),
                  ),),

                ],
              );
            }),
            SizedBox(height: 20),
            CustomTextField(
              controller: _createFlyerVM.dateController,
              label: AppStrings.setDate,
              readOnly: true,
              focusNode: _createFlyerVM.dateNode,
              textInputType: TextInputType.name,
              hintText: AppStrings.selectDate,
              onTap: () {
                CommonMethods.showCustomDatePicker(
                  context,
                 // selectedDate: _createFlyerVM.selectedDate,
                  onDateSelect: (selectedDate) {
                    _createFlyerVM.dateController.text =
                        DateTimeUtil.formatDateTime(selectedDate, outputDateTimeFormat: DateTimeUtil.dateTimeFormat7);
                    _createFlyerVM.checkForm();
                  },
                );
              },
              prefix: Container(
                width: 10,
                height: 10,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: SvgPicture.asset(
                  AppImages.icDate,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _createFlyerVM.startTimeController,
                    label: AppStrings.from,
                    focusNode: _createFlyerVM.startTImeNode,
                    textInputType: TextInputType.name,
                    hintText: AppStrings.startTime,
                    onTap: () {
                      CommonMethods.showCustomTimePicker2(
                        context,
                        //selectedTime: _createFlyerVM.startTime,
                        onTimeSelect: (selectedTime) {
                          _createFlyerVM.startTimeController.text =
                              DateTimeUtil.formatDateTime(selectedTime,
                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat4);
                          _createFlyerVM.checkForm();
                        },
                      );
                    },
                    readOnly: true,
                    prefix: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        AppImages.icTime,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: _createFlyerVM.endTimeController,
                    label: AppStrings.to,
                    focusNode: _createFlyerVM.endTimeNode,
                    textInputType: TextInputType.name,
                    hintText: AppStrings.endTime,
                    onTap: () {

                      CommonMethods.showCustomTimePicker2(
                        context,
                        //selectedTime: _createFlyerVM.endTime,
                        onTimeSelect: (selectedTime) {

                          _createFlyerVM.endTimeController.text =
                              DateTimeUtil.formatDateTime(selectedTime,
                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat4);
                          _createFlyerVM.checkForm();
                        },
                      );

                    },
                    readOnly: true,
                    prefix: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        AppImages.icTime,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: _createFlyerVM.descController,
              textInputType: TextInputType.text,
              maxLength: 250,
              maxLines: 5,
              onChanged: (v) {
                if(v.startsWith(' ')){
                  _createFlyerVM.descController.text = '';
                }
                _createFlyerVM.checkForm();
              },
              label: AppStrings.addDesc,
              hintText: AppStrings.desc,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: _createFlyerVM.admissionFeeController,
              inputFormatters: [
                CurrencyTextInputFormatter(symbol: '\$',decimalDigits: 0)
              ],
              textInputAction:TextInputAction.next,
              textInputType: TextInputType.numberWithOptions(),

              onChanged: (v) {
                _createFlyerVM.admissionFeeController.value = _createFlyerVM.admissionFeeController.value.copyWith(
                  text: _createFlyerVM.admissionFeeController.value.text,
                  selection: TextSelection(
                    baseOffset: _createFlyerVM.admissionFeeController.value.text.length,
                    extentOffset: _createFlyerVM.admissionFeeController.value.text.length,
                  ),
                );
                _createFlyerVM.checkForm();
              },
              label: AppStrings.admissionFee,
              hintText: "\$0",
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: _createFlyerVM.businessController,
              label: AppStrings.selectBusiness,
              readOnly: true,
              dotted: true,
              focusNode: _createFlyerVM.businessNode,
              textInputType: TextInputType.name,
              hintText: AppStrings.selectBusiness,
              onTap: () {
                Util.showBottomSheet2(context,
                    child: ItemSheet(
                        screenTitle: AppStrings.selectType,
                        initialItems: _createFlyerVM.myClubList,
                        onDone: (val){
                          _createFlyerVM.businessController.text=(val as BecomePartnerModel).getText();
                          _createFlyerVM.selectedBusiness=val;
                          _createFlyerVM.checkForm();
                        },
                        onDispose: (val){
                          _createFlyerVM.myClubList = val;
                        },
                        onLoad: (page,search){
                      return _createFlyerVM.getBusinessList(page: page);
                    }));

    /*            Util.showBottomSheet(
                  context,
                  screenTitle: AppStrings.selectType,
                  saveTap: () {
                    Get.back();
                  },
                  widget: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _createFlyerVM.listOfBusinessType.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                              padding: AppSizer.getPadding(left: 16, right: 16, top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: AppText(
                                    text: _createFlyerVM.listOfBusinessType[index].title,
                                  )),
                                  Obx(
                                    () => CustomRectangleCheckbox(
                                        selected: _createFlyerVM.listOfBusinessType[index].selected.value,
                                        onChanged: (v) {
                                          _createFlyerVM.listOfBusinessType[index].selected.value = v;
                                          _createFlyerVM.listOfBusinessType[index].selected.refresh();
                                          _createFlyerVM.businessController.value.text = "";
                                          for (var item in _createFlyerVM.listOfBusinessType) {
                                            if (item.selected.value) {
                                              _createFlyerVM.businessController.value.text += item.title + ", ";
                                            }
                                          }
                                          _createFlyerVM.checkForm();
                                        }),
                                  )
                                ],
                              )),
                          Divider(
                            thickness: 0.2,
                          )
                        ],
                      );
                    },
                  ),
                );*/
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
            SizedBox(height: 20),
            CustomTextField(
              controller: _createFlyerVM.eventController,
              label: AppStrings.selectEvent,
              dotted: true,
              readOnly: true,
              focusNode: _createFlyerVM.eventNode,
              textInputType: TextInputType.name,
              hintText: AppStrings.selectEvent,
              validator: (value) {
                return HelperFunction.fieldValidator(
                  value!,
                  AppStrings.selectEvent,
                );
              },
              onTap: () {

                Util.showBottomSheet2(context,
                    child: ItemSheet(
                        screenTitle: AppStrings.selectType,
                        initialItems: _createFlyerVM.myEvents,
                        onDone: (val){
                          _createFlyerVM.eventController.text=(val as EventModel).getText();
                          _createFlyerVM.selectedEvent=val;
                          _createFlyerVM.checkForm();
                        },
                        onDispose: (val){
                          _createFlyerVM.myEvents = val;
                        },
                        onLoad: (page,search){
                          return _createFlyerVM.getEvents(page: page);
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
            SizedBox(
              height: 50,
            ),
            Obx(
              () => AppButton.mainButton(
                isDisable: _createFlyerVM.isFormCompleted.value ? false : true,
                context,
                text: AppStrings.createFlyer,
                loading: _createFlyerVM.isLoading.value,
                onPressed: () {
                  _createFlyerVM.switchAction();
                },
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ));
  }
}
