import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Common/cechednetworlimage.dart';
import '../View Model/image_view_viewmodel.dart';

class ImageView extends StatefulWidget {
  ImageView({Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<ImageView> {

  final imageVM = Get.find<ImageViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: false,
        hideAppBar: true,
        appBarTitle: "",
        body: Stack(
          children: [
            Center(
              child: Get.arguments[0]==""?Image.asset(
        "assets/icon_assets/emptyprofile.png",
          color: AppColors.whiteText.withOpacity(0.6),
          fit: BoxFit.contain,
        ):ExtendedImage.network(
                Get.arguments[0],
                width:AppSizer.width,
                height: AppSizer.width,
                fit: BoxFit.cover,
                cache: true,
                scale: 1,
                shape: BoxShape.rectangle,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 1.0,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
              ),
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
