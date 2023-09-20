import 'package:flutter/material.dart';
import 'package:onecard/pages/main_page.dart';

Future<bool> onBackKey({
  required BuildContext context,
  String? title,
  Function()? yes,
  Function()? no,
  List<Widget>? actions,
  Color? bgColor,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title ?? "끝낼까요?",
          style: TextStyle(color: bgColor ?? Colors.blueAccent),
        ),
        actions: actions ??
            [
              TextButton(
                  onPressed: yes ??
                      () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage(
                                    gameResult: false,
                                  )),
                          (route) => false),
                  child: const Text('네')),
              TextButton(
                onPressed: no ?? () => Navigator.pop(context, false),
                child: const Text("아니요"),
              )
            ],
      );
    },
  );
}
