import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_test/controller/controllers.dart';
import 'package:noviindus_test/utils/utils.dart';

class PasswordTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;

  const PasswordTextField({
    key,
    required this.title,
    required this.hintText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController());
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => SizedBox(
            height: size.height * 0.065,
            child: TextFormField(
              controller: textController,
              keyboardType: TextInputType.text,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              obscureText: appController.isObscure.value,
              obscuringCharacter: '*',
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.textfieldColor,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                suffixIcon: InkWell(
                  onTap: () => appController.isObscure.value =
                      !appController.isObscure.value,
                  child: Icon(
                    appController.isObscure.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
