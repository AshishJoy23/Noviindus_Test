// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_test/model/models.dart';
import '../../../controller/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class RegisterNowScreen extends StatefulWidget {
  const RegisterNowScreen({key});

  @override
  State<RegisterNowScreen> createState() => _RegisterNowScreenState();
}

TextEditingController nameController = TextEditingController();
TextEditingController numberController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController branchController = TextEditingController();
TextEditingController treatmentsController = TextEditingController();
TextEditingController totalController = TextEditingController();
TextEditingController discountController = TextEditingController();
TextEditingController advanceController = TextEditingController();
TextEditingController balanceController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController timeController = TextEditingController();
final treatmentController = Get.put(TreatmentController());
final patientController = Get.put(PatientController());

class _RegisterNowScreenState extends State<RegisterNowScreen> {
  @override
  Widget build(BuildContext context) {
    branchController.text = treatmentController.branchValue.value;
    treatmentsController.text = treatmentController.treatmentValue.value;
    dateController.text =
        DateFormat('dd/MM/yyyy').format(treatmentController.selectedDate.value);
    timeController.text =
        DateFormat('hh:mm a').format(treatmentController.selectedDate.value);
    log(treatmentController.maleCounter.value.toString());
    return Scaffold(
      appBar: const CustomAppbarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Register',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: 'Name',
                        hintText: 'Enter your full name',
                        textController: nameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Whatsapp Number',
                        hintText: 'Enter your whatsapp number',
                        textController: numberController,
                        isNum: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Address',
                        hintText: 'Enter your address',
                        textController: addressController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: 'Choose your location',
                        title: 'Location',
                        textController: locationController,
                      ),
                      const SizedBox(height: 20),
                      CustomDropDown(
                        title: 'Branch',
                        hintText: 'Select the branch',
                        textController: branchController,
                        dropdownItems: List.from(treatmentController
                            .branchesList
                            .map((branch) => branch.name)),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Treatments',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => treatmentController.treatmentsBookingList.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: treatmentController
                                        .treatmentsBookingList.length,
                                    itemBuilder: (context, index) {
                                      TreatmentBookingModel treatment =
                                          treatmentController
                                              .treatmentsBookingList[index];
                                      return TreatmentCardWidget(
                                        index: index,
                                        treatment: treatment,
                                        treatmentController:
                                            treatmentController,
                                        treatmentsController:
                                            treatmentsController,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                      ),
                      CustomButtonWidget(
                        buttontext: '+ Add Treatments',
                        onPressed: () {
                          treatmentController.maleCounter.value = 0;
                          treatmentController.femaleCounter.value = 0;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return TreatmentDialogBox(
                                treatmentController: treatmentController,
                                treatmentsController: treatmentsController,
                              );
                            },
                          );
                        },
                        isMain: false,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Total Amount',
                        hintText: '',
                        textController: totalController,
                        isNum: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Discount Amount',
                        hintText: '',
                        textController: discountController,
                        isNum: true,
                      ),
                      const SizedBox(height: 20),
                      PaymentOptionWidget(
                        treatmentController: treatmentController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Advance Amount',
                        hintText: '',
                        textController: advanceController,
                        isNum: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'Balance Amount',
                        hintText: '',
                        textController: balanceController,
                        isNum: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFieldWithIcon(
                        hintText: '',
                        title: 'Treatment Date',
                        iconData: Icons.date_range,
                        textController: dateController,
                        onTap: () => selectDate(context),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFieldWithIcon(
                        hintText: '',
                        title: 'Treatment Time',
                        textController: timeController,
                        onTap: () => selectTime(context),
                        iconData: Icons.access_time,
                      ),
                      const SizedBox(height: 30),
                      CustomButtonWidget(
                          buttontext: 'Save',
                          onPressed: () async {
                            if (nameController.text != '' &&
                                numberController.text != '' &&
                                addressController.text != '' &&
                                locationController.text != '' &&
                                branchController.text != '' &&
                                totalController.text != '' &&
                                discountController.text != '' &&
                                advanceController.text != '' &&
                                balanceController.text != '' &&
                                dateController.text != '' &&
                                timeController.text != '' &&
                                treatmentController
                                    .treatmentsBookingList.isNotEmpty) {
                              String treatmentIds = '';
                              String maleCount = '';
                              String femaleCount = '';
                              BranchModel branch = treatmentController
                                  .branchesList
                                  .firstWhere((element) =>
                                      element.name == branchController.text);
                              for (var i = 0;
                                  i <
                                      treatmentController
                                          .treatmentsBookingList.length;
                                  i++) {
                                var element = treatmentController
                                    .treatmentsBookingList[i];
                                if (i ==
                                    treatmentController
                                            .treatmentsBookingList.length -
                                        1) {
                                  treatmentIds = '$treatmentIds${element.id}';
                                  maleCount = '$maleCount${element.maleCount}';
                                  femaleCount =
                                      '$femaleCount${element.femaleCount}';
                                } else {
                                  treatmentIds = '${element.id},$treatmentIds';
                                  maleCount = '${element.maleCount},$maleCount';
                                  femaleCount =
                                      '${element.femaleCount},$femaleCount';
                                }
                              }
                              RegistrationModel newRegistration =
                                  RegistrationModel(
                                id: '',
                                name: nameController.text,
                                excecutive: 'Executive',
                                payment: treatmentController.paymentValue.value,
                                phone: numberController.text,
                                address: locationController.text,
                                totalAmount: totalController.text,
                                discountAmount: discountController.text,
                                advanceAmount: advanceController.text,
                                balanceAmount: balanceController.text,
                                dateNdTime:
                                    '${dateController.text}-${timeController.text}',
                                male: maleCount,
                                female: femaleCount,
                                branch: branch.id.toString(),
                                treatments: treatmentIds,
                              );
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                      child: SpinKitChasingDots(
                                    color: Colors.white,
                                  ));
                                },
                              );
                              await patientController
                                  .registerNewPatient(newRegistration);
                              await patientController.getAllPatientsList();
                              Get.back();
                              if (patientController.isRegistered.value) {
                                Get.back();
                                showSnackbarMsg(
                                    context, 'Submitted successfully.');
                                nameController.clear();
                                numberController.clear();
                                addressController.clear();
                                locationController.clear();
                                treatmentsController.clear();
                                totalController.clear();
                                discountController.clear();
                                advanceController.clear();
                                balanceController.clear();
                                dateController.clear();
                                timeController.clear();
                                treatmentController.onInit();
                                log('Saved registration');
                              } else {
                                showSnackbarMsg(context,
                                    'Something went wrong, please try again');
                              }
                            } else {
                              showSnackbarMsg(
                                  context, 'All fields are required');
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: treatmentController.selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.baseColor, // Set your desired primary color
            colorScheme: const ColorScheme.light(
                primary: AppColor.baseColor), // Adjust your color scheme
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != treatmentController.selectedDate.value) {
      treatmentController.selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy')
          .format(treatmentController.selectedDate.value);
      log(dateController.text);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: treatmentController.selectedTime.value,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.baseColor, // Set your desired primary color
            colorScheme: const ColorScheme.light(
                primary: AppColor.baseColor), // Adjust your color scheme
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != treatmentController.selectedTime.value) {
      treatmentController.selectedTime.value = picked;
      DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );

      timeController.text = DateFormat('hh:mm a').format(selectedDateTime);
      log(timeController.text);
      log(timeController.text);
    }
  }
}
