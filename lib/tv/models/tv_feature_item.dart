import 'package:flutter/material.dart';

class TVFeatureItem {

  final String id;
  final String title;
  final String value;

  final IconData icon;
  final Color color;

  final bool enabled;

  const TVFeatureItem({
    required this.id,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.enabled = true,
  });
}
