import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common_helper/app_routes.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'package:quiz_app/constants/string_constants.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';

class ScoreScreen extends StatelessWidget {
  final QuizController quizController = Get.find<QuizController>();

  ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(appBarTitle: StringConstants.yourScore),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${StringConstants.yourScore}: ${quizController.score.value}/10',
                style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            restartandHomebutton()
          ],
        ),
      ),
    );
  }

  Widget restartandHomebutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonButton(
            width: 0.4,
            buttonText: StringConstants.restartQuiz,
            onTap: () => Get.offNamed(AppRoutes.quizscreem),
          ),
          commonButton(
              width: 0.4,
              buttonText: StringConstants.goToHome,
              onTap: () => Get.offNamed(AppRoutes.startQuizScreen))
        ],
      ),
    );
  }
}
