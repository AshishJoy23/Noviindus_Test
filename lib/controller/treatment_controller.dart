import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/services/api_services.dart';

class TreatmentController extends GetxController {
  var branchesList = <BranchModel>[].obs;
  var treatmentsList = <TreatmentModel>[].obs;
  var treatmentsBookingList = <TreatmentBookingModel>[].obs;
  var branchValue = ''.obs;
  var treatmentValue = ''.obs;
  var paymentValue = ''.obs;
  var maleCounter = 0.obs;
  var femaleCounter = 0.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  @override
  void onInit() {
    super.onInit();
    getAllBranchesList();
    getAllTreatmentsList();
    treatmentsBookingList.value = [];
    maleCounter.value = 0;
    femaleCounter.value = 0;
    paymentValue.value = 'Cash';
    selectedDate.value = DateTime.now();
    selectedTime.value = TimeOfDay.now();
  }

  Future<void> getAllBranchesList() async {
    final response = await APIServices().fetchAllBranches();
    if (response != null) {
      branchesList.value = response;
      branchValue.value = branchesList[0].name!;
    }
  }

  Future<void> getAllTreatmentsList() async {
    final response = await APIServices().fetchAllTreatments();
    if (response != null) {
      treatmentsList.value = response;
      treatmentValue.value = treatmentsList[0].name!;
    }
  }
}
