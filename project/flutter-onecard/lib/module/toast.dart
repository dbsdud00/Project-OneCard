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
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 20, 70, 20),
            child: SizedBox(
              width: 200,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    ),
    gravity: ToastGravity.CENTER,
  );
}
