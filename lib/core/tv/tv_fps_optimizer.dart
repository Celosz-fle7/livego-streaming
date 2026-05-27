import 'package:flutter/scheduler.dart';

class TVFPSOptimizer {
  static void optimize() {
    SchedulerBinding.instance
        .scheduleWarmUpFrame();
  }
}
