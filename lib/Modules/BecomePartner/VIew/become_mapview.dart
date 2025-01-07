// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/color.dart';
import 'package:flutter/services.dart'
    show ByteData, NetworkAssetBundle, Uint8List, rootBundle;
import 'dart:ui' as ui;

import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_routes.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';

class BecomePartnerMapView extends StatefulWidget {
  const BecomePartnerMapView({Key? key}) : super(key: key);

  @override
  State<BecomePartnerMapView> createState() => _BecomePartnerMapViewState();
}

Future<String> _loadMapDarkModeStyle() async {
  return await rootBundle.loadString('assets/map_dark_mode.json');
}

Future<void> _setDarkModeStyle(GoogleMapController controller) async {
  String darkModeStyle = await _loadMapDarkModeStyle();
  controller.setMapStyle(darkModeStyle);
}

class _BecomePartnerMapViewState extends State<BecomePartnerMapView> {
  final _becomePartnerVM = Get.isRegistered<BecomePartnerViewModel>()
      ? Get.find<BecomePartnerViewModel>()
      : Get.put(BecomePartnerViewModel());

  final curentLat = Get.arguments[0];
  final curentLng = Get.arguments[1];

  RxBool isActiveSearch = false.obs;

  GoogleMapController? _controller;
  LocationPermission? permission;

  String darkMapStyle = "";
  dynamic image;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _setDarkModeStyle(controller);
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    initCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              initCurrentLocation();
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.my_location_rounded),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.of(markers.values),
            onMapCreated: _onMapCreated,
            scrollGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(curentLat, curentLng),
              zoom: 15.0,
            ),
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: true, // set this to false
            mapType: MapType.normal,

            onCameraMove: (cameraPosition) {
              var currentLongitude = cameraPosition.target.longitude;
              var currentLatitude = cameraPosition.target.latitude;
              _becomePartnerVM.currentlat.value = currentLatitude;
              _becomePartnerVM.currentlng.value = currentLongitude;
              print("object");
            },
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: MediaQuery.of(context).size.width * 0.25,
              icon: Image.asset("assets/icon_assets/currentLocation.png"),
              onPressed: () {},
            ),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.06,
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child: !isActiveSearch.value
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.whiteText.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.whiteText,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isActiveSearch.value = true;
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.whiteText.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: AppColors.whiteText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField.search(
                            context,
                            hintText: "Set Your Event Location by search",
                            controller: TextEditingController(),
                            onChanged: (val) {
                              _becomePartnerVM.autocomplete(val);
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            isActiveSearch.value = false;
                          },
                          child: Container(
                            width: 40,
                            height: SizeConfig.screenWidth * 0.13,
                            decoration: BoxDecoration(
                              color: AppColors.whiteText.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: AppColors.whiteText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Obx(
            () => Container(
              height: 50.0 * _becomePartnerVM.placesListData.length,
              margin: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.14,
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.black54,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _becomePartnerVM.placesListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(
                                "Place ID ==>> ${_becomePartnerVM.placesListData[index].placeId}");
                            _becomePartnerVM.setPlace(
                                _becomePartnerVM.placesListData[index]);
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
                              text: _becomePartnerVM.placesListData[index].name,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              fontSize: SizeConfig.screenWidth * 0.033,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: index !=
                              _becomePartnerVM.placesListData.length - 1,
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: 10,
              ),
              child: AppButton.mainButton(
                context,
                text: "Submit",
                onPressed: () {
                  _becomePartnerVM.onLocatioSubmit();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  initCurrentLocation() async {
    permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("First Time =>> ${position.latitude}  ${position.longitude}");
      // await addMarker(
      //   markerID: "My Location",
      //   latLng: LatLng(position.latitude, position.longitude),
      // );
      await moveToCameraLocation(
        latLng: LatLng(position.latitude, position.longitude),
      );
    } else {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
              content: AppStrings.locationContent,
              onAccept: () async {
                permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                print("First Time =>> ${position.latitude}  ${position.longitude}");
                await moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });
    }
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    // final Paint tagPaint = Paint()..color = AppColor.primaryColor;
    // final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = AppColors.transparent;
    final double shadowWidth = 10.0;

    final Paint borderPaint = Paint()..color = Colors.transparent;
    final double borderWidth = 1.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: radius,
    //     ),
    //     shadowPaint);

    // Add border circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(shadowWidth, shadowWidth,
    //           size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: radius,
    //     ),
    //     borderPaint);

    // Oval for the image
    Rect oval =
        Rect.fromLTWH(imageOffset, imageOffset, size.width, size.height);

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(
      imagePath,
    ); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);
    Uint8List imageBytes =
        (await NetworkAssetBundle(Uri.parse(imagePath)).load(imagePath))
            .buffer
            .asUint8List();
    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  moveToCameraLocation({required LatLng latLng}) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));
  }

  // addMarker({required String markerID, required LatLng latLng}) async {
  //   final MarkerId markerId = MarkerId(markerID);
  //   // BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
  //   //   ImageConfiguration(size: Size(48, 48)),
  //   //   "assets/icon_assets/currentLocation.png",
  //   // );
  //   // image = await getMarkerIcon(
  //   //     "assets/icon_assets/currentLocation.png", Size(100, 100));
  //   image = await getMarkerIcon(
  //     "https://res.cloudinary.com/dhxm5tiei/image/upload/v1684757066/xxxmjflikgveronljutn.png",
  //     Size(250, 250),
  //   );
  //   final Marker marker = Marker(
  //     position: latLng,
  //     markerId: markerId,
  //     icon: image,
  //     // infoWindow: const InfoWindow(title: "Test", snippet: "this is testing"),
  //   );
  //   setState(() {
  //     markers[markerId] = marker;
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    this._controller?.dispose();
  }
}
