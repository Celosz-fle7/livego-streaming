import 'package:flutter/material.dart';

class TVQRPayment
    extends StatelessWidget {
  const TVQRPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(
          Icons.qr_code_2,
          size: 140,
          color: Colors.black,
        ),
      ),
    );
  }
}
