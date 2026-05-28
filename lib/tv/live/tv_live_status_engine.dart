class TVLiveStatusEngine {

  static String state =
      'ONLINE';

  static int activeUsers =
      1;

  static int streams =
      0;

  static void update({
    String? newState,
    int? newUsers,
    int? newStreams,
  }) {

    if (newState != null) {
      state = newState;
    }

    if (newUsers != null) {
      activeUsers = newUsers;
    }

    if (newStreams != null) {
      streams = newStreams;
    }
  }
}
