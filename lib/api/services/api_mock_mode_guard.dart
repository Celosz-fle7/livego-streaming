import 'api_config.dart';

class ApiMockModeGuard {
  static bool get enabled => !ApiConfig.hasBackend;

  static String get label => enabled ? 'MOCK MODE' : 'BACKEND MODE';
}
