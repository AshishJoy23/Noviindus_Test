import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/controllers.dart';
import '../../../../utils/utils.dart';

// ignore: must_be_immutable
class PatientCounterWidget extends StatelessWidget {
  PatientCounterWidget({
    key,
    required this.counterValue,
    required this.treatmentController,
    required this.patientCategory,
  });

  RxInt counterValue;
  final String patientCategory;
  final TreatmentController treatmentController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: size.height * 0.065,
          width: size.width * 0.3,
          padding: const EdgeInsets.only(
            left: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                patientCategory,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SizedBox(
            height: size.height * 0.065,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (counterValue.value > 0) {
                      counterValue.value--;
                    } else {
                      showSnackbarMsg(context, 'Please check the count!');
                    }
                  },
                  child: Container(
                    width: size.height * 0.055,
                    height: size.height * 0.055,
                    decoration: BoxDecoration(
                        color: counterValue.value == 0
                            ? Colors.grey
                            : AppColor.baseColor,
                        borderRadius:
                            BorderRadius.circular((size.height * 0.055) / 2)),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: size.height * 0.065,
                  height: size.height * 0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      '${counterValue.value}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (counterValue.value < 5) {
                      counterValue.value++;
                    } else {
                      showSnackbarMsg(context, 'Maximum count is 5');
                    }
                  },
                  child: Container(
                    width: size.height * 0.055,
                    height: size.height * 0.055,
                    decoration: BoxDecoration(
                        color: counterValue.value == 5
                            ? Colors.grey
                            : AppColor.baseColor,
                        borderRadius:
                            BorderRadius.circular((size.height * 0.055) / 2)),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
