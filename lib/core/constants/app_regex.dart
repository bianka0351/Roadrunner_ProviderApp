class AppRegex {
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
}