import 'package:package_info_plus/package_info_plus.dart';

/// Serviço para gerenciar informações da aplicação
///
/// Encapsula o PackageInfo e fornece acesso fácil às informações
/// como versão, nome da app, build number, etc.
class AppInfoService {
  AppInfoService._(this._packageInfo);

  static AppInfoService? _instance;
  final PackageInfo _packageInfo;

  /// Inicializa o serviço (deve ser chamado durante o bootstrap)
  static Future<AppInfoService> initialize() async {
    if (_instance != null) return _instance!;

    final packageInfo = await PackageInfo.fromPlatform();
    _instance = AppInfoService._(packageInfo);
    return _instance!;
  }

  /// Instância singleton do serviço
  static AppInfoService get instance {
    if (_instance == null) {
      throw StateError(
        'AppInfoService not initialized. Call AppInfoService.initialize() first.',
      );
    }
    return _instance!;
  }

  /// Nome da aplicação
  String get appName => _packageInfo.appName;

  /// Package name da aplicação
  String get packageName => _packageInfo.packageName;

  /// Versão da aplicação (ex: "1.0.0")
  String get version => _packageInfo.version;

  /// Build number da aplicação (ex: "123")
  String get buildNumber => _packageInfo.buildNumber;

  /// Versão completa formatada (ex: "1.0.0 (123)")
  String get fullVersion => '$version ($buildNumber)';

  /// Versão curta para exibição (ex: "v1.0.0")
  String get shortVersion => 'v$version';

  /// Build signature (apenas Android)
  String get buildSignature => _packageInfo.buildSignature;

  /// Informações completas da aplicação para debug
  Map<String, dynamic> get debugInfo => {
    'appName': appName,
    'packageName': packageName,
    'version': version,
    'buildNumber': buildNumber,
    'buildSignature': buildSignature,
  };

  /// Verifica se é uma build de debug baseada no package name
  bool get isDebugBuild =>
      packageName.endsWith('.dev') || packageName.contains('debug');

  /// Verifica se é uma build de produção
  bool get isProductionBuild => !isDebugBuild && !isStagingBuild;

  /// Verifica se é uma build de staging
  bool get isStagingBuild => packageName.endsWith('.staging');

  /// Ambiente atual baseado no package name
  String get environment {
    if (isProductionBuild) return 'production';
    if (isStagingBuild) return 'staging';
    return 'development';
  }

  /// Compara versões (retorna true se a versão atual é maior que a fornecida)
  bool isVersionGreaterThan(String otherVersion) {
    final currentParts = version.split('.').map(int.parse).toList();
    final otherParts = otherVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < currentParts.length && i < otherParts.length; i++) {
      if (currentParts[i] > otherParts[i]) return true;
      if (currentParts[i] < otherParts[i]) return false;
    }

    return currentParts.length > otherParts.length;
  }

  /// Compara build numbers
  bool isBuildGreaterThan(String otherBuildNumber) {
    final currentBuild = int.tryParse(buildNumber) ?? 0;
    final otherBuild = int.tryParse(otherBuildNumber) ?? 0;
    return currentBuild > otherBuild;
  }

  @override
  String toString() {
    return 'AppInfo(name: $appName, version: $fullVersion, environment: $environment)';
  }
}
