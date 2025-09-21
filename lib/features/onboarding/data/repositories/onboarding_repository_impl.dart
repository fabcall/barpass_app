import 'package:barpass_app/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:barpass_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._onboardingLocalDataSource);

  final OnboardingLocalDataSource _onboardingLocalDataSource;

  @override
  Future<bool> isCompleted() =>
      _onboardingLocalDataSource.isOnboardingCompleted();

  @override
  Future<void> markAsCompleted() =>
      _onboardingLocalDataSource.setOnboardingCompleted(true);

  @override
  Future<void> reset() =>
      _onboardingLocalDataSource.setOnboardingCompleted(false);
}
