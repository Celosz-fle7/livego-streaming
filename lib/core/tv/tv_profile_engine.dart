class TVProfile {
  final String name;
  final bool kids;

  const TVProfile({
    required this.name,
    this.kids = false,
  });
}

class TVProfileEngine {
  static final List<TVProfile>
      profiles = [
    const TVProfile(
      name: 'Main',
    ),
  ];

  static int current = 0;

  static TVProfile get active =>
      profiles[current];

  static void add(
    TVProfile profile,
  ) {
    profiles.add(profile);
  }

  static void switchTo(int index) {
    if (index >= 0 &&
        index < profiles.length) {
      current = index;
    }
  }
}
