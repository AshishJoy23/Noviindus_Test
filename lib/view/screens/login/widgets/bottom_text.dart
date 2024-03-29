import 'package:flutter/material.dart';

class BottomTextWidget extends StatelessWidget {
  const BottomTextWidget({key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text:
              'By creating or logging into an account you are agreeing\n with our',
          style: TextStyle(fontSize: 12, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: ' Terms and Conditions',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            TextSpan(
              text: ' and ',
            ),
            TextSpan(
              text: 'Privacy Policy.',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
