class AppConfig {
  static const String _environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static bool get isProduction => _environment == 'prod';
  static bool get isDevelopment => _environment == 'dev';
  static bool get isStaging => _environment == 'staging';

  static String get apiBaseUrl => switch (_environment) {
    'prod' => 'https://api.barpass.com',
    'staging' => 'https://staging-api.barpass.com',
    _ => 'https://dev-api.barpass.com',
  };
}
