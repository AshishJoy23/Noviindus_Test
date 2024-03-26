import 'package:get/get.dart';

import '../services/api_services.dart';

class AppController extends GetxController {
  var isVerified = false.obs;
  var isObscure = true.obs;

  Future<void> verifyUserLogin(String username,String password) async {
    final response = await APIServices().getLoginCredential(username,password);
    if (response) {
      isVerified.value = true;
    } else {
      isVerified.value = false;
    }
  }

}