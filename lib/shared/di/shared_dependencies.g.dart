// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para o DataSource de tema

@ProviderFor(themeLocalDataSource)
const themeLocalDataSourceProvider = ThemeLocalDataSourceProvider._();

/// Provider para o DataSource de tema

final class ThemeLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ThemeLocalDataSource,
          ThemeLocalDataSource,
          ThemeLocalDataSource
        >
    with $Provider<ThemeLocalDataSource> {
  /// Provider para o DataSource de tema
  const ThemeLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ThemeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ThemeLocalDataSource create(Ref ref) {
    return themeLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeLocalDataSource>(value),
    );
  }
}

String _$themeLocalDataSourceHash() =>
    r'da38cfd4530d5e3bbfc273808adcfb5ccc8d4b1f';

/// Provider para o DataSource de idioma

@ProviderFor(languageLocalDataSource)
const languageLocalDataSourceProvider = LanguageLocalDataSourceProvider._();

/// Provider para o DataSource de idioma

final class LanguageLocalDataSourceProvider
    extends
        $FunctionalProvider<
          LanguageLocalDataSource,
          LanguageLocalDataSource,
          LanguageLocalDataSource
        >
    with $Provider<LanguageLocalDataSource> {
  /// Provider para o DataSource de idioma
  const LanguageLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<LanguageLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LanguageLocalDataSource create(Ref ref) {
    return languageLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageLocalDataSource>(value),
    );
  }
}

String _$languageLocalDataSourceHash() =>
    r'7aad3798d9d83b7c7800054d8d5a0fde758a6196';
