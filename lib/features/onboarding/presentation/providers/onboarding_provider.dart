import 'package:barpass_app/features/onboarding/di/onboarding_dependencies.dart';
import 'package:barpass_app/features/onboarding/presentation/state/onboarding_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  Future<OnboardingStatus> build() async {
    final repository = ref.read(onboardingRepositoryProvider);

    try {
      final isCompleted = await repository.isCompleted();
      return OnboardingStatus(
        isCompleted: isCompleted,
        isInitialized: true,
      );
    } on Exception catch (error) {
      return OnboardingStatus(
        isCompleted: false,
        isInitialized: true,
        error: error.toString(),
      );
    }
  }

  Future<void> markAsCompleted() async {
    if (state.isLoading) return;

    // Atualização otimista
    state = const AsyncValue.data(
      OnboardingStatus(isCompleted: true, isInitialized: true),
    );

    try {
      final repository = ref.read(onboardingRepositoryProvider);
      await repository.markAsCompleted();
    } on Exception catch (error) {
      // Reverter em caso de erro
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  Future<void> reset() async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(onboardingRepositoryProvider);
      await repository.reset();

      state = const AsyncValue.data(
        OnboardingStatus(isCompleted: false, isInitialized: true),
      );
    } on Exception catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
