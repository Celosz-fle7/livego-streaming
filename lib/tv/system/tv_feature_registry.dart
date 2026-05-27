import 'package:flutter/material.dart';
import 'tv_feature.dart';

class TVFeatureRegistry {

  static final List<TVFeature>
      features = [

    TVFeature(
      title: 'INFERNO SYSTEM',
      value: '9999',
      icon: Icons.local_fire_department,
      color: Colors.deepOrange,
    ),

    TVFeature(
      title: 'ZENITH SYSTEM',
      value: '99999',
      icon: Icons.vertical_align_top,
      color: Colors.orange,
    ),

    TVFeature(
      title: 'PRIME SYSTEM',
      value: 'RANK 1',
      icon: Icons.military_tech,
      color: Colors.amber,
    ),

    TVFeature(
      title: 'COSMIC SYSTEM',
      value: '999999',
      icon: Icons.star,
      color: Colors.yellow,
    ),

    TVFeature(
      title: 'OMNIVERSE SYSTEM',
      value: '1000000',
      icon: Icons.blur_on,
      color: Colors.cyan,
    ),

    TVFeature(
      title: 'DIVINE SYSTEM',
      value: '777777777',
      icon: Icons.auto_awesome,
      color: Colors.green,
    ),

    TVFeature(
      title: 'ABSOLUTE SYSTEM',
      value: '999999999',
      icon: Icons.workspace_premium,
      color: Colors.amber,
    ),

  ];
}
