import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:barpass_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:barpass_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_dependencies.g.dart';

/// Dependências do módulo onboarding
class OnboardingDependencies {
  OnboardingDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    onboardingRepositoryProvider,
  ];
}

@Riverpod(keepAlive: true)
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) {
  final storageService = ref.read(storageServiceProvider);
  return OnboardingLocalDataSourceImpl(storageService);
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) {
  final onboardingLocalDataSource = ref.read(onboardingLocalDataSourceProvider);
  return OnboardingRepositoryImpl(onboardingLocalDataSource);
}
