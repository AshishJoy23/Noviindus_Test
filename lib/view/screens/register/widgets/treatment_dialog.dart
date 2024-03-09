import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/controller/controllers.dart';

import '../../../../model/models.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class TreatmentDialogBox extends StatelessWidget {
  final TreatmentController treatmentController;
  final TextEditingController treatmentsController;
  final bool isEdit;
  final String? id;
  const TreatmentDialogBox({
    super.key,
    required this.treatmentController,
    required this.treatmentsController,
    this.isEdit = false,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.85,
          maxHeight: size.height * 0.5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropDown(
                title: 'Choose Treatments',
                hintText: 'Choose preferred treatment',
                textController: treatmentsController,
                dropdownItems: List.from(treatmentController.treatmentsList
                    .map((treatment) => treatment.name)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Patients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              PatientCounterWidget(
                counterValue: treatmentController.maleCounter,
                patientCategory: 'Male',
                treatmentController: treatmentController,
              ),
              const SizedBox(height: 10),
              PatientCounterWidget(
                counterValue: treatmentController.femaleCounter,
                patientCategory: 'Female',
                treatmentController: treatmentController,
              ),
              const Spacer(),
              CustomButtonWidget(
                buttontext: 'Save',
                onPressed: () {
                  if (treatmentController.maleCounter.value == 0 &&
                      treatmentController.femaleCounter.value == 0) {
                    showSnackbarMsg(context, 'Add atleast one patient');
                  } else {
                    TreatmentModel selected = treatmentController.treatmentsList
                        .firstWhere((element) =>
                            element.name == treatmentsController.text);
                    TreatmentBookingModel newTreatment = TreatmentBookingModel(
                      id: selected.id.toString(),
                      treatmentName: treatmentsController.text,
                      maleCount:
                          treatmentController.maleCounter.value.toString(),
                      femaleCount:
                          treatmentController.femaleCounter.value.toString(),
                    );
                    if (isEdit) {
                      int index = treatmentController.treatmentsBookingList
                          .indexWhere((element) => element.id == id);
                      treatmentController.treatmentsBookingList.removeAt(index);
                      treatmentController.treatmentsBookingList.insert(index,newTreatment);
                      Navigator.of(context).pop();
                      showSnackbarMsg(context, 'Treatment edited successfully');
                    } else {
                      treatmentController.treatmentsBookingList
                          .add(newTreatment);
                      Navigator.of(context).pop();
                      showSnackbarMsg(context, 'Treatment added successfully');
                    }
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
