import 'package:flutter/material.dart';

import 'tv_universal_panel.dart';

class TVWidgetFactory {

  static Widget panel({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {

    return TVUniversalPanel(
      title: title,
      value: value,
      icon: icon,
      color: color,
    );
  }
}
