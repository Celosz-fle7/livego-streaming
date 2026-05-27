class TVLanguageEngine {
  static String current = 'Indonesia';

  static final List<String>
      supported = [
    'Indonesia',
    'English',
    'Japanese',
    'Korean',
  ];

  static void setLanguage(
    String value,
  ) {
    current = value;
  }
}
