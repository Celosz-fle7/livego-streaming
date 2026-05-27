import 'tv_safe_nav_stack.dart';
import 'tv_route_logger.dart';

class TVSafeNavigationEngine {

  static void navigate(
    String route,
  ) {

    TVSafeNavStack.push(
      route,
    );

    TVRouteLogger.add(
      route,
    );
  }

  static void back() {

    TVSafeNavStack.pop();
  }
}
