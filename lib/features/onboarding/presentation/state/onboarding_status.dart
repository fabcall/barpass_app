import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_status.freezed.dart';

@freezed
sealed class OnboardingStatus with _$OnboardingStatus {
  const factory OnboardingStatus({
    required bool isCompleted,
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,
    String? error,
  }) = _OnboardingStatus;

  const OnboardingStatus._();

  // Helpers para facilitar o uso
  bool get hasError => error != null;
}
