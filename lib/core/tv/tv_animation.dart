import 'package:flutter/material.dart';

class TVAnimation {
  static const fast =
      Duration(milliseconds: 120);

  static const normal =
      Duration(milliseconds: 220);

  static const slow =
      Duration(milliseconds: 320);

  static Curve curve =
      Curves.easeOutCubic;
}
