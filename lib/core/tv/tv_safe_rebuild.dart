import 'package:flutter/material.dart';

mixin TVSafeRebuild<T extends StatefulWidget>
    on State<T> {
  void safeSetState(VoidCallback fn) {
    if (!mounted) return;

    setState(fn);
  }
}
