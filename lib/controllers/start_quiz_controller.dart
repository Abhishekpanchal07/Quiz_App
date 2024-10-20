import 'package:get/get.dart';
import 'package:quiz_app/common_helper/common_helper.dart';

class StartQuizController extends GetxController {
  var userLastScore = (-1).obs;
  @override
  void onInit() {
    userLastScore.value = getUserLastScore();
    super.onInit();
  }
}
