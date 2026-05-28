import 'package:flutter/material.dart';

import '../models/tv_feature_item.dart';

class TVFeatureManager {

  static final List<TVFeatureItem>
      items = [

    TVFeatureItem(
      id: 'inferno',
      title: 'INFERNO SYSTEM',
      value: '9999',
      icon: Icons.local_fire_department,
      color: Colors.deepOrange,
    ),

    TVFeatureItem(
      id: 'zenith',
      title: 'ZENITH SYSTEM',
      value: '99999',
      icon: Icons.vertical_align_top,
      color: Colors.orange,
    ),

    TVFeatureItem(
      id: 'prime',
      title: 'PRIME SYSTEM',
      value: 'RANK 1',
      icon: Icons.military_tech,
      color: Colors.amber,
    ),

    TVFeatureItem(
      id: 'cosmic',
      title: 'COSMIC SYSTEM',
      value: '999999',
      icon: Icons.auto_awesome,
      color: Colors.cyan,
    ),

    TVFeatureItem(
      id: 'absolute',
      title: 'ABSOLUTE SYSTEM',
      value: '999999999',
      icon: Icons.workspace_premium,
      color: Colors.green,
    ),

  ];

  static List<TVFeatureItem>
      enabledItems() {

    return items
        .where((e) => e.enabled)
        .toList();
  }
}
