import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/home/di/home_dependencies.dart';
import 'package:barpass_app/features/onboarding/di/onboarding_dependencies.dart';
import 'package:flutter_riverpod/misc.dart';

/// Gerenciador central de dependências da aplicação
class AppDependencies {
  AppDependencies._();

  /// Lista de overrides para providers específicos do ambiente
  static List<Override> get overrides => [
    // Aqui você pode adicionar overrides específicos do ambiente
    // Exemplo: para testes, desenvolvimento, produção
  ];

  /// Inicialização de dependências que precisam ser configuradas no boot
  static Future<void> initialize() async {
    // Configurações que precisam ser feitas antes da app iniciar
    // Por exemplo: configuração de logs, crash reporting, etc.
  }

  /// Lista de todos os providers da aplicação para referência
  /// Útil para debugging e documentação
  static List<ProviderBase<dynamic>> get allProviders => [
    // Core
    ...CoreDependencies.providers,
    // Features
    ...AuthDependencies.providers,
    ...HomeDependencies.providers,
    ...OnboardingDependencies.providers,
  ];
}
