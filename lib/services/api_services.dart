import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus_test/model/branch_model.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/model/patient_model.dart';
import 'package:noviindus_test/model/treatment_model.dart';
import 'package:noviindus_test/utils/api_endpoints.dart';

import '../controller/controllers.dart';

class APIServices {
  final appController = Get.put(AppController());
  String token = "";
  Future<bool> getLoginCredential(String username, String password) async {
    try {
      log('$username $password');
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
        log(body['message']);
        log(body['is_superuser'].toString());
        log(body['user_details']['name']);
        log(body.toString());
        log(token);
        token = body['token'];
        appController.userToken.value = body['token'];
        log(token.isEmpty.toString());

        log(body['token']);
        log('<<<<<<<<after assign>>>>>>>>');
        log(token);
        log('============================');
        while (token.isEmpty) {
          // Wait for a short interval before checking again
          log('wait here in login itself');
          await Future.delayed(Duration(seconds: 1));
          log(token);
        }
        return true;
      } else {
        log('Error: ${response.statusCode.toString()}');
        return false;
      }
    } catch (e) {
      log('services log');
      log(e.toString());
      return false;
    }
  }

  Future<List<BranchModel>?> fetchAllBranches() async {
    try {
      var response = await http.get(
        Uri.parse(kBranchesUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk2MzAxMTM4LCJpYXQiOjE3MDk5MDExMzgsImp0aSI6IjZkYmQ5MDI2N2QxYTRjODI4Y2JkZmRmZDYyNTBlMTdiIiwidXNlcl9pZCI6MjF9.aHNMcqO3LA_IIk7-7QUnVIng8ux1Q9VmxH9s37TFwaY'
        },
      );
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        List<BranchModel> branches = List.from(
            body['branches'].map((branch) => BranchModel.fromJson(branch)));
        log('<<<<<,,branches log>>>>>');
        log(branches.toString());
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
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk2MzAxMTM4LCJpYXQiOjE3MDk5MDExMzgsImp0aSI6IjZkYmQ5MDI2N2QxYTRjODI4Y2JkZmRmZDYyNTBlMTdiIiwidXNlcl9pZCI6MjF9.aHNMcqO3LA_IIk7-7QUnVIng8ux1Q9VmxH9s37TFwaY'
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
      // while (token.isEmpty) {
      //   // Wait for a short interval before checking again
      //   log('wait here patient api');
      //   await Future.delayed(Duration(seconds: 1));
      // }
      log('fetching patients');
      log(token);
      log('afetr token access');
      //log('Bearer $token');
      log('+++++++++++++++++++++++++++++');
      String newtoken = 'Bearer $token';
      log('we get the new token');
      log(newtoken);
      var response = await http.get(
        Uri.parse(kPatientsUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk2MzAxMTM4LCJpYXQiOjE3MDk5MDExMzgsImp0aSI6IjZkYmQ5MDI2N2QxYTRjODI4Y2JkZmRmZDYyNTBlMTdiIiwidXNlcl9pZCI6MjF9.aHNMcqO3LA_IIk7-7QUnVIng8ux1Q9VmxH9s37TFwaY'
        },
      );
      if (response.statusCode == 200) {
        log('patients list');
        var body = await json.decode(response.body);
        List<PatientModel> patients = List.from(
            body['patient'].map((patient) {
              log('message');
              return PatientModel.fromJson(patient);}));
        return patients;
      } else {
        log('patients error');
        log('Error: ${response.statusCode.toString()}${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      log('Exception in branch fetch: $e');
      return null;
    }
  }

  Future<bool> createNewRegistration(RegistrationModel newPatient) async {
    try {
      log('enter api register');
      // var body = {
      //   'name': newPatient.name,
      // 'excecutive': newPatient.excecutive,
      // 'payment': payment!,
      // 'phone': phone!,
      // 'address': address!,
      // 'total_amount': totalAmount!,
      // 'discount_amount': discountAmount!,
      // 'advance_amount': advanceAmount!,
      // 'balance_amount': balanceAmount!,
      // 'date_nd_time': dateNdTime!,
      // 'male': male!,
      // 'female': female!,
      // 'branch': branch!,
      // 'treatments': treatments!,
      // };
      var response = await http.post(
        Uri.parse(kPatientRegistrationUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk2Mjc5Mjc2LCJpYXQiOjE3MDk4NzkyNzYsImp0aSI6ImVmMTRkNDFjMDA4ODQyOTY5YjY1ZDMxZjZiODc3NDhmIiwidXNlcl9pZCI6MjF9.GmGJ3rup9fHOfSRh59-P3N1MbSZ3oFyr1Pue91Do5-A'
        },
        body: newPatient.toJson(),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        log(body['message']);
        log('registration log');
        return true;
      } else {
        log('register error');
        log('Error: ${response.statusCode.toString()}${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      log('services log');
      log(e.toString());
      return false;
    }
  }
}
