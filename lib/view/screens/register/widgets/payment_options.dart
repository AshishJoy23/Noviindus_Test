import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/controllers.dart';
import '../../screens.dart';

class PaymentOptionWidget extends StatelessWidget {
  final TreatmentController treatmentController;
  const PaymentOptionWidget({
    super.key,
    required this.treatmentController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Payment Option',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadioButtonWidget(
                paymentVaule: treatmentController.paymentValue.value,
                buttonValue: 'Cash',
                treatmentController: treatmentController,
              ),
              RadioButtonWidget(
                paymentVaule: treatmentController.paymentValue.value,
                buttonValue: 'Card',
                treatmentController: treatmentController,
              ),
              RadioButtonWidget(
                paymentVaule: treatmentController.paymentValue.value,
                buttonValue: 'UPI',
                treatmentController: treatmentController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
