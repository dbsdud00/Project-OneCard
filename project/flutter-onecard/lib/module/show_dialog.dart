import 'dart:math';

import 'package:flutter/material.dart';

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
