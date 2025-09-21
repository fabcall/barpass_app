import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/features/search/data/datasources/search_history_local_datasource.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_dependencies.g.dart';

/// Dependências do módulo search
class SearchDependencies {
  SearchDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Datasources
    searchHistoryLocalDataSourceProvider,
  ];
}

// === DATASOURCES ===
@Riverpod(keepAlive: true)
SearchHistoryLocalDataSource searchHistoryLocalDataSource(Ref ref) {
  final storage = ref.read(storageServiceProvider);
  return SearchHistoryLocalDataSourceImpl(storage);
}
