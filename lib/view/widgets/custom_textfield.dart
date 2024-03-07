import 'package:flutter/material.dart';
import 'package:noviindus_test/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;

  const CustomTextField(
      {super.key, required this.title, required this.hintText});

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
        const SizedBox(height: 5),
        SizedBox(
          height: size.height * 0.065,
          child: TextFormField(
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.textfieldColor,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
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

  const CustomTextFieldWithIcon({
    super.key,
    required this.title,
    required this.hintText,
    required this.iconData
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
        SizedBox(
          height: size.height * 0.065,
          child: TextFormField(
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.textfieldColor,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
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
