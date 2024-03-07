import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:noviindus_test/model/branch_model.dart';
import 'package:noviindus_test/model/patient_model.dart';
import 'package:noviindus_test/model/treatment_model.dart';
import 'package:noviindus_test/utils/api_endpoints.dart';

class APIServices {
  String token = "";
  Future<void> getLoginCredential(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse(kLoginUrl),
        body: {
          'username': username,
          'password': password,
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        token = body['token'];
      } else {
        log('Error: ${response.statusCode.toString()}');
      }
    } catch (e) {
      log('services log');
      log(e.toString());
    }
  }

  Future<List<BranchModel>?> fetchAllBranches() async {
    try {
      var response = await http.get(
        Uri.parse(kBranchesUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        List<BranchModel> branches = List.from(
            body['branches'].map((branch) => BranchModel.fromJson(branch)));
        return branches;
      } else {
        log('Error: ${response.statusCode.toString()}');
        return null;
      }
    } catch (e) {
      log('Exception in branch fetch: $e');
      return null;
    }
  }

  Future<List<TreatmentModel>?> fetchAllTreatments() async {
    try {
      var response = await http.get(
        Uri.parse(kTreatmentsUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        List<TreatmentModel> treatments = List.from(body['treatments']
            .map((treatment) => TreatmentModel.fromJson(treatment)));
        return treatments;
      } else {
        log('Error: ${response.statusCode.toString()}');
        return null;
      }
    } catch (e) {
      log('Exception in branch fetch: $e');
      return null;
    }
  }

  Future<List<PatientModel>?> fetchAllPatients() async {
    try {
      var response = await http.get(
        Uri.parse(kPatientsUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        List<PatientModel> patients = List.from(
            body['patient'].map((patient) => PatientModel.fromJson(patient)));
        return patients;
      } else {
        log('Error: ${response.statusCode.toString()}');
        return null;
      }
    } catch (e) {
      log('Exception in branch fetch: $e');
      return null;
    }
  }

  // Future<CustomerModel?> createCustomer(CustomerModel customer) async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse(kCustomersUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(customer.toJson()),
  //     );
  //     log(response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       var body = await json.decode(response.body);
  //       CustomerModel updatedCustomer = CustomerModel.fromJson(body['data']);
  //       return updatedCustomer;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     log('services log');
  //     log(e.toString());
  //   }
  //   return null;
  // }
}
