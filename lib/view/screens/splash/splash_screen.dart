import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/main.dart';
import 'package:noviindus_test/view/screens/screens.dart';

import '../../../controller/controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
      const Duration(seconds: 4),
    );
    if (isLoggedIn == true) {
      patientController.getAllPatientsList();
      Get.to(() => const HomeScreen());
    } else {
      Get.to(() => LoginScreen());
    }
  }
}
