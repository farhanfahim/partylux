import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';

class StepDots extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  StepDots({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= totalSteps; i++)
          AnimatedContainer(
            height: 10,
            width: i == currentStep ? 25 : 10,
            decoration: BoxDecoration(
              color:
                  i == currentStep ? AppColors.whiteText : AppColors.iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          ),
      ],
    );
  }
}
