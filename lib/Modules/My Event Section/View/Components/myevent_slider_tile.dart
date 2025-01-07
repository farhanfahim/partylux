import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/My%20Event%20Section/View%20Model/myevent_vm.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyEventSliderTile extends StatelessWidget {
  final List<String> eventImagesList;
  MyEventSliderTile({
    super.key,
    required this.eventImagesList,
  });
  final _myEventVM = Get.find<MyEventViewModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: AppSizer.getVerticalSize(270),
              initialPage: _myEventVM.currentIndex.value,
              enableInfiniteScroll: eventImagesList.length>1,
              pageSnapping: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOutSine,
              // enlargeCenterPage: true,
              // onPageChanged: callbackFunction,
              onPageChanged: (index, reason) {
                _myEventVM.onChangeSelectedPageIndex(index);
              },
              disableCenter: true,
              viewportFraction: 1,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
            items: eventImagesList.map((index) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      print(_myEventVM.currentIndex.value);
                      // Get.to(ImagePreview(
                      //   image: eventImagesList[_myEventVM.currentIndex.value],
                      // ));
                    },
                    child: cachedNetworkImage(
                      eventImagesList[_myEventVM.currentIndex.value],
                      context: context,
                      borderRadius: 0,
                      radius: double.infinity,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Obx(() => Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSmoothIndicator(
                activeIndex: _myEventVM.currentIndex.value,
                count: eventImagesList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: AppSizer.getVerticalSize(6),
                  dotWidth: AppSizer.getHorizontalSize(6),
                  dotColor: Colors.grey,
                  activeDotColor: Colors.grey.shade200
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}