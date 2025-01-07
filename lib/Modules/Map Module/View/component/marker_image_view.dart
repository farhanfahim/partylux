import 'package:flutter/cupertino.dart';

import '../../../../Constants/app_images.dart';
import '../../View Model/map_view_model.dart';
import 'circle_image_view.dart';

class MarkerImageView extends StatelessWidget {
  const MarkerImageView({
    Key? key,
    this.width,
    this.markerWidth,
    this.height,
    this.markerHeight,
    this.boxFit = BoxFit.cover,
    required this.image,
    this.errorImage = AppImages.imgProfile,
  }) : super(key: key);

  final double? markerWidth;
  final double? width;
  final double? markerHeight;
  final double? height;
  final BoxFit boxFit;
  final String errorImage;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          AppImages.imgMarker,
          height: markerHeight,
          width: markerWidth,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CircleImage(
            image: image,
            height: height,
            width: width,
            errorImage: errorImage,
          ),
        ),
      ],
    );
  }
}