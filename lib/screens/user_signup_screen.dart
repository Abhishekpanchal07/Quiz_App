import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'package:quiz_app/constants/image_constants.dart';
import 'package:quiz_app/constants/string_constants.dart';
import 'package:quiz_app/controllers/user_signup_controller.dart';

class UserSignupScreen extends StatelessWidget {
  final userSignupController = Get.put(UserSignupController());
  UserSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(appBarTitle: StringConstants.signup),
      body: Obx(() => Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [welcomeText(), signInWithGoogleButton()],
                ),
              ),
              Positioned(
                  child: userSignupController.showLoader.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox())
            ],
          )),
    );
  }

  Widget welcomeText() {
    return const Text(
      StringConstants.welcomeText,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget signInWithGoogleButton() {
    return GestureDetector(
      onTap: () async {
        await userSignupController.onGoogleSignInButtonTap();
      },
      child: Container(
        height: Get.size.height * 0.05,
        width: Get.size.width * 0.75,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 55.0),
          child: Row(children: [
            SvgPicture.asset(
              ImageConstants.googleIcon,
              height: 35,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                StringConstants.signInWithGoogle,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
