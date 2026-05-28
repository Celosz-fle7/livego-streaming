import 'package:flutter/material.dart';

import '../system/tv_system_dashboard.dart';
import '../system/tv_system_initializer.dart';

class TVSystemScreen extends StatefulWidget {
  const TVSystemScreen({super.key});

  @override
  State<TVSystemScreen> createState() => _TVSystemScreenState();
}

class _TVSystemScreenState extends State<TVSystemScreen> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    await TVSystemInitializer.init();

    if (!mounted) return;

    setState(() {
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF04D2FF),
          ),
        ),
      );
    }

    return const Scaffold(
      backgroundColor: Colors.black,
      body: TVSystemDashboard(),
    );
  }
}
