import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'package:quiz_app/constants/string_constants.dart';

import 'package:quiz_app/screens/start_quiz_screen.dart';

class UserSignupController extends GetxController {
  var showLoader = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> onGoogleSignInButtonTap() async {
    try {
      showLoader.value = true;
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
         await setUserLogin();
      showLoader.value = false;
      Get.off(() => StartQuizScreen());
      } else {
      
      showLoader.value = false;
       Get.context != null
          ? showAlertDialog(
              Get.context!,
              title: StringConstants.signInerror,
              content: StringConstants.userCancelSignIn,
              istButtontext: "",
              secondButtontext: StringConstants.ok,
              onsecondButtonTap: () => Get.back(),
            )
          : 
      debugPrint(StringConstants.userCancelSignIn);
    }
     
    } catch (error) {
      Get.context != null
          ? showAlertDialog(
              Get.context!,
              title: StringConstants.signInerror,
              content: error.toString(),
              istButtontext: "",
              secondButtontext: StringConstants.ok,
              onsecondButtonTap: () => Get.back(),
            )
          : debugPrint(error.toString());
    }
  }
}
