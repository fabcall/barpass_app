import 'dart:developer';

import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesInitializer extends BaseInitializer {
  @override
  String get name => 'SharedPreferences';

  @override
  bool get isCritical => true; // SharedPreferences é crítico

  @override
  Future<InitializerResult> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      log('💾 SharedPreferences inicializado');

      return InitializerResult(
        providerOverrides: [],
        metadata: {
          'preferences_keys_count': prefs.getKeys().length,
        },
      );
    } catch (e) {
      log('❌ Erro ao inicializar SharedPreferences: $e');
      rethrow;
    }
  }
}
