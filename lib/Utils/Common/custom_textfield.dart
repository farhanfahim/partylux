import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/custom_dotted_container.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../Constants/app_fonts.dart';
import '../../Constants/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.label = "",
        this.subLabel,
      this.hintText,
      this.fieldStyle,
      this.hintStyle,
      this.prefix,
      this.suffix,
      this.controller,
      this.textInputType,
      this.onChanged,
      this.focusNode,
      this.maxLines,
      this.validator,
      this.enabled,
      this.onFieldSubmitted,
      this.obscureText,
      this.maxLength,
      this.mandatory = false,
      this.textInputAction,
      this.showBorder = true,
      this.floatingLabelBehavior,
      this.textCapitalization,
      this.onTap,
      this.inputFormatters,
      this.readOnly,
      this.disabledBorderColor,
      this.textAlignVertical,
      this.fillColor,
      this.textColor,
      this.autoValidateMode,
      this.filled = true,
      this.expands = false,
      this.showPadding = true,
      this.dotted = false,
      this.radius = AppDimen.textFieldRadius,this.textAlign=TextAlign.start,
      super.key});

  final double radius;
  final bool dotted;
  final String? label;
  final Widget? subLabel;
  final String? hintText;
  final TextStyle? fieldStyle;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final bool? enabled;
  final bool? obscureText;
  final bool? mandatory;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool showBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? showPadding;
  final VoidCallback? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final Color? fillColor;
  final Color? disabledBorderColor;
  final Color? textColor;
  final AutovalidateMode? autoValidateMode;
  final bool? filled;
  final bool expands;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {

    Widget textField() {
      var border=enabledBorder;
      return GestureDetector(
        onTap: onTap,behavior: HitTestBehavior.opaque,
        child: TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          maxLines: obscureText == true ? 1 : maxLines,
          textAlignVertical: textAlignVertical,
          onChanged: onChanged,
          focusNode: focusNode,
          validator: validator,
          autofocus: false,
          expands: expands,
          enabled: enabled ?? true,
          obscureText: obscureText ?? false,
          textInputAction: textInputAction ?? TextInputAction.next,
          textAlign: textAlign,
          keyboardType: textInputType ?? TextInputType.text,
          onTap: onTap,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters ??
              [
                LengthLimitingTextInputFormatter(maxLength),
              ],
          decoration: InputDecoration(
            fillColor: fillColor ?? AppColors.feildBGColor.withOpacity(0.10),
            floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.never,
            border: border,
            enabledBorder: border,
            disabledBorder: disabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            prefixIcon: prefix,
            suffixIcon: suffix,
            isDense: true,
            errorMaxLines: 2,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error, // or any other color
            ),
            contentPadding: contentPadding,
            hintText: hintText ?? "",
            filled: filled,
            hintStyle: hintStyle ??
                TextStyle(
                    fontFamily: AppFonts.copperPlate2,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                    color: AppColors.iconColor),
          ),
          onFieldSubmitted: onFieldSubmitted,
          cursorColor: AppColors.whiteText,
          style: fieldStyle ??
              TextStyle(
                  fontFamily: AppFonts.copperPlate2,
                  color: textColor ?? AppColors.whiteText,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label!.isNotEmpty
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: label!,
                    color: AppColors.whiteText,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizer.getFontSize(18),
                  ),
                Padding(
                  padding: AppSizer.getPadding(right: 10),
                  child: subLabel ?? SizedBox.shrink(),
                )
              ],
            )
            : Container(),
        label!.isNotEmpty
            ? SizedBox(
                height: 12,
              )
            : Container(),
        Flexible(
          flex: expands ? 1 : 0,
          child: dotted ? CustomDottedContainer(radius: radius, color: AppColors.iconColor, child: textField()) : textField(),
        ),
      ],
    );
  }

  EdgeInsets get contentPadding => EdgeInsets.symmetric(horizontal: 10, vertical: 16.5);

  InputBorder get enabledBorder {
    return !showBorder
        ? InputBorder.none
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          );
  }

  InputBorder get disabledBorder {
    return !showBorder
        ? InputBorder.none
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          );
  }

  InputBorder get focusedBorder {
    return !showBorder
        ? InputBorder.none
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          );
  }

  InputBorder get errorBorder {
    return !showBorder
        ? InputBorder.none
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          );
  }
}
