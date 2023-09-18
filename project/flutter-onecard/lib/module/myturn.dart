import 'package:flutter/material.dart';

class MyTurn extends StatefulWidget {
  const MyTurn({super.key, required this.turn});
  final bool turn;
  @override
  State<MyTurn> createState() => _MyTurnState();
}

class _MyTurnState extends State<MyTurn> {
  bool cTurn = false;
  bool pTurn = false;
  void _show(bool turn) {
    setState(() {
      turn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              _show(cTurn);
              Future.delayed(const Duration(seconds: 1), () {
                _show(pTurn);
              });
            },
            child: Visibility(
              visible: cTurn,
              child: const Text("hi"),
            )),
        GestureDetector(
            onTap: () {
              _show(pTurn);
              Future.delayed(const Duration(seconds: 1), () {
                _show(cTurn);
                _show(widget.turn);
              });
            },
            child: Visibility(
              visible: pTurn,
              child: const Text("hi"),
            )),
      ],
    );
  }
}
