import 'package:get/get.dart';
import 'package:quiz_app/common_helper/app_routes.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'dart:math';
import 'package:quiz_app/common_helper/questions.dart';
import 'package:quiz_app/controllers/start_quiz_controller.dart';

class QuizController extends GetxController {
  var questionIndex = 0.obs;
  var score = 0.obs;
  var currentindex = 0.obs;
  var selectedOption = (-1).obs;

  // Store a random subset of questions
  List<Map<String, Object>> selectedQuestions = [];
  final int totalQuestions = 10; // Set to 10 questions

  // Store selected answers for each question
  List<int> selectedAnswers = [];

  @override
  void onInit() {
    super.onInit();
    _selectRandomQuestions();
    selectedAnswers = List.filled(totalQuestions, -1); // Initialize with -1
  }

  void _selectRandomQuestions() {
    var random = Random();
    selectedQuestions = questions..shuffle(random);
    selectedQuestions = selectedQuestions.take(totalQuestions).toList();
  }

  void selectOption(int index) {
    selectedOption.value = index;
    selectedAnswers[questionIndex.value] = index; // Store the selected answer
    bool isCorrect = (selectedQuestions[questionIndex.value]['answers']
        as List<Map<String, Object>>)[index]['correct'] as bool;

    Future.delayed(const Duration(milliseconds: 80), () {
      answerQuestion(isCorrect);
    });
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      score.value++;
    }

    nextQuestion();
  }

  void nextQuestion() {
    if (questionIndex.value < selectedQuestions.length - 1) {
      questionIndex.value++;
      selectedOption.value =
          selectedAnswers[questionIndex.value]; // Restore selected option
    } else {
      final controller = Get.find<StartQuizController>();
      controller.userLastScore.value = score.value;
      clearUserLastScore();
      storeUserLastScore(score.value);
      Get.offNamed(AppRoutes.resultScreen);
    }
  }

  void previousQuestion() {
    if (questionIndex.value > 0) {
      questionIndex.value--;
      selectedOption.value =
          selectedAnswers[questionIndex.value]; // Restore selected option
    }
  }

  void resetQuiz() {
    questionIndex.value = 0;
    score.value = 0;
    selectedOption.value = -1;
    selectedAnswers = List.filled(totalQuestions, -1); // Reset selected answers
    _selectRandomQuestions();
  }
}
