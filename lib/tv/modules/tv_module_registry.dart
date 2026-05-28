import 'tv_module.dart';

class TVModuleRegistry {

  static final List<TVModule>
      modules = [

    TVModule(
      id: 'home',
      route: '/home',
    ),

    TVModule(
      id: 'live',
      route: '/live',
    ),

    TVModule(
      id: 'sports',
      route: '/sports',
    ),

    TVModule(
      id: 'search',
      route: '/search',
    ),

    TVModule(
      id: 'system',
      route: '/system',
    ),

    TVModule(
      id: 'profile',
      route: '/profile',
    ),

    TVModule(
      id: 'settings',
      route: '/settings',
    ),
  ];

  static List<TVModule>
      enabledModules() {

    return modules
        .where((m) => m.enabled)
        .toList();
  }
}
