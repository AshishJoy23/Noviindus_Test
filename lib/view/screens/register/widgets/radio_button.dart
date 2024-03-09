import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noviindus_test/controller/controllers.dart';
import 'package:noviindus_test/utils/utils.dart';

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({
    super.key,
    required this.paymentVaule,
    required this.buttonValue,
    required this.treatmentController,
  });

  final String paymentVaule;
  final String buttonValue;
  final TreatmentController treatmentController;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColor.baseColor;
            }
            return Colors.black54;
          }),
        ),
      ),
      child: RadioMenuButton(
        value: buttonValue,
        groupValue: paymentVaule,
        onChanged: (value) {
          treatmentController.paymentValue.value = value!;
          log(treatmentController.paymentValue.value);
        },
        child: Text(
          buttonValue,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}