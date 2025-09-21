// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gerenciar o histórico de pesquisa

@ProviderFor(SearchHistory)
const searchHistoryProvider = SearchHistoryProvider._();

/// Provider para gerenciar o histórico de pesquisa
final class SearchHistoryProvider
    extends $AsyncNotifierProvider<SearchHistory, List<String>> {
  /// Provider para gerenciar o histórico de pesquisa
  const SearchHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  @$internal
  @override
  SearchHistory create() => SearchHistory();
}

String _$searchHistoryHash() => r'0e3194f770306327f0d5a8b99e89fc0676565d6e';

/// Provider para gerenciar o histórico de pesquisa

abstract class _$SearchHistory extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
