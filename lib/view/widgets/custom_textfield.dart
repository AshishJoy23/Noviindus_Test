import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/utils/colors.dart';

import '../../controller/app_controller.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;
  final bool isNum;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textController,
    this.isNum = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: size.height * 0.065,
          child: TextFormField(
            controller: textController,
            keyboardType: isNum ? TextInputType.number : TextInputType.text,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.textfieldColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldWithIcon extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData iconData;
  final TextEditingController textController;
  final VoidCallback onTap;

  const CustomTextFieldWithIcon({
    super.key,
    required this.title,
    required this.hintText,
    required this.iconData,
    required this.textController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: size.height * 0.065,
          child: TextFormField(
            controller: textController,
            keyboardType: TextInputType.none,
            onTap: onTap,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.textfieldColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              suffixIcon: Icon(
                iconData,
                size: 28,
                color: AppColor.baseColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
