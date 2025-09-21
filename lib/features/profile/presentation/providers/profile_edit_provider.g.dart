// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier para edição de perfil
///
/// Coordena a atualização de dados do usuário e avatar

@ProviderFor(ProfileEditNotifier)
const profileEditProvider = ProfileEditNotifierProvider._();

/// Notifier para edição de perfil
///
/// Coordena a atualização de dados do usuário e avatar
final class ProfileEditNotifierProvider
    extends $NotifierProvider<ProfileEditNotifier, ProfileEditState> {
  /// Notifier para edição de perfil
  ///
  /// Coordena a atualização de dados do usuário e avatar
  const ProfileEditNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileEditProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileEditNotifierHash();

  @$internal
  @override
  ProfileEditNotifier create() => ProfileEditNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileEditState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileEditState>(value),
    );
  }
}

String _$profileEditNotifierHash() =>
    r'f79ba940cd77b5061a2e61829a5acadb52d79b30';

/// Notifier para edição de perfil
///
/// Coordena a atualização de dados do usuário e avatar

abstract class _$ProfileEditNotifier extends $Notifier<ProfileEditState> {
  ProfileEditState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProfileEditState, ProfileEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileEditState, ProfileEditState>,
              ProfileEditState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
