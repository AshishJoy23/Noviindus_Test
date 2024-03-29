import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/main.dart';
import 'package:noviindus_test/view/screens/screens.dart';

import '../../../controller/controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoMain();
    super.initState();
  }

  final patientController = Get.put(PatientController());
  final treatmentController = Get.put(TreatmentController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/splash_image.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon1.png'), fit: BoxFit.contain),
              ),
              height: size.height * 0.2,
              width: size.height * 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> gotoMain() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    bool isConnected = await isInternetConnected();
    if (isConnected) {
      if (token != null) {
        patientController.getAllPatientsList();
        treatmentController.getAllBranchesList();
        treatmentController.getAllTreatmentsList();
        Get.off(() => const HomeScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    } else {
      Get.off(() => const OfflineScreen());
      while (!isConnected) {
        isConnected = await isInternetConnected();
      }
      if (token != null) {
        patientController.getAllPatientsList();
        treatmentController.getAllBranchesList();
        treatmentController.getAllTreatmentsList();
        Get.off(() => const HomeScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    }
  }

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet connection available
      } else {
        return false; // No internet connection
      }
    } on SocketException catch (_) {
      return false; // No internet connection
    }
  }
}
