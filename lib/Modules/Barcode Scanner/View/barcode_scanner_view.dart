import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Barcode%20Scanner/View%20Model/barcode_viewmodel.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Common/custom_success_dialog.dart';

class BarcodeScannerView extends StatefulWidget {
  BarcodeScannerView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {

  final _barcodeVM = Get.find<BarcodeViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: false,
        hideAppBar: true,
        appBarTitle: "",
        body: Stack(
          children: [
            AiBarcodeScanner(
              canPop: false,
              showSuccess: false,
              showError: false,
              onScan: (String value) {

                if(value != _barcodeVM.qrCode.value){
                  _barcodeVM.qrCode.value = value;
                  _barcodeVM.onCheckEvent(value);

                }

              },
            ),
            Padding(
              padding: AppSizer.getPadding(top:56,left: 16),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child:Image.asset(
                    width:24,
                    height:24,
                      AppImages.imgClose,
                      fit: BoxFit.scaleDown)),
            ),


          ],
        ));
  }

}
