import 'dart:async';

import 'package:flutter/material.dart';

class TVPlayerClock
    extends StatefulWidget {
  const TVPlayerClock({
    super.key,
  });

  @override
  State<TVPlayerClock> createState() =>
      _TVPlayerClockState();
}

class _TVPlayerClockState
    extends State<TVPlayerClock> {
  late Timer _timer;

  String _time = '';

  @override
  void initState() {
    super.initState();

    _update();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _update(),
    );
  }

  void _update() {
    final now = DateTime.now();

    setState(() {
      _time =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _time,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
