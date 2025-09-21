/// Definição de uma rota com nome e path
class RouteDefinition {
  const RouteDefinition({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}

/// Definições centralizadas de todas as rotas da aplicação
class AppRoutes {
  AppRoutes._(); // Construtor privado

  // === ROTAS DE SETUP/INICIALIZAÇÃO ===
  static const startup = RouteDefinition(
    name: 'startup',
    path: '/startup',
  );

  static const onboarding = RouteDefinition(
    name: 'onboarding',
    path: '/onboarding',
  );

  // === ROTA PRINCIPAL ===
  static const landing = RouteDefinition(
    name: 'landing',
    path: '/',
  );

  // === ROTAS DE AUTENTICAÇÃO ===
  static const login = RouteDefinition(
    name: 'login',
    path: 'login', // Relativa à landing
  );

  static const registration = RouteDefinition(
    name: 'registration',
    path: 'registration',
  );

  static const passwordReset = RouteDefinition(
    name: 'password-reset',
    path: 'password-reset',
  );

  // === ROTAS DO SHELL NAVIGATION ===
  static const home = RouteDefinition(
    name: 'home',
    path: '/home',
  );

  static const conta = RouteDefinition(
    name: 'conta',
    path: '/conta',
  );

  static const favoritos = RouteDefinition(
    name: 'favoritos',
    path: '/favoritos',
  );

  static const perfil = RouteDefinition(
    name: 'perfil',
    path: '/perfil',
  );

  // === SUB-ROTAS ===
  static const homeDetails = RouteDefinition(
    name: 'home-details',
    path: 'details/:id',
  );

  static const transacoes = RouteDefinition(
    name: 'transacoes',
    path: 'transacoes',
  );

  static const extrato = RouteDefinition(
    name: 'extrato',
    path: 'extrato',
  );

  static const cartoes = RouteDefinition(
    name: 'cartoes',
    path: 'cartoes',
  );

  static const favoritoItem = RouteDefinition(
    name: 'favorito-item',
    path: 'item/:id',
  );

  static const configuracoes = RouteDefinition(
    name: 'configuracoes',
    path: 'configuracoes',
  );

  static const editarPerfil = RouteDefinition(
    name: 'editar-perfil',
    path: 'editar',
  );

  static const seguranca = RouteDefinition(
    name: 'seguranca',
    path: 'seguranca',
  );

  // === ROTAS ESPECIAIS ===
  static const qrScanner = RouteDefinition(
    name: 'qr-scanner',
    path: '/qr-scanner',
  );

  static const notifications = RouteDefinition(
    name: 'notifications',
    path: '/notifications',
  );

  static const help = RouteDefinition(
    name: 'help',
    path: '/help',
  );

  static const debug = RouteDefinition(
    name: 'debug',
    path: '/debug',
  );

  // === HELPERS PARA CONSTRUIR ROTAS COM PARÂMETROS ===
  static String homeDetailsWithId(String id) => '${home.path}/details/$id';
  static String favoritoItemWithId(String id) => '${favoritos.path}/item/$id';

  // Helpers para sub-rotas
  static String contaTransacoes() => '${conta.path}/${transacoes.path}';
  static String contaExtrato() => '${conta.path}/${extrato.path}';
  static String contaCartoes() => '${conta.path}/${cartoes.path}';

  static String perfilConfiguracoes() => '${perfil.path}/${configuracoes.path}';
  static String perfilEditar() => '${perfil.path}/${editarPerfil.path}';
  static String perfilSeguranca() => '${perfil.path}/${seguranca.path}';

  // === LISTAS DE CATEGORIZAÇÃO ===
  static const List<RouteDefinition> setupRoutes = [startup, onboarding];

  static const List<RouteDefinition> authRoutes = [
    login,
    registration,
    passwordReset,
  ];

  static const List<RouteDefinition> mainRoutes = [
    home,
    conta,
    favoritos,
    perfil,
  ];

  static const List<RouteDefinition> specialRoutes = [
    qrScanner,
    notifications,
    help,
  ];

  // Lista de rotas protegidas (requer autenticação futuramente)
  static final List<String> protectedRoutePaths = [
    ...mainRoutes.map((r) => r.path),
    ...specialRoutes.map((r) => r.path),
  ];

  // === VERIFICADORES DE ROTA ===
  static bool isSetupRoute(String path) =>
      setupRoutes.any((route) => route.path == path);

  static bool isAuthRoute(String path) =>
      authRoutes.any((route) => route.path == path);

  static bool isMainRoute(String path) =>
      mainRoutes.any((route) => path.startsWith(route.path));

  static bool isProtectedRoute(String path) =>
      protectedRoutePaths.any((route) => path.startsWith(route));

  // === MÉTODOS UTILITÁRIOS ===

  /// Encontra uma rota por nome
  static RouteDefinition? findByName(String name) {
    final allRoutes = [
      startup,
      onboarding,
      landing,
      ...authRoutes,
      ...mainRoutes,
      ...specialRoutes,
      homeDetails,
      transacoes,
      extrato,
      cartoes,
      favoritoItem,
      configuracoes,
      editarPerfil,
      seguranca,
      debug,
    ];

    try {
      return allRoutes.firstWhere((route) => route.name == name);
    } catch (e) {
      return null;
    }
  }

  /// Encontra uma rota por path
  static RouteDefinition? findByPath(String path) {
    final allRoutes = [
      startup,
      onboarding,
      landing,
      ...authRoutes,
      ...mainRoutes,
      ...specialRoutes,
      homeDetails,
      transacoes,
      extrato,
      cartoes,
      favoritoItem,
      configuracoes,
      editarPerfil,
      seguranca,
      debug,
    ];

    try {
      return allRoutes.firstWhere((route) => route.path == path);
    } catch (e) {
      return null;
    }
  }

  /// Lista todas as rotas para debugging
  static List<RouteDefinition> getAllRoutes() {
    return [
      startup,
      onboarding,
      landing,
      ...authRoutes,
      ...mainRoutes,
      ...specialRoutes,
      homeDetails,
      transacoes,
      extrato,
      cartoes,
      favoritoItem,
      configuracoes,
      editarPerfil,
      seguranca,
      debug,
    ];
  }
}
