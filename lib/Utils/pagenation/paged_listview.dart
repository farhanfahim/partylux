import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/not_found_text.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';

class PaginatedListView<T> extends PagedView<T> {

  final Widget Function(BuildContext context,int ind,) separatorBuilder;

  const PaginatedListView({
    Key? key,
    required super.itemBuilder,
    required super.onFetchPage,
    required this.separatorBuilder,
    super.pagingController,
    super.shrinkWrap = false,
    super.onDispose,
    super.initialItems,
    super.physics = const AlwaysScrollableScrollPhysics(),
    super.padding = EdgeInsets.zero,
    super.initialLoader,super.notFoundWidget,
  }) : super(key: key);

  @override
  _PagedListViewState<T> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends PagedViewState<T> {

  @override
  PaginatedListView<T> get widget => super.widget as PaginatedListView<T>;

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      pagingController: pagingController,
      separatorBuilder: widget.separatorBuilder,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      builderDelegate: PagedChildBuilderDelegate<T>(
          firstPageProgressIndicatorBuilder: (con) {
            return widget.initialLoader??const CupertinoActivityIndicator(
              color: AppColors.whiteText,
            );
          }, noItemsFoundIndicatorBuilder: (con) {
        return widget.notFoundWidget??const NotFoundText();
      }, itemBuilder: (context, dynamic item, index) {
        return widget.itemBuilder(index, item);
      },
          newPageProgressIndicatorBuilder: (con){
            return const CupertinoActivityIndicator(
              color: AppColors.whiteText,
            );
          }
      ),
    );
  }
}