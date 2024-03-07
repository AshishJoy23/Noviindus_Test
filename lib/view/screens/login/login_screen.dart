import 'package:flutter/material.dart';
import 'package:noviindus_test/view/screens/screen.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.01),
                      const CustomTextField(
                        title: 'Email',
                        hintText: 'Enter your email',
                      ),
                      SizedBox(height: size.height * 0.01),
                      const CustomTextField(
                        title: 'Password',
                        hintText: 'Enter password',
                      ),
                      const Spacer(),
                      CustomButtonWidget(
                        buttontext: 'Login',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
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
