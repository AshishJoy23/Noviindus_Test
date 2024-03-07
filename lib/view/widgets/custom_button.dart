import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.buttontext,
    required this.onPressed,
  });

  final String buttontext;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height*0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.baseColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttontext,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}