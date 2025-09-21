/// Constantes da aplicação - apenas valores que não são de tema
///
/// Mantém apenas configurações de comportamento, não de aparência
class AppConstants {
  AppConstants._();

  // === ANIMAÇÕES ===
  /// Duração padrão para transições
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Duração rápida para micro-interações
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  /// Duração longa para animações complexas
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // === COMPORTAMENTO ===
  /// Tempo limite padrão para requests HTTP
  static const Duration defaultTimeout = Duration(seconds: 30);

  /// Número máximo de tentativas para retry
  static const int maxRetryAttempts = 3;

  /// Delay entre tentativas de retry
  static const Duration retryDelay = Duration(seconds: 2);

  // === VALIDAÇÃO ===
  /// Comprimento mínimo de senha
  static const int minPasswordLength = 8;

  /// Comprimento máximo de senha
  static const int maxPasswordLength = 128;

  /// Tempo de debounce para pesquisa
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // === PAGINAÇÃO ===
  /// Itens por página padrão
  static const int defaultPageSize = 20;

  /// Limite máximo de itens por página
  static const int maxPageSize = 100;

  // === CACHE ===
  /// Tempo de vida padrão do cache
  static const Duration defaultCacheLifetime = Duration(hours: 1);

  /// Tempo de vida do cache de imagens
  static const Duration imageCacheLifetime = Duration(days: 7);

  // === URLS E DEEP LINKS ===
  /// URL base da documentação
  static const String docsUrl = 'https://docs.barpass.com';

  /// URL de suporte
  static const String supportUrl = 'https://support.barpass.com';

  /// URL de termos de uso
  static const String termsUrl = 'https://barpass.com/terms';

  /// URL de política de privacidade
  static const String privacyUrl = 'https://barpass.com/privacy';
}
