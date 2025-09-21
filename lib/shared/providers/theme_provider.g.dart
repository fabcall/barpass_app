// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gerenciar o tema da aplicação

@ProviderFor(ThemeNotifier)
const themeProvider = ThemeNotifierProvider._();

/// Provider para gerenciar o tema da aplicação
final class ThemeNotifierProvider
    extends $AsyncNotifierProvider<ThemeNotifier, AppThemeMode> {
  /// Provider para gerenciar o tema da aplicação
  const ThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();
}

String _$themeNotifierHash() => r'cdae77fdd0a0aac888a2b387e278f4d2317ddf8a';

/// Provider para gerenciar o tema da aplicação

abstract class _$ThemeNotifier extends $AsyncNotifier<AppThemeMode> {
  FutureOr<AppThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppThemeMode>, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppThemeMode>, AppThemeMode>,
              AsyncValue<AppThemeMode>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider derivado que retorna o ThemeMode para uso no MaterialApp

@ProviderFor(currentThemeMode)
const currentThemeModeProvider = CurrentThemeModeProvider._();

/// Provider derivado que retorna o ThemeMode para uso no MaterialApp

final class CurrentThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// Provider derivado que retorna o ThemeMode para uso no MaterialApp
  const CurrentThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return currentThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$currentThemeModeHash() => r'7a3aa4e014e49091bf3cd62e8a879a7f26806c6c';
