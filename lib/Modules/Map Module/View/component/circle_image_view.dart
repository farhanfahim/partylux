
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partylux/Constants/color.dart';

import '../../../../Constants/app_images.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    Key? key,
    this.width,
    this.height,
    this.errorImage = AppImages.imgProfile,
    this.boxFit = BoxFit.cover,
    required this.image,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String errorImage;
  final BoxFit boxFit;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:BorderRadius.all(Radius.circular(100)),
      child: image!.isNotEmpty?CachedNetworkImage(
        fit: boxFit,
        width: width,
        height: height,
        imageUrl: image!,
      ):SvgPicture.asset(
        AppImages.icUser,
        width: width,
        height: height,
      ),
    );
  }
}