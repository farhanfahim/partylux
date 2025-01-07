import 'package:flutter/material.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class NotFoundText extends StatelessWidget {

  final String? text;
  const NotFoundText({Key? key,this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: AppText(text: text??AppStrings.txtDataNotFound,fontSize: 13,),);
  }
}