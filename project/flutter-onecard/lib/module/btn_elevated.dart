import 'package:flutter/material.dart';
import 'package:onecard/pages/start_page.dart';

Widget elevatedBtn(
  BuildContext context, {
  required String btnText,
  Color? bgColor,
  Color? textColor,
  Widget? onPressed,
  double? width,
  double? height,
  double? fontSize,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: width ?? 280,
      height: height ?? 70,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => onPressed ?? const StartPage())),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? const Color.fromARGB(255, 255, 124, 124),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: fontSize ?? 24,
              color: textColor ?? const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    ),
  );
}
