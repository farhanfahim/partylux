import 'package:flutter/material.dart';

extension PaddingHeight on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension WidgetExtension on Widget {
  Widget horizontalPadding(double padding) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: this);
  Widget verticalPadding(double padding) =>
      Padding(padding: EdgeInsets.symmetric(vertical: padding), child: this);
  Widget center() => Center(child: this);
}

extension StringExtension on String {
  String toCapitalizeFirstLetter() {
    if (isEmpty) {
      return this; // Return empty string if input is empty
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
