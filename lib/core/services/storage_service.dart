import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferencesAsync _prefs;

  const StorageService(this._prefs);

  // Keys constantes
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLanguage = 'language';
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyUserToken = 'user_token';
  static const String _keyOnboardingCompleted = 'onboarding_completed';

  // Theme
  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_keyThemeMode, mode);
  }

  Future<String?> getThemeMode() async {
    return _prefs.getString(_keyThemeMode);
  }

  // Language
  Future<void> setLanguage(String language) async {
    await _prefs.setString(_keyLanguage, language);
  }

  Future<String?> getLanguage() {
    return _prefs.getString(_keyLanguage);
  }

  // First Launch
  Future<void> setFirstLaunch(bool isFirst) async {
    await _prefs.setBool(_keyFirstLaunch, isFirst);
  }

  Future<bool> isFirstLaunch() async {
    return await _prefs.getBool(_keyFirstLaunch) ?? true;
  }

  // Auth Token
  Future<void> setUserToken(String token) async {
    await _prefs.setString(_keyUserToken, token);
  }

  Future<String?> getUserToken() {
    return _prefs.getString(_keyUserToken);
  }

  Future<void> clearUserToken() async {
    await _prefs.remove(_keyUserToken);
  }

  // Onboarding
  Future<void> setOnboardingCompleted(bool completed) async {
    await _prefs.setBool(_keyOnboardingCompleted, completed);
  }

  Future<bool> isOnboardingCompleted() async {
    return await _prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
