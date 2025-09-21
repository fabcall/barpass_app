abstract class OnboardingRepository {
  Future<bool> isCompleted();
  Future<void> markAsCompleted();
  Future<void> reset();
}
