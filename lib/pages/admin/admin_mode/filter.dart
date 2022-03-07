class Filter {
  static bool _showAdmin = true;
  static bool _showStudents = true;

  static bool getBool(String query) {
    if (query == "admin") {
      return _showAdmin;
    }
    return _showStudents;
  }

  static void changeBool(String query) {
    if (query == "admin") {
      _showAdmin = !_showAdmin;
    } else {
      _showStudents = !_showStudents;
    }
  }

  static String getString(String query) {
    if (query == "admin") {
      return " Admin";
    }
    return " Student";
  }
}
