class Patterns {
  static String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String usernamePattern = r"^[a-zA-Z0-9]+";
  static String upperAlpha = "[A-Z]+";
  static String specialChar = "[!@#\$%^&*_]+";
  static String digitPattern = r"\d+";
  //static String strongPasswordPattern = "[a-zA-Z0-9!@#\$%^&*_]{8,}";
  static String phonePattern =
      r"^(?:(?:\+|00)([0-9]{1,3})|\((?:\+|00)([0-9]{1,3})\))[- ]?([0-9]{2})[- ]?([0-9]{6,7})$";
}
