import 'package:barpass_app/core/services/redirect_service.dart';
import 'package:barpass_app/core/services/storage_service.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_dependencies.g.dart';

/// Dependências centrais da aplicação
class CoreDependencies {
  CoreDependencies._();

  /// Lista de providers do core para referência
  static List<ProviderBase<dynamic>> get providers => [
    sharedPreferencesProvider,
    storageServiceProvider,
    redirectServiceProvider,
  ];
}

/// Provider para SharedPreferencesAsync
@Riverpod(keepAlive: true)
SharedPreferencesAsync sharedPreferences(Ref ref) {
  return SharedPreferencesAsync();
}

/// Provider para StorageService
@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) {
  final sharedPrefs = ref.read(sharedPreferencesProvider);
  return StorageService(sharedPrefs);
}

/// Provider para o serviço de redirecionamento
@Riverpod(keepAlive: true)
RedirectService redirectService(Ref ref) {
  return RedirectService.instance;
}
