import 'package:flutter/material.dart';

class TVSeekPreview
    extends StatelessWidget {
  final String time;

  const TVSeekPreview({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        time,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
