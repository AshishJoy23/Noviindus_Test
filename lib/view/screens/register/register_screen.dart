import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class RegisterNowScreen extends StatefulWidget {
  const RegisterNowScreen({super.key});

  @override
  State<RegisterNowScreen> createState() => _RegisterNowScreenState();
}

class _RegisterNowScreenState extends State<RegisterNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                CupertinoIcons.bell,
                size: 30,
              ),
              Positioned(
                top: 0,
                right: 7,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.favButtonColor),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Register',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        title: 'Name',
                        hintText: 'Enter your full name',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Whatsapp Number',
                        hintText: 'Enter your whatsapp number',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Address',
                        hintText: 'Enter your address',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextFieldWithIcon(
                        hintText: 'Choose your location',
                        title: 'Location',
                        iconData: Icons.keyboard_arrow_down,
                      ),
                      const SizedBox(height: 20),
                      const CustomTextFieldWithIcon(
                        hintText: 'Select the branch',
                        title: 'Branch',
                        iconData: Icons.keyboard_arrow_down,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Treatments',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      // treatmentCard(),
                      // const SizedBox(height: 20),
                      // addTreatmentButton(context),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Total Amount',
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Discount Amount',
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Advance Amount',
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        title: 'Balance Amount',
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      const CustomTextFieldWithIcon(
                        hintText: 'Select the branch',
                        title: 'Treatment Date',
                        iconData: Icons.calendar_today,
                      ),
                      // treatmentTextField('Treatment Date'),
                      // const SizedBox(height: 20),
                      // treatmentTimeField('Treatment Time'),
                      const SizedBox(height: 30),
                      CustomButtonWidget(buttontext: 'Save', onPressed: () {})
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
