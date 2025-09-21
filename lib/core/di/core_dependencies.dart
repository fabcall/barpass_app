import 'package:barpass_app/core/services/app_info_service.dart';
import 'package:barpass_app/core/services/location_service.dart';
import 'package:barpass_app/core/services/redirect_service.dart';
import 'package:barpass_app/core/services/share_service.dart';
import 'package:barpass_app/core/services/storage_service.dart';
import 'package:barpass_app/core/services/url_launcher_service.dart';
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
    appInfoServiceProvider,
    urlLauncherServiceProvider,
    shareServiceProvider,
    locationServiceProvider,
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

/// Provider para o serviço de redirecionamento
@Riverpod(keepAlive: true)
AppInfoService appInfoService(Ref ref) {
  return AppInfoService.instance;
}

/// Provider para o serviço de
@Riverpod(keepAlive: true)
UrlLauncherService urlLauncherService(Ref ref) {
  return const UrlLauncherService();
}

@Riverpod(keepAlive: true)
ShareService shareService(Ref ref) {
  return const ShareService();
}

/// Provider do serviço de localização
@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) {
  return const LocationService();
}
