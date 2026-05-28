import '../live/tv_live_event_stream.dart';

class TVAutoAlertEngine {

  static final List<String>
      alerts = [];

  static void push(
    String value,
  ) {

    alerts.insert(0, value);

    TVLiveEventStream.emit(
      'ALERT: $value',
    );

    if (alerts.length > 25) {
      alerts.removeLast();
    }
  }
}
