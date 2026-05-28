import '../live/tv_live_event_stream.dart';

class TVAutoDecisionEngine {

  static final List<String>
      decisions = [];

  static void make(
    String value,
  ) {

    decisions.insert(0, value);

    TVLiveEventStream.emit(
      'AI DECISION: $value',
    );

    if (decisions.length > 25) {
      decisions.removeLast();
    }
  }
}
