import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common_helper/app_routes.dart';
import 'package:quiz_app/common_helper/common_helper.dart';
import 'package:quiz_app/constants/string_constants.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/screens/start_quiz_screen.dart';
import 'package:quiz_app/screens/user_signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.quizApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: AppRoutes.quizscreem, page: () => QuizScreen()),
        GetPage(name: AppRoutes.resultScreen, page: () => ScoreScreen()),
        GetPage(name: AppRoutes.signUpScreen, page: () => UserSignupScreen()),
        GetPage(
            name: AppRoutes.startQuizScreen,
            page: () =>  StartQuizScreen()),
      ],
      home:
          isUserLogin() == true ?  StartQuizScreen() : UserSignupScreen(),
    );
  }
}
