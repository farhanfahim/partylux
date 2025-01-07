import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:shimmer/shimmer.dart';

Widget viewAllCardsShimmer() {
  final double spacing=AppSizer.getVerticalSize(25);
  return Column(
    children: List.generate(3, (index) {
      return Container(
        height: AppSizer.getVerticalSize(63),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: spacing),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),child: const SizedBox.shrink(),
        ),
      );
    }),
  );
}