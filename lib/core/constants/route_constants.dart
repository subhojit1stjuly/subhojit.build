class RouteConstants {
  // No trailing slash — router's patternToRegExp adds (?=/|$) so it matches both forms.
  static const String basePath = String.fromEnvironment('BASE_PATH', defaultValue: '');

  static const String portfolio = '/';
  static const String career = '/career';
  static const String blogs = '/blogs';
  static const String projects = '/projects';
}
