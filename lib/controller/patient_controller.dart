import 'package:get/get.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/services/api_services.dart';

class PatientController extends GetxController {
  var patientsList = <PatientModel>[].obs;
  var isLoading = false.obs;
  var isDataAvailable = false.obs;
  var isRegistered = false.obs;

  // @override
  // void onInit() { 
  //   super.onInit();
  //   getAllPatientsList();
  // }

  Future<void> getAllPatientsList() async {
    isLoading.value = true;
    final response = await APIServices().fetchAllPatients();
    if (response != null) {
      patientsList.value = response;
      isDataAvailable.value = true;
    } else {
      isDataAvailable.value = false;
    }
    isLoading.value = false;
  }

  Future<void> registerNewPatient(RegistrationModel newPatient) async {
    final response = await APIServices().createNewRegistration(newPatient);
    isRegistered.value = response;
  }

}