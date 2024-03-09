import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/controllers.dart';
import '../../../../utils/utils.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;

  const CustomDropDown({
    Key? key,
    required this.title,
    required this.hintText,
    required this.textController,
    required this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(dropdownItems.toString());
    final treatmentController = Get.put(TreatmentController());
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
          child: DropdownButtonFormField<String>(
            value: textController.text,
            //value: treatmentController.branchValue.value,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.baseColor,
            ),
            iconSize: 28,
            items: dropdownItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: size.width*0.6,
                        child: Text(
                          item,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              textController.text = value!;
              log(textController.text);
              // treatmentController.branchValue.value = value!;
            },
            // onTap: () {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // },
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.textfieldColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade100),
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
