import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class CardTile extends StatelessWidget {
  final String cardTitle;
  final String cardPrice;
  final List<String> cardFeatures;
  const CardTile({
    super.key,
    required this.cardTitle,
    required this.cardPrice,
    required this.cardFeatures,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
      margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0, 1],
          colors: [
            Color.fromARGB(255, 183, 9, 198),
            Color.fromARGB(255, 137, 5, 199),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: cardTitle, //"VIP",
            fontSize: SizeConfig.screenWidth * 0.05,
            
            overflow: TextOverflow.visible,
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cardFeatures.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check,
                            color: AppColors.whiteText,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          AppText(
                            text: cardFeatures[index],
                            fontSize: SizeConfig.screenWidth * 0.033,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(
                    text: "Price",
                    fontSize: SizeConfig.screenWidth * 0.023,
                    fontWeight: FontWeight.w400,
                  ),
                  AppText(
                    text: "\$${cardPrice}",
                    fontSize: SizeConfig.screenWidth * 0.08,
                    
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
