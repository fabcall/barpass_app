// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryLocalDataSource)
const searchHistoryLocalDataSourceProvider =
    SearchHistoryLocalDataSourceProvider._();

final class SearchHistoryLocalDataSourceProvider
    extends
        $FunctionalProvider<
          SearchHistoryLocalDataSource,
          SearchHistoryLocalDataSource,
          SearchHistoryLocalDataSource
        >
    with $Provider<SearchHistoryLocalDataSource> {
  const SearchHistoryLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchHistoryLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchHistoryLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchHistoryLocalDataSource create(Ref ref) {
    return searchHistoryLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchHistoryLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchHistoryLocalDataSource>(value),
    );
  }
}

String _$searchHistoryLocalDataSourceHash() =>
    r'ab2d6aef1487a8b47f868f125b177a213a2b8636';
