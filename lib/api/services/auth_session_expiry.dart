class AuthSessionExpiry {
  static DateTime? expiry;

  static bool get expired {
    if (expiry == null) {
      return true;
    }

    return DateTime.now().isAfter(expiry!);
  }

  static void update({
    required int minutes,
  }) {
    expiry = DateTime.now().add(
      Duration(minutes: minutes),
    );
  }
}
