import 'package:flutter/material.dart';

Widget rank(
    {required int rank,
    required String userName,
    required int money,
    Color? rankColor,
    double? fontSize}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$rank .",
              style: TextStyle(
                  fontSize: fontSize ?? 24,
                  color: rankColor ?? const Color.fromARGB(255, 89, 120, 64)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              userName,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "$money",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 212, 163, 17),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              "\$",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 212, 163, 17),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
