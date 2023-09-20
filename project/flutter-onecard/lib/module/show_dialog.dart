import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onecard/pages/main_page.dart';

Future<bool> showDialogBasic({
  required BuildContext context,
  String? title,
  Widget? content,
  Color? bgColor,
}) async {
  bool whoTurn = false;
  int cNum = Random().nextInt(6) + 1;
  int pNum = Random().nextInt(6) + 1;
  while (cNum == pNum) {
    cNum = Random().nextInt(6) + 1;
    pNum = Random().nextInt(6) + 1;
  }
  if (cNum < pNum) {
    whoTurn = true;
  }
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              title ?? "",
              style: TextStyle(
                  color: bgColor ?? const Color.fromARGB(255, 0, 0, 0)),
            ),
            Text("컴퓨터 : ${cNum.toString()}"),
            Text("플레이어 : ${pNum.toString()}"),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, whoTurn);
              },
              child: Text(whoTurn ? "선공입니다" : "후공입니다")),
        ],
      );
    },
  );
}

Future<bool> gameResult({
  required BuildContext context,
  required bool result,
}) async {
  return await showDialog(
    context: context,
    barrierColor: const Color.fromARGB(37, 255, 255, 255),
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              result ? "승리" : "패배",
              style: result
                  ? const TextStyle(color: Color.fromARGB(255, 255, 0, 0))
                  : const TextStyle(color: Color.fromARGB(255, 0, 26, 255)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.pop(context, true);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(gameResult: result)),
                  (route) => false);
            },
            child: const Text("메인으로 돌아가기"),
          ),
        ],
      );
    },
  );
}
