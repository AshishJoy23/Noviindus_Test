import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:noviindus_test/main.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  
  Future<bool> getLoginCredential(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(
        Uri.parse(kLoginUrl),
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        await prefs.setString('token', body['token']);
        token = prefs.getString('token');
        log(token!);
        return true;
      } else {
        log('Error: ${response.statusCode.toString()}');
        return false;
      }
    } catch (e) {
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
              'Bearer $token'
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
          'Authorization':
              'Bearer $token'
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
          'Authorization':
              'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        List<PatientModel> patients = List.from(
            body['patient'].map((patient) {
              return PatientModel.fromJson(patient);}));
        return patients;
      } else {
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
      var response = await http.post(
        Uri.parse(kPatientRegistrationUrl),
        headers: {
          'Authorization':
              'Bearer $token'
        },
        body: newPatient.toJson(),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var body = await json.decode(response.body);
        log(body['message']);
        return true;
      } else {
        log('Error: ${response.statusCode.toString()}${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
