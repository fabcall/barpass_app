import 'package:barpass_app/features/search/di/search_dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

/// Provider para gerenciar o histórico de pesquisa
@riverpod
class SearchHistory extends _$SearchHistory {
  static const int _maxHistorySize = 5;

  @override
  Future<List<String>> build() async {
    // Carrega o histórico do datasource
    final datasource = ref.read(searchHistoryLocalDataSourceProvider);
    return datasource.getHistory();
  }

  /// Adiciona um estabelecimento ao histórico
  Future<void> addToHistory(String establishmentId) async {
    final currentHistory = await future;
    final datasource = ref.read(searchHistoryLocalDataSourceProvider);

    // Remove o ID se já existir (para reposicioná-lo no topo)
    final newHistory =
        currentHistory.where((id) => id != establishmentId).toList()
          // Adiciona no início
          ..insert(0, establishmentId);

    // Mantém apenas os últimos 5
    final limitedHistory = newHistory.take(_maxHistorySize).toList();

    // Salva no datasource
    await datasource.saveHistory(limitedHistory);

    // Atualiza o estado
    state = AsyncValue.data(limitedHistory);
  }

  /// Remove um item do histórico
  Future<void> removeFromHistory(String establishmentId) async {
    final currentHistory = await future;
    final datasource = ref.read(searchHistoryLocalDataSourceProvider);

    final newHistory = currentHistory
        .where((id) => id != establishmentId)
        .toList();

    await datasource.saveHistory(newHistory);
    state = AsyncValue.data(newHistory);
  }

  /// Limpa todo o histórico
  Future<void> clearHistory() async {
    final datasource = ref.read(searchHistoryLocalDataSourceProvider);
    await datasource.clearHistory();
    state = const AsyncValue.data([]);
  }
}
