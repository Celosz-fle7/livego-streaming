import 'package:flutter/foundation.dart';

class TVHeroController extends ChangeNotifier {
  Map<String, dynamic>? _hero;

  Map<String, dynamic>? get hero => _hero;

  void setHero(Map<String, dynamic> item) {
    _hero = item;
    notifyListeners();
  }
}
