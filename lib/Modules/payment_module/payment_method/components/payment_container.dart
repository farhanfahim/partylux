import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/payment_module/add_card/model/card_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class PaymentContainer extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onAction;
  final String text, icon;
  final String trailIcon;
  const PaymentContainer({
    super.key,
    this.onTap,
    this.onAction,
    required this.text,
    required this.icon,
    this.trailIcon = "",
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        onPressed: onTap,
        padding: AppSizer.getPadding(left: 16, right: 16, top: 20, bottom: 20),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIcon(),
            SizedBox(
              width: AppSizer.getHorizontalSize(15),
            ),
            Expanded(child: buildText()),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onAction,
                child: CustomMonoIcon(
                  icon: trailIcon,
                  size: null,
                  color: AppColors.whiteText,
                ))
          ],
        ));
  }

  Widget buildText() {
    return AppText(
      text: text,
      fontSize: AppSizer.getFontSize(14),
    );
  }

  Widget buildIcon() {
    return CustomMonoIcon(
      icon: icon,
      size: null,
      color: null,
    );
  }
}

class PaymentCardContainer extends PaymentContainer {
  final CardModel card;
  final bool selected;
  PaymentCardContainer({
    required super.text,
    this.selected = false,
    required this.card,
    super.onTap,
    super.onAction,
  }) : super(
          trailIcon: AppImages.icTrash,
          icon: AppImages.imgVisa,
        );

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.paymentConRadius);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: selected ? Border.all(width: 1, color: AppColors.primary) : null),
        clipBehavior: Clip.antiAlias,
        child: super.build(context));
  }

  @override
  Widget buildIcon() {
    final double width = AppSizer.getHorizontalSize(40);
    return CommonImageView(
      width: width,
      fit: BoxFit.contain,
      imagePath: icon,
    );
  }

  @override
  Widget buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        super.buildText(),
        SizedBox(
          height: AppSizer.getVerticalSize(5),
        ),
        AppText(
          text: "****${card.cardNumber}",
          fontSize: AppSizer.getFontSize(14),
        ),
      ],
    );
  }
}
