import 'package:barpass_app/core/services/storage_service.dart';

/// DataSource para gerenciar o estado do onboarding
abstract class OnboardingLocalDataSource {
  /// Verifica se o onboarding foi completado
  Future<bool> isOnboardingCompleted();

  /// Marca o onboarding como completado
  Future<void> setOnboardingCompleted(bool completed);
}

/// Implementação do DataSource de onboarding
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  static const String _keyOnboardingCompleted = 'onboarding_completed';

  @override
  Future<bool> isOnboardingCompleted() async {
    final completed = await _storage.getBool(_keyOnboardingCompleted);
    return completed ?? false;
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    await _storage.setBool(_keyOnboardingCompleted, completed);
  }
}
