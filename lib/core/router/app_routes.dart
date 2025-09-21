/// Rotas da aplicação usando Enhanced Enums
///
/// ✅ Type-safe: impossível usar rota inexistente
/// ✅ Autocomplete: IDE mostra todas as opções
/// ✅ Refatoração segura: renomear atualiza tudo
/// ✅ Agrupamento: organize por categoria
enum AppRoute {
  // === SISTEMA ===
  startup('/startup'),
  onboarding('/onboarding'),

  // === LANDING & AUTH ===
  landing('/'),
  login('/login'),
  registration('/registration'),
  passwordReset('/login/password-reset'),
  otpVerification('/login/password-reset/otp-verification'),
  changePassword('/login/password-reset/change-password'),

  // === MAIN NAVIGATION ===
  home('/home'),
  conta('/conta'),
  favoritos('/favoritos'),
  profile('/profile'),

  // === CONTA SUB-ROUTES ===
  contaTransacoes('/conta/transacoes'),
  contaExtrato('/conta/extrato'),
  contaCartoes('/conta/cartoes'),

  // === FAVORITOS SUB-ROUTES ===
  favoritosItem('item/:id'), // Pattern para rotas aninhadas

  // === PERFIL SUB-ROUTES ===
  perfilConfiguracoes('/perfil/configuracoes'),
  perfilEditar('/perfil/editar'),
  perfilSeguranca('/perfil/seguranca'),

  // === ESTABLISHMENTS ===
  establishmentDetails('/establishment/:id'), // Pattern completo

  // === MODALS ===
  qrScanner('/qr-scanner'),
  notifications('/notifications'),
  help('/help'),

  search('/search'),

  // === DEBUG ===
  debug('/debug');

  const AppRoute(this.path);

  /// Path absoluto da rota (ou pattern para rotas com parâmetros)
  final String path;

  /// Retorna o path relativo a partir de um parent
  ///
  /// Exemplo:
  /// - `AppRoute.contaTransacoes.relativeFrom(AppRoute.conta)` retorna 'transacoes'
  /// - `AppRoute.passwordReset.relativeFrom(AppRoute.login)` retorna 'password-reset'
  String relativeFrom(AppRoute parent) {
    if (!path.startsWith(parent.path)) {
      throw ArgumentError(
        'Route $path is not a child of ${parent.path}',
      );
    }

    final relative = path.replaceFirst(parent.path, '');
    return relative.startsWith('/') ? relative.substring(1) : relative;
  }

  // === CATEGORIZAÇÃO ===

  /// Verifica se é rota de sistema
  bool get isSystem => [startup, onboarding].contains(this);

  /// Verifica se é rota de autenticação
  bool get isAuth => [
    login,
    registration,
    passwordReset,
    otpVerification,
    changePassword,
  ].contains(this);

  /// Verifica se é rota principal
  bool get isMain => [home, conta, favoritos, profile].contains(this);

  /// Verifica se é modal
  bool get isModal => [qrScanner, notifications, help].contains(this);

  // === GRUPOS (para iteração) ===

  static const List<AppRoute> systemRoutes = [
    startup,
    onboarding,
  ];

  static const List<AppRoute> authRoutes = [
    login,
    registration,
    passwordReset,
    otpVerification,
    changePassword,
  ];

  static const List<AppRoute> mainRoutes = [
    home,
    conta,
    favoritos,
    profile,
  ];

  static const List<AppRoute> modalRoutes = [
    qrScanner,
    notifications,
    help,
  ];

  // === HELPERS ESTÁTICOS ===

  /// Todas as rotas da aplicação
  static List<AppRoute> get all => AppRoute.values;

  static AppRoute? fromPath(String path) {
    for (final route in AppRoute.values) {
      // Remove query parameters se houver
      final cleanPath = path.split('?').first;

      // Verifica se o padrão da rota corresponde ao path
      final pattern = route.path;
      final regex = _buildRouteRegex(pattern);

      if (regex.hasMatch(cleanPath)) {
        return route;
      }
    }
    return null;
  }

  // Converte padrão de rota (:id, :slug) em regex
  static RegExp _buildRouteRegex(String pattern) {
    // Escapa caracteres especiais e substitui :param por captura
    final regexPattern = pattern
        .replaceAll('/', r'\/')
        .replaceAllMapped(
          RegExp(r':(\w+)'),
          (match) => '([^/]+)', // Captura qualquer coisa exceto /
        );

    return RegExp('^$regexPattern\$');
  }

  /// Verifica se um path existe
  static bool exists(String path) => fromPath(path) != null;
}
