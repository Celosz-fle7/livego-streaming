import 'tv_hero_state.dart';

class TVHeroSync {
  static void update(
    Map<String, dynamic> item,
  ) {
    TVHeroState.current = item;
  }

  static Map<String, dynamic>? get current {
    return TVHeroState.current;
  }
}
