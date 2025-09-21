import 'package:barpass_app/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider para SharedPreferencesAsync
final sharedPreferencesProvider = Provider<SharedPreferencesAsync>((ref) {
  return SharedPreferencesAsync();
});

/// Provider para StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  final sharedPrefs = ref.read(sharedPreferencesProvider);
  return StorageService(sharedPrefs);
});
