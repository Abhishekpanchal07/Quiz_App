import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common_helper/app_routes.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'package:quiz_app/constants/string_constants.dart';
import 'package:quiz_app/controllers/start_quiz_controller.dart';
import 'package:quiz_app/main.dart';

class StartQuizScreen extends StatelessWidget {
  final controller = Get.put(StartQuizController());
  StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          appBarTitle: StringConstants.letStart, actions: [logout(context)]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: lastScoreText(),
            ),
            commonButton(
              buttonText: StringConstants.startQuiz,
              onTap: () => Get.offNamed(AppRoutes.quizscreem),
            )
          ],
        ),
      ),
    );
  }

  Widget logout(BuildContext context) {
    return IconButton(
        onPressed: () {
          showAlertDialog(
            context,
            title: StringConstants.logout,
            content: StringConstants.sureToLogout,
            istButtontext: StringConstants.no,
            secondButtontext: StringConstants.yes,
            onIstbuttonTap: () {
              Get.back();
            },
            onsecondButtonTap: () {
              prefs.clear();
              Get.offAllNamed(AppRoutes.signUpScreen);
            },
          );
        },
        icon: const Icon(Icons.logout));
  }

  Widget lastScoreText() {
    return Obx(() {
      int score = controller.userLastScore.value;

      return Text(
        controller.userLastScore.value > -1
            ? "Great job! Your last score was $score out of 10. Can you beat it this time? Keep pushing your limits!"
            : StringConstants.playFirstTime,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      );
    });
  }
}
