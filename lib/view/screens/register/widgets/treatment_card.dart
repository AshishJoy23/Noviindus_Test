import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_test/controller/controllers.dart';
import 'package:noviindus_test/view/screens/screens.dart';
import '../../../../model/models.dart';
import '../../../../utils/utils.dart';

class TreatmentCardWidget extends StatelessWidget {
  const TreatmentCardWidget({
    super.key,
    required this.index,
    required this.treatment,
    required this.treatmentController,
    required this.treatmentsController,
  });

  final int index;
  final TreatmentBookingModel treatment;
  final TreatmentController treatmentController;
  final TextEditingController treatmentsController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.11,
      child: Card(
        color: AppColor.textfieldColor,
        child: ListTile(
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${index + 1}.',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                treatment.treatmentName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.baseColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 25,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          treatment.maleCount,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.baseColor,
                          ),
                        )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.baseColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 25,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          treatment.femaleCount,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.baseColor,
                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  treatmentController.treatmentsBookingList.removeAt(index);
                  showSnackbarMsg(context, 'Treatment deleted successfully');
                },
                child: const Icon(
                  CupertinoIcons.clear_circled_solid,
                  size: 26,
                  color: AppColor.favButtonColor,
                ),
              ),
              InkWell(
                onTap: () {
                  treatmentController.maleCounter.value = int.parse(
                      treatmentController
                          .treatmentsBookingList[index].maleCount);
                  treatmentController.femaleCounter.value = int.parse(
                      treatmentController
                          .treatmentsBookingList[index].femaleCount);
                  treatmentsController.text = treatmentController
                      .treatmentsBookingList[index].treatmentName;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TreatmentDialogBox(
                        isEdit: true,
                        id: treatmentController.treatmentsBookingList[index].id,
                        treatmentController: treatmentController,
                        treatmentsController: treatmentsController,
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.edit_outlined,
                  size: 24,
                  color: AppColor.baseColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
