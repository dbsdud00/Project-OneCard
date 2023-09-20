import 'package:flutter/material.dart';

/// Widget 을 return 하는 method
Widget inputFormField({
  required FocusNode focusNode,
  required Function(String) setValue,
  required Function(String?)
      validator, // String 이 null 일 경우, validator 도 null 일 경우도 있음
  String? hintText,
  String? helpText,
  bool? obscureText,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
    child: TextFormField(
      focusNode: focusNode,
      validator: (value) => validator(value), // validator 는 선택사항임
      onChanged: (value) => setValue(value),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        helperText: helpText,
        helperStyle: const TextStyle(color: Color.fromARGB(255, 68, 87, 96)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
