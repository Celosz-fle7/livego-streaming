class TVRemoteShortcutEngine {
  static final Map<String, String>
      actions = {
    'RED': 'Favorites',
    'GREEN': 'Search',
    'BLUE': 'Settings',
  };

  static void setAction(
    String key,
    String value,
  ) {
    actions[key] = value;
  }
}
