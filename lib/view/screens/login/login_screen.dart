import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/utils/constants.dart';
import 'package:noviindus_test/view/screens/screens.dart';
import '../../../controller/controllers.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                          await appController.verifyUserLogin(
                              nameController.text, passwordController.text);
                          Get.back();
                          if (appController.isVerified.value) {
                            patientController.getAllPatientsList();
                            treatmentController.getAllBranchesList();
                            treatmentController.getAllTreatmentsList();
                            Get.to(() => const HomeScreen());
                          } else {
                            // ignore: use_build_context_synchronously
                            showSnackbarMsg(context, 'Invalid login details!!');
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
}
