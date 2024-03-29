import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    key,
    required this.buttontext,
    required this.onPressed,
    this.isMain = true,
  });

  final String buttontext;
  final VoidCallback onPressed;
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isMain ? AppColor.baseColor : AppColor.baseColor.withAlpha(110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttontext,
          style: TextStyle(
              color: isMain ? Colors.white : Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
