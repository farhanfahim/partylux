import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  final String image;
  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: PhotoView(
                filterQuality: FilterQuality.high,
                minScale: 0.1,
                maxScale: 3.0,
                imageProvider: NetworkImage(image),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: AppColors.transparent,
                margin: EdgeInsets.only(top: 70, left: 20, right: 20),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.whiteText.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.whiteText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
