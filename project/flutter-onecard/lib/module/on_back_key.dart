import 'package:flutter/material.dart';

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
                  onPressed: yes ?? () => Navigator.pop(context, true),
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
