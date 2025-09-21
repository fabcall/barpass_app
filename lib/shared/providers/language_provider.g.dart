// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gerenciar o idioma da aplicação

@ProviderFor(LanguageNotifier)
const languageProvider = LanguageNotifierProvider._();

/// Provider para gerenciar o idioma da aplicação
final class LanguageNotifierProvider
    extends $AsyncNotifierProvider<LanguageNotifier, AppLanguage> {
  /// Provider para gerenciar o idioma da aplicação
  const LanguageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageNotifierHash();

  @$internal
  @override
  LanguageNotifier create() => LanguageNotifier();
}

String _$languageNotifierHash() => r'a629e40f1606b2091974aa9820835bf7562490ba';

/// Provider para gerenciar o idioma da aplicação

abstract class _$LanguageNotifier extends $AsyncNotifier<AppLanguage> {
  FutureOr<AppLanguage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppLanguage>, AppLanguage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppLanguage>, AppLanguage>,
              AsyncValue<AppLanguage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider derivado que retorna o código do idioma atual

@ProviderFor(currentLanguageCode)
const currentLanguageCodeProvider = CurrentLanguageCodeProvider._();

/// Provider derivado que retorna o código do idioma atual

final class CurrentLanguageCodeProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provider derivado que retorna o código do idioma atual
  const CurrentLanguageCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentLanguageCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLanguageCodeHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentLanguageCode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentLanguageCodeHash() =>
    r'12c61d000219afdc77bb4dbe5147c4abd339f7c6';
