import 'package:flutter/widgets.dart';

class TVPlayerGap
    extends StatelessWidget {
  final double size;

  const TVPlayerGap({
    super.key,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
