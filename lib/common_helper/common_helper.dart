import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/string_constants.dart';
import '../main.dart';

Future<void> setUserLogin() async {
  await prefs.setBool(StringConstants.isUserLogin, true);
}

Future<void> storeUserLastScore(int score) async {
  await prefs.setInt(StringConstants.userLastScore, score);
} 

Future<void> clearUserLastScore() async {
  await prefs.setInt(StringConstants.userLastScore, 0);
}

bool isUserLogin() {
  return prefs.getBool(StringConstants.isUserLogin) ?? false;
}

int getUserLastScore() {
  return prefs.getInt(StringConstants.userLastScore) ?? -1;
}

PreferredSizeWidget appBar({String? appBarTitle, List<Widget>? actions}) {
  return AppBar(
    title: Text(
      appBarTitle ?? "",
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    actions: actions ?? [],
  );
}

void showAlertDialog(BuildContext context,
    {String? title,
    content,
    istButtontext,
    secondButtontext,
    VoidCallback? onIstbuttonTap,
    VoidCallback? onsecondButtonTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title ?? "")),
        content: Text(content ?? ""),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onIstbuttonTap ?? () {},
                child: Text(istButtontext ?? ""),
              ),
              TextButton(
                onPressed: onsecondButtonTap ?? () {},
                child: Text(secondButtontext ?? ""),
              ),
            ],
          )
        ],
      );
    },
  );
}

Widget commonButton(
    {String? buttonText,
    VoidCallback? onTap,
    num height = 0.05,
    num width = 0.5}) {
  return GestureDetector(
    onTap: onTap ?? () {},
    child: Container(
      height: Get.size.height * height,
      width: Get.size.width * width,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          buttonText ?? StringConstants.tapMe,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}
