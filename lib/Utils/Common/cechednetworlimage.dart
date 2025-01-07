import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:partylux/Constants/color.dart';

Widget cachedNetworkImage(
  String? imageURL, {
  required BuildContext context,
  double? radius,
  double borderRadius = 100,
}) {
  var width = MediaQuery.of(context).size.width;
  return Container(
    width: radius ?? width * 0.15,
    height: radius ?? width * 0.15,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: AppColors.transparent,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageURL!=null && imageURL.isNotEmpty
          ? CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: imageURL,
              errorWidget: (context, url, error) => Padding(
                padding: radius == null
                    ? EdgeInsets.all((width * 0.04) * 0.7)
                    : EdgeInsets.all(radius * 0.2),
                child: Image.asset(
                  "assets/icon_assets/emptyprofile.png",
                  color: AppColors.primary.withOpacity(0.6),
                  fit: BoxFit.contain,
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CupertinoActivityIndicator(
                  radius: radius == null ? (width * 0.04) * 0.7 : radius * 0.2,
                  color: AppColors.primary.withOpacity(0.6),
                ),
              ),
              width: width * 0.25,
              height: width * 0.25,
              fit: BoxFit.cover,
            )
          : Image.asset(
            "assets/icon_assets/emptyprofile.png",
            color: AppColors.whiteText.withOpacity(0.6),
            fit: BoxFit.contain,
          ),
    ),
  );
}
