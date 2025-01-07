import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../Constants/strings.dart';

class TicketLocationView extends StatefulWidget {
  const TicketLocationView({
    super.key,
  });

  @override
  State<TicketLocationView> createState() => _TicketLocationViewState();
}

class _TicketLocationViewState extends State<TicketLocationView> {
  final LatLng latLng = Get.arguments[0];

  final RxSet<Circle> circles = Set<Circle>.from([]).obs;
  GoogleMapController? _controller;
  Set<Marker> marker = <Marker>{};


  Future<void> onMapCreated(cntlr) async {
    _controller = cntlr;
    String darkModeStyle = await _loadMapDarkModeStyle();
    _controller!.setMapStyle(darkModeStyle);


  }

  void addCircle({required String circleID, required LatLng latLng}) async {
    circles.value = Set.from([
      Circle(
        circleId: CircleId(circleID),
        center: latLng,
        fillColor: Color.fromRGBO(174, 0, 255, 0.8),
        strokeWidth: 0,
        radius: 10,
      ),
      Circle(
        circleId: CircleId("2"),
        center: latLng,
        fillColor: Color.fromRGBO(174, 0, 255, 0.3),
        strokeWidth: 1,
        strokeColor: Color.fromRGBO(174, 0, 255, 1),

        radius: 40,
      )
    ]);
  }

  Future<String> _loadMapDarkModeStyle() async {
    return await rootBundle.loadString(AppStrings.darkMapStyle);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      addCircle(circleID: "1", latLng: LatLng(latLng.latitude, latLng.longitude),);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            markers: marker,
            onMapCreated: onMapCreated,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: latLng,
              zoom: 17.0,
            ),
            // polylines: Set<Polyline>.of(polylines.values),
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            // set this to false
            circles: circles.value,
            mapType: MapType.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.darkgrey.withOpacity(0.5),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
                Expanded(
                  child: AppText(
                    text: "Party Location",
                    textAlign: TextAlign.center,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  moveToCameraLocation({required LatLng latLng}) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));
  }

  addMarkerEvent({
    required String markerID,
    required LatLng latLng,
    required String assets,
  }) async {
    final MarkerId markerId = MarkerId(markerID);
    BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), assets);
    // final image = await getMarkerIcon(url, Size(100, 100));
    marker.add(Marker(
        position: latLng,
        markerId: markerId,
        icon: image,
        onTap: () {
          print("InfoWindow=>>>>>> ${markerID}  ==== EventID ==> ");
        }));
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowPaint = Paint()..color = AppColors.primary;
    final double shadowWidth = 10.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 1.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromAsset(
        imagePath); // Alternatively use your own method to get the image
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

  // Future<ui.Image> getImageFromPath(String imagePath) async {
  //   File imageFile = File(imagePath);
  //   // File imageFile = File(imagePath);

  //   Uint8List imageBytes = imageFile.readAsBytesSync();
  //   // Uint8List imageBytes =
  //   //     (await NetworkAssetBundle(Uri.parse(imagePath)).load(imagePath))
  //   //         .buffer
  //   //         .asUint8List();
  //   final Completer<ui.Image> completer = new Completer();

  //   ui.decodeImageFromList(imageBytes, (ui.Image img) {
  //     return completer.complete(img);
  //   });

  //   return completer.future;
  // }

  Future<ui.Image> getImageFromAsset(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    Uint8List imageBytes = data.buffer.asUint8List();

    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      completer.complete(img);
    });

    return completer.future;
  }
}
