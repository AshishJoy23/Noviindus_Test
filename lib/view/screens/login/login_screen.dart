import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/utils/constants.dart';
import 'package:noviindus_test/view/screens/screens.dart';
import '../../../controller/controllers.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({key});

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController());
    final patientController = Get.put(PatientController());
    final treatmentController = Get.put(TreatmentController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/login_image.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: size.height * 0.35,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: size.height * 0.1,
                    width: size.height * 0.1,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login or Register To Book \nYour Appointments',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.01),
                      CustomTextField(
                        title: 'Email',
                        hintText: 'Enter your email',
                        textController: nameController,
                      ),
                      SizedBox(height: size.height * 0.01),
                      PasswordTextField(
                        title: 'Password',
                        hintText: 'Enter password',
                        textController: passwordController,
                      ),
                      const Spacer(),
                      CustomButtonWidget(
                        buttontext: 'Login',
                        onPressed: () async {
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
                          bool isConnected = await isInternetConnected();
                          if (isConnected) {
                            await appController.verifyUserLogin(
                                nameController.text, passwordController.text);
                            Get.back();
                            if (appController.isVerified.value) {
                              patientController.getAllPatientsList();
                              treatmentController.getAllBranchesList();
                              treatmentController.getAllTreatmentsList();
                              Get.off(() => const HomeScreen());
                            } else {
                              // ignore: use_build_context_synchronously
                              showSnackbarMsg(
                                  context, 'Invalid login details!!');
                            }
                          } else {
                            Get.back();
                            // ignore: use_build_context_synchronously
                            showSnackbarMsg(
                                // ignore: use_build_context_synchronously
                                context, 'Check your internet connection');
                            while (!isConnected) {
                              isConnected = await isInternetConnected();
                            }
                            await appController.verifyUserLogin(
                                nameController.text, passwordController.text);
                            if (appController.isVerified.value) {
                              patientController.getAllPatientsList();
                              treatmentController.getAllBranchesList();
                              treatmentController.getAllTreatmentsList();
                              Get.off(() => const HomeScreen());
                            } else {
                              // ignore: use_build_context_synchronously
                              showSnackbarMsg(
                                  context, 'Invalid login details!!');
                            }
                          }
                        },
                      ),
                      const Spacer(),
                      const BottomTextWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
