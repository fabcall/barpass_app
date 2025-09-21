import 'package:barpass_app/app/presentation/providers/app_state_provider.dart';
import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/router/app_router_config.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/core/router/router_key.dart';
import 'package:barpass_app/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoute.startup.path,
    debugLogDiagnostics: kDebugMode,
    onEnter: (context, currentState, nextState, router) =>
        _handleOnEnter(ref, nextState, router),
    routes: AppRouterConfig.routes,
    errorBuilder: AppRouterConfig.errorBuilder,
  );
}

FutureOr<OnEnterResult> _handleOnEnter(
  Ref ref,
  GoRouterState nextState,
  GoRouter router,
) {
  final location = nextState.matchedLocation;

  final appState = ref.read(appStateProvider);
  final onboardingState = ref.read(onboardingProvider);
  final onboardingValue = onboardingState.value;

  final isReady = appState.isReady;
  final isOnboardingComplete = onboardingValue?.isCompleted ?? false;

  final isGoingToSetupRoute = _isSetupRoute(location);

  if (!isReady) {
    _preserveInitialRoute(ref, location);

    if (location != AppRoute.startup.path) {
      return Block.then(() => router.go(AppRoute.startup.path));
    }
    return const Allow();
  }

  if (!isOnboardingComplete) {
    _preserveInitialRoute(ref, location);

    if (!_isSetupRoute(location)) {
      return Block.then(() => router.go(AppRoute.onboarding.path));
    }
    return const Allow();
  }

  if (isGoingToSetupRoute) {
    final redirectService = ref.read(redirectServiceProvider);
    final initialRoute =
        redirectService.consumeInitialRoute() ?? AppRoute.home.path;
    return Block.then(() => router.go(initialRoute));
  }

  final redirectService = ref.read(redirectServiceProvider);
  final initialRoute = redirectService.consumeInitialRoute();
  if (initialRoute != null && initialRoute != location) {
    return Block.then(() => router.go(initialRoute));
  }

  return const Allow();
}

void _preserveInitialRoute(Ref ref, String location) {
  if (_isSetupRoute(location)) {
    return;
  }
  ref.read(redirectServiceProvider).setInitialRoute(location);
}

bool _isSetupRoute(String location) {
  final route = AppRoute.fromPath(location);
  return [AppRoute.startup, AppRoute.onboarding].contains(route);
}
