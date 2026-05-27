import 'package:flutter/material.dart';

class TVContinueButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const TVContinueButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 26,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF04D2FF),
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              'Lanjut Menonton',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
