// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingNotifier)
const onboardingProvider = OnboardingNotifierProvider._();

final class OnboardingNotifierProvider
    extends $AsyncNotifierProvider<OnboardingNotifier, OnboardingStatus> {
  const OnboardingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingNotifierHash();

  @$internal
  @override
  OnboardingNotifier create() => OnboardingNotifier();
}

String _$onboardingNotifierHash() =>
    r'628e1d8b05dc476b35e901b7584705b88279c507';

abstract class _$OnboardingNotifier extends $AsyncNotifier<OnboardingStatus> {
  FutureOr<OnboardingStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<OnboardingStatus>, OnboardingStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OnboardingStatus>, OnboardingStatus>,
              AsyncValue<OnboardingStatus>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
