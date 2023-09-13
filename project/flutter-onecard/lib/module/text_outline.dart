import 'package:flutter/material.dart';

Widget textOutline({
  required String textValue,
  required double fontSize,
  Color? innerColor,
  Color? outlineColor,
}) {
  return Stack(
    children: <Widget>[
      // Stroked text as border.
      Text(
        textValue,
        style: TextStyle(
          fontSize: fontSize,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10
            ..color = outlineColor ?? const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      // Solid text as fill.
      Text(
        textValue,
        style: TextStyle(
          fontSize: fontSize,
          color: innerColor ?? const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ],
  );
}
