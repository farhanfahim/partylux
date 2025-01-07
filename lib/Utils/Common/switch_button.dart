// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:partylux/Constants/color.dart';

class SwitchButton extends StatefulWidget {
  final Function callback;
  bool isActive;
  SwitchButton({
    super.key,
    required this.callback,
    this.isActive = false,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: CupertinoSwitch(
        value: widget.isActive,
        activeColor: widget.isActive
            ? AppColors.togalButtonAvtiveColor
            : AppColors.togalButtonDeAvtiveColor,
        onChanged: (bool? value) {
          setState(() {
            widget.isActive = value!;
            widget.callback(widget.isActive);
          });
        },
      ),
    );
  }
}





// class SwitchButton extends StatelessWidget {
//   Function callback;
//   bool isActive;
//   SwitchButton({
//     super.key,
//     required this.callback,
//     required this.isActive,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 10,
//       child: CupertinoSwitch(
//         value: isActive,
//         activeColor: isActive
//             ? AppColors.togalButtonAvtiveColor
//             : AppColors.togalButtonDeAvtiveColor,
//         onChanged: (bool? value) {
//           callback(!isActive);
//         },
//       ),
//     );
//   }
// }