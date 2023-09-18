import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.seconds, required this.isRunning});

  final int seconds;
  final bool isRunning;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;

  void _startTimer() {
    widget.isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.seconds > 0) {
          widget.seconds--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    widget.isRunning = false;
    _timer.cancel();
    setState(() {
      widget.seconds = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$widget.seconds', style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: widget.isRunning ? null : _startTimer,
              child: const Text('Start'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: widget.isRunning ? _stopTimer : null,
              child: const Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }
}
