import 'package:barpass_app/app/presentation/providers/app_state_provider.dart';
import 'package:barpass_app/core/router/app_router_config.dart';
import 'package:barpass_app/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

/// Notifier para refresh do router baseado em múltiplos providers
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(this._ref) {
    // Escutar mudanças no app state
    _ref
      ..listen(appStateProvider, (previous, next) {
        notifyListeners();
      })
      ..listen(onboardingProvider, (previous, next) {
        notifyListeners();
      });
  }

  final Ref _ref;
}

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/startup',
    debugLogDiagnostics: kDebugMode,

    // Refresh quando estados mudarem
    refreshListenable: RouterRefreshNotifier(ref),

    // Lógica de redirecionamento centralizada
    redirect: (context, state) {
      return _handleRedirect(ref, state);
    },

    routes: AppRouterConfig.routes,
    errorBuilder: AppRouterConfig.errorBuilder,
  );
}

/// Lógica centralizada de redirecionamento
String? _handleRedirect(Ref ref, GoRouterState state) {
  final location = state.matchedLocation;

  // 1. Verificar inicialização da app
  final appState = ref.read(appStateProvider);

  if (!appState.isReady) {
    // App ainda não inicializou ou teve erro
    if (location != '/startup') {
      return '/startup';
    }
    return null;
  }

  // 2. App inicializada - verificar onboarding
  final onboardingState = ref.read(onboardingProvider);

  // Se o onboarding ainda está carregando, continua no startup
  if (onboardingState.isLoading) {
    if (location != '/startup') {
      return '/startup';
    }
    return null;
  }

  // Se houve erro no onboarding, continua no startup
  if (onboardingState.hasError) {
    if (location != '/startup') {
      return '/startup';
    }
    return null;
  }

  final onboardingValue = onboardingState.value;
  if (onboardingValue == null || !onboardingValue.isInitialized) {
    // Onboarding ainda não inicializou
    if (location != '/startup') {
      return '/startup';
    }
    return null;
  }

  // 3. Onboarding inicializado - verificar se foi completado
  if (!onboardingValue.isCompleted) {
    // Onboarding não foi completado
    if (location != '/onboarding') {
      return '/onboarding';
    }
    return null;
  }

  // 4. Onboarding completado - redirecionar de páginas de setup
  if (_isSetupRoute(location)) {
    return '/'; // Landing page
  }

  // 5. Verificar autenticação (futuro)
  // if (!appStateValue.isAuthenticated && _isProtectedRoute(location)) {
  //   return '/';
  // }

  return null; // Continua com a rota normal
}

bool _isSetupRoute(String location) {
  return location == '/startup' || location == '/onboarding';
}

bool _isProtectedRoute(String location) {
  return location.startsWith('/home') ||
      location.startsWith('/conta') ||
      location.startsWith('/favoritos') ||
      location.startsWith('/perfil');
}
