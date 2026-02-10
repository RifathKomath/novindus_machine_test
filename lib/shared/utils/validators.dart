class AppValidators {
  static String? required(String? value, {String message = "Field is required"}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
