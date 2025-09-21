import 'dart:developer';

import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:barpass_app/core/services/app_info_service.dart';

class AppInfoInitializer extends BaseInitializer {
  @override
  String get name => 'AppInfo';

  @override
  bool get isCritical => false;

  @override
  Future<InitializerResult> initialize() async {
    try {
      final appInfoService = await AppInfoService.initialize();

      log(
        '📱 App Info inicializado: ${appInfoService.appName} ${appInfoService.fullVersion}',
      );
      log('📦 Package: ${appInfoService.packageName}');
      log('🌍 Environment: ${appInfoService.environment}');

      return InitializerResult(
        metadata: {
          'app_name': appInfoService.appName,
          'version': appInfoService.version,
          'build_number': appInfoService.buildNumber,
          'environment': appInfoService.environment,
          'package_name': appInfoService.packageName,
        },
      );
    } on Exception catch (error) {
      log('❌ Erro ao inicializar AppInfo: $error');
      rethrow;
    }
  }
}
