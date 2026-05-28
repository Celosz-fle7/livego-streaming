import '../live/tv_live_event_stream.dart';

class TVSmartAnalyzer {

  static int analyzed =
      0;

  static void run(
    String target,
  ) {

    analyzed++;

    TVLiveEventStream.emit(
      'AI ANALYZED: $target',
    );
  }
}
