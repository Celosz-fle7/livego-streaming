import 'package:flutter/material.dart';

class TVPlayerScreen extends StatelessWidget {
  final String id;
  final String source;
  final String title;

  const TVPlayerScreen({
    super.key,
    required this.id,
    required this.source,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          title.isEmpty ? 'TV Player V2 Loading...' : title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
