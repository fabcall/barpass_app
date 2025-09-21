// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordReset)
const passwordResetProvider = PasswordResetProvider._();

final class PasswordResetProvider
    extends $NotifierProvider<PasswordReset, PasswordResetState> {
  const PasswordResetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordResetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordResetHash();

  @$internal
  @override
  PasswordReset create() => PasswordReset();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PasswordResetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PasswordResetState>(value),
    );
  }
}

String _$passwordResetHash() => r'4bcef667b59913b2a7c31150852969b074f79d70';

abstract class _$PasswordReset extends $Notifier<PasswordResetState> {
  PasswordResetState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PasswordResetState, PasswordResetState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PasswordResetState, PasswordResetState>,
              PasswordResetState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
