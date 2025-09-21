/// Tipos de URL suportados
enum UrlType {
  web,
  email,
  phone,
  sms,
  whatsapp,
  maps,
  appStore,
  playStore,
  custom,
}

/// Modos de abertura
enum LaunchMode {
  /// Abre no navegador externo
  externalApplication,

  /// Abre em WebView dentro do app (apenas web)
  inAppWebView,

  /// Abre no navegador padrão do sistema
  externalNonBrowserApplication,

  /// Abre na própria aplicação (se possível)
  platformDefault,
}

/// Resultado da operação de abrir URL
enum LaunchResult {
  success,
  failed,
  notSupported,
  cancelled,
  error,
}

/// Configurações para abrir URL
class LaunchConfig {
  const LaunchConfig({
    this.mode = LaunchMode.platformDefault,
    this.webOnlyWindowName,
    this.enableJavaScript = true,
    this.enableDomStorage = true,
    this.universalLinksOnly = false,
    this.headers = const <String, String>{},
  });

  final LaunchMode mode;
  final String? webOnlyWindowName;
  final bool enableJavaScript;
  final bool enableDomStorage;
  final bool universalLinksOnly;
  final Map<String, String> headers;

  /// Configuração padrão para web
  static const LaunchConfig web = LaunchConfig(
    mode: LaunchMode.externalApplication,
  );

  /// Configuração padrão para WebView
  static const LaunchConfig webView = LaunchConfig(
    mode: LaunchMode.inAppWebView,
  );

  /// Configuração padrão para aplicativos externos
  static const LaunchConfig external = LaunchConfig(
    mode: LaunchMode.externalNonBrowserApplication,
  );
}
