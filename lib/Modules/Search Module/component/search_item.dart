import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Search%20Module/Model/search_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class RecentSearchItem extends StatelessWidget {

  final void Function()? onRemove;
  final SearchModel item;
  final void Function()? onTap;
  const RecentSearchItem({Key? key,this.onRemove,required this.item,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: AppSizer.getSize(18),
                    height: AppSizer.getSize(18),
                    child: Image.asset(
                      AppImages.imgSearch,
                      color: AppColors.whiteText,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: AppText(
                      text: item.query!,
                      overflow: TextOverflow.visible,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      fontWeight: FontWeight.w700,
                      color:AppColors.whiteText,
                    ),
                  ),
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      width: AppSizer.getSize(20),
                      height: AppSizer.getSize(20),
                      child: Image.asset(
                        AppImages.imgClose,
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: .5,color: AppColors.midGrey,)
          ],
        ),
      ),
    );
  }
}


class SearchNotFound extends StatelessWidget {
  const SearchNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(
              AppImages.searchStatus,
              // color: AppColors.whiteText,
            ),
          ),
          SizedBox(height: 10),
          AppText(
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
              height: 1,
              fontWeight: FontWeight.w700,
              text:
              "Not Searched Yet!"),
        ],
      ),
    );
  }
}


