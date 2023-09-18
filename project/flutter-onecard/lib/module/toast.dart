import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast(String text, FToast fToast) {
  return fToast.showToast(
    toastDuration: const Duration(milliseconds: 1000),
    child: Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        // side: const BorderSide(style: BorderStyle.solid),
      ),
      color: const Color.fromARGB(255, 201, 223, 255),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
    ),
    gravity: ToastGravity.CENTER,
  );
}
