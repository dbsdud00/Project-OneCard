import 'package:flutter/material.dart';
import 'package:onecard/module/text_outline.dart';

Widget elevatedBtnFunc(
  BuildContext context, {
  required String btnText,
  Color? bgColor,
  Color? textColor,
  Function()? onPressed,
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
        onPressed: onPressed ??
            () => showDialog(
                  context: context,
                  barrierColor: const Color.fromARGB(79, 255, 255, 255),
                  barrierDismissible: true,
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                    return Dialog(
                      elevation: 0,
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      child: Center(
                          child: textOutline(
                              textValue: "업데이트 예정입니다", fontSize: 30)),
                    );
                  },
                ),
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
