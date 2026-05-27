class TVQualityEngine {
  static const qualities = [
    'Auto',
    '380p',
    '480p',
    '560p',
    '720p',
    '1080p',
  ];

  static int next(int current) {
    current++;

    if (current >= qualities.length) {
      current = 0;
    }

    return current;
  }
}
