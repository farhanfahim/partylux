import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Constants/strings.dart';
import '../../../../Utils/Common/cechednetworlimage.dart';
import '../../../../Utils/Common/common_image_view.dart';
import '../../../../Utils/Common/custom_textfield.dart';
import '../../../Auth Module/Models/usermodel.dart';
import '../../../My Business/Model/business_detail_model.dart';
import '../../../create_business/model/become_partner_model.dart';

class SocialTile extends StatelessWidget {
  final Social? social;
  const SocialTile({super.key,this.social,});

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () async {


            if (await canLaunchUrl(Uri.parse(social!.url!))) {
            await launchUrl(
              Uri.parse(social!.url!),
              mode: LaunchMode.externalApplication,
            );
            } else {
            throw 'There was a problem to open the url: ${social!.url!}';
            }

          },
          child: CommonImageView(
            width: 32,
            imagePath:  social!.type=="facebook"?AppImages.imgFacebook:
            social!.type=="instagram"?AppImages.imgInsta:
            social!.type=="snapchat"?AppImages.imgSnapchat:"",
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }
}
