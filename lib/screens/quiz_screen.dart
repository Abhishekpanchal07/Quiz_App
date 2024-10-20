
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants/string_constants.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import '../common_helper/common_helper.dart';

class QuizScreen extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(appBarTitle: StringConstants.quizScreen),
      body: Obx(() {
        var currentQuestion = quizController
            .selectedQuestions[quizController.questionIndex.value];
       
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currentQuestion['question'].toString(),
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.size.width,
              height: Get.size.height * 0.26,
              child: ListView.builder(
                itemCount:
                    (currentQuestion['answers'] as List<Map<String, Object>>)
                        .length,
                itemBuilder: (ctx, index) {
                  quizController.currentindex.value == index;
                  var answer = (currentQuestion['answers']
                      as List<Map<String, Object>>)[index];
                  return GestureDetector(
                    onTap: () => quizController.selectOption(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Obx(() {
                            return Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 2),
                                color: quizController.selectedAnswers[
                                                quizController
                                                    .questionIndex.value] ==
                                            index ||
                                        quizController.selectedOption.value ==
                                            index
                                    ? Colors.blueAccent
                                    : Colors.transparent,
                              ),
                            );
                          }),
                          const SizedBox(width: 15),
                          // Answer text
                          Text(
                            answer['text'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Previous question button
            previousAndNextButton()
          ],
        );
      }),
    );
  }

  Widget previousAndNextButton() {
   
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizController.questionIndex.value > 0
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: commonButton(
                        buttonText: StringConstants.editAnswer,
                        width: 0.43,
                        height: 0.045,
                        onTap: quizController.previousQuestion,
                      ),
                    ),
                  )
                : const SizedBox(),
            quizController
                        .selectedAnswers[quizController.questionIndex.value] !=
                    -1
                ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: commonButton(
                        buttonText: StringConstants.next,
                        width: 0.3,
                        height: 0.045,
                        onTap: quizController.nextQuestion,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ));
  }
}
