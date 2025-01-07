// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/splash_vm.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/app_images.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;

class SplashView extends StatefulWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _serviceVM = Get.find<SplashViewModel>();
  // final _serviceVM = GeoFenceClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // geofencingmethod();
  }

  // geofencingmethod() async {
  //   await _serviceVM.startMonitoring(false);
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
      isBodyPadding: false,
      hideAppBar: true,
      bottom: false,
      body: Image.asset(
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
        AppImages.imgSplash,
      ),
    );
  }
}
