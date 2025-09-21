import 'package:barpass_app/core/services/storage_service.dart';
import 'package:barpass_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._storageService);

  final StorageService _storageService;

  @override
  Future<bool> isCompleted() => _storageService.isOnboardingCompleted();

  @override
  Future<void> markAsCompleted() =>
      _storageService.setOnboardingCompleted(true);

  @override
  Future<void> reset() => _storageService.setOnboardingCompleted(false);
}
