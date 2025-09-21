/// Enum type-safe para todas as rotas da aplicação.
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

  // === MAIN NAVIGATION (TABS) ===
  home('/home'),
  conta('/conta'),
  favoritos('/favoritos'),
  profile('/profile'),

  // === CONTA SUB-ROUTES ===
  contaTransacoes('/conta/transacoes'),
  contaExtrato('/conta/extrato'),
  contaCartoes('/conta/cartoes'),

  // === FAVORITOS SUB-ROUTES ===
  favoritosItem('item/:id'),

  // === PERFIL SUB-ROUTES ===
  perfilConfiguracoes('/perfil/configuracoes'),
  perfilEditar('/perfil/editar'),
  perfilSeguranca('/perfil/seguranca'),

  // === ESTABLISHMENTS ===
  establishmentDetails('/establishment/:id'),

  // === REVIEWS ===
  createReview('/review/create'),

  // === MODAIS E FLUXOS ===
  qrScanner('/qr-scanner'),
  checkout('/qr-scanner/checkout'),
  notifications('/notifications'),
  help('/help'),
  search('/search'),

  // === DEBUG ===
  debug('/debug');

  const AppRoute(this.path);

  /// O padrão de caminho da rota.
  final String path;

  /// Retorna o path relativo a partir de uma rota pai.
  String relativeFrom(AppRoute parent) {
    if (!path.startsWith(parent.path)) {
      throw ArgumentError('Route $path is not a child of ${parent.path}');
    }
    final relative = path.replaceFirst(parent.path, '');
    return relative.startsWith('/') ? relative.substring(1) : relative;
  }

  /// Constrói um [RegExp] para corresponder a um caminho de rota.
  static RegExp _buildRouteRegex(String pattern) {
    final regexPattern = pattern
        .replaceAll('/', r'\/')
        .replaceAllMapped(RegExp(r':(\w+)'), (match) => '([^/]+)');
    return RegExp('^$regexPattern\$');
  }

  /// Encontra um [AppRoute] que corresponda a um determinado [path].
  static AppRoute? fromPath(String path) {
    final cleanPath = path.split('?').first;
    for (final route in AppRoute.values) {
      final regex = _buildRouteRegex(route.path);
      if (regex.hasMatch(cleanPath)) {
        return route;
      }
    }
    return null;
  }
}
