import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/view/widgets/widgets.dart';

import '../../../controller/controllers.dart';
import '../../../utils/colors.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final patientController = Get.put(PatientController());
    final treatmentController = Get.put(TreatmentController());
    var size = MediaQuery.of(context).size;
    return Obx(
      () => patientController.isLoading.value
          ? const Scaffold(
              body: Center(
                child: SpinKitFadingFour(
                  color: AppColor.baseColor,
                ),
              ),
            )
          : !patientController.isDataAvailable.value
              ? const Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          size: 40,
                          color: AppColor.favButtonColor,
                        ),
                        Text(
                          'Something went wrong!!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  appBar: const CustomAppbarWidget(),
                  body: RefreshIndicator(
                    onRefresh: () => patientController.getAllPatientsList(),
                    color: AppColor.baseColor,
                    child: Column(
                      children: [
                        const HomeSearchBar(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const HomeSortingWidget(),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        const Divider(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount:
                                          patientController.patientsList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        PatientModel patient = patientController
                                            .patientsList[index];
                                        return PatientCardWidget(
                                          patient: patient,
                                          index: index,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButtonWidget(
                      buttontext: 'Register Now',
                      onPressed: () {
                        treatmentController.onInit();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterNowScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
