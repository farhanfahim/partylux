import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partylux/Utils/Common/custom_bottom_sheet.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/dropdown.dart';
import 'package:partylux/models/page_model.dart';

import '../../../../Constants/color.dart';

class ItemSheet extends CustomBottomSheet2 {
  Future<PageModel<DropDownItem>?> Function(int page, String search) onLoad;
  final PageModel<DropDownItem>? initialItems;
  final void Function(PageModel<DropDownItem> items)? onDispose;
  final void Function(dynamic values)? onDone;
  final bool multiple;
  final Map<String,DropDownItem> selectedItems;
  ItemSheet({
    required this.onLoad,this.multiple=false,
    super.screenTitle,this.selectedItems=const {},
    this.onDone,
    this.initialItems,
    this.onDispose,
  }) : super(
          widget: Container(),
        );

  final GlobalKey<PagedViewState> pageKey = GlobalKey();

  @override
  VoidCallback? get saveTap{
    return multiple?() {

    }:null;
  }

  @override
  Widget get widget {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          pageKey.currentState!.reloadPage();
        },
        child: PaginatedListView<DropDownItem>(
          key: pageKey,
          initialItems: initialItems,
          onFetchPage: (page) {
            return onLoad(page, "");
          },
          onDispose: onDispose,
          separatorBuilder: (con, ind) {
            return const SizedBox.shrink();
          },
          itemBuilder: (ind, item) {
            return buildItem(item);
          },
          //initialLoader: notificationShimmer(),
        ),
      ),
    );
  }

  Widget buildItem(DropDownItem field) {
    return Container(
      child: InkWell(
        onTap: (){
          if(!multiple) {
            AppNavigator.pop();
            onDone?.call(field);
          }else{
            //check(field);
          }
        },
        child: Column(
          children: [
            Padding(
                padding: AppSizer.getPadding(left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: AppText(
                      text: field.getText(),
                    )),
                  ],
                )),
            Divider(
              thickness: 0.2,
            )
          ],
        ),
      ),
    );
  }
}
