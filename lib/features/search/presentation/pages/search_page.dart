import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/features/home/di/home_dependencies.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_list_card.dart';
import 'package:barpass_app/features/search/presentation/providers/search_history_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

/// Página de pesquisa de estabelecimentos
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _currentQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Foca automaticamente no campo de busca ao abrir a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _currentQuery = query.trim();
      _isSearching = _currentQuery.isNotEmpty;
    });

    if (_currentQuery.isNotEmpty && _currentQuery.length >= 2) {
      // Trigger search
      ref
          .read(searchEstablishmentsProvider(_currentQuery).notifier)
          .search(_currentQuery);
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    setState(() {
      _currentQuery = '';
      _isSearching = false;
    });
    _searchFocusNode.requestFocus();
  }

  void _navigateToEstablishmentDetails(String establishmentId) {
    // Adiciona ao histórico antes de navegar
    ref.read(searchHistoryProvider.notifier).addToHistory(establishmentId);
    context.navigate.establishment.pushDetails(establishmentId);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = _isSearching && _currentQuery.length >= 2
        ? ref.watch(searchEstablishmentsProvider(_currentQuery))
        : const AsyncValue<List<Establishment>>.data([]);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header com campo de busca
            _buildSearchHeader(context),

            // Divisor
            Divider(
              height: 1,
              color: context.colorScheme.outlineVariant,
            ),

            // Conteúdo (resultados ou estado inicial)
            Expanded(
              child: _isSearching
                  ? _buildSearchResults(context, searchResults)
                  : _buildInitialState(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Header com campo de busca e botão voltar
  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Busque por bares, restaurantes...',
            prefixIcon: const BackButton(),
            suffixIcon: _currentQuery.isNotEmpty
                ? IconButton(
                    onPressed: _onClearSearch,
                    icon: const Icon(Icons.clear),
                    tooltip: 'Limpar',
                  )
                : const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(
                  alpha: 0.2,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(
                  alpha: 0.2,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }

  /// Estado inicial (quando não está buscando)
  Widget _buildInitialState(BuildContext context) {
    final historyState = ref.watch(searchHistoryProvider);

    return historyState.when(
      data: (historyIds) {
        if (historyIds.isEmpty) {
          return _buildEmptyHistoryState(context);
        }
        return _buildHistoryState(context, historyIds);
      },
      loading: () => _buildEmptyHistoryState(context),
      error: (_, _) => _buildEmptyHistoryState(context),
    );
  }

  /// Estado quando não há histórico
  Widget _buildEmptyHistoryState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: context.colorScheme.primary.withValues(alpha: 0.3),
            ),
            const Gap(24),
            Text(
              'Encontre estabelecimentos',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Text(
              'Busque por bares, restaurantes, cafés e muito mais',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            // Sugestões de busca
            _buildSearchSuggestions(context),
          ],
        ),
      ),
    );
  }

  /// Estado com histórico de pesquisas
  Widget _buildHistoryState(BuildContext context, List<String> historyIds) {
    return CustomScrollView(
      slivers: [
        // Header do histórico
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Visitados recentemente',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () => _showClearHistoryDialog(context),
                  child: const Text('Limpar'),
                ),
              ],
            ),
          ),
        ),

        // Lista de histórico
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final establishmentId = historyIds[index];
                return _buildHistoryItem(context, establishmentId);
              },
              childCount: historyIds.length,
            ),
          ),
        ),

        // Sugestões de busca após o histórico
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Divider(),
                const Gap(24),
                Text(
                  'Ou busque por',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(16),
                _buildSearchSuggestions(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Item do histórico
  Widget _buildHistoryItem(BuildContext context, String establishmentId) {
    // Busca os dados do estabelecimento
    final establishmentsRepository = ref.read(establishmentsRepositoryProvider);

    return FutureBuilder<Establishment?>(
      future: establishmentsRepository.getEstablishmentById(establishmentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          // Se não encontrou o estabelecimento, não mostra nada
          return const SizedBox.shrink();
        }

        final establishment = snapshot.data!;

        return Dismissible(
          key: Key('history_$establishmentId'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            ref
                .read(searchHistoryProvider.notifier)
                .removeFromHistory(
                  establishmentId,
                );
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            color: context.colorScheme.error,
            child: Icon(
              Icons.delete_outline,
              color: context.colorScheme.onError,
            ),
          ),
          child: Column(
            children: [
              EstablishmentListCard(
                establishment: establishment,
                onTap: () => _navigateToEstablishmentDetails(establishmentId),
              ),
              const Divider(height: 1),
            ],
          ),
        );
      },
    );
  }

  /// Dialog para confirmar limpeza do histórico
  Future<void> _showClearHistoryDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar histórico'),
        content: const Text(
          'Deseja remover todos os estabelecimentos do histórico de pesquisa?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await ref.read(searchHistoryProvider.notifier).clearHistory();
    }
  }

  /// Sugestões de busca rápida
  Widget _buildSearchSuggestions(BuildContext context) {
    final suggestions = [
      'Pizza',
      'Hamburger',
      'Sushi',
      'Café',
      'Bar',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: suggestions.map((suggestion) {
        return ActionChip(
          label: Text(suggestion),
          onPressed: () {
            _searchController.text = suggestion;
            _onSearchChanged(suggestion);
          },
          backgroundColor: context.colorScheme.surfaceContainerHighest,
          side: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
        );
      }).toList(),
    );
  }

  /// Resultados da busca
  Widget _buildSearchResults(
    BuildContext context,
    AsyncValue<List<Establishment>> searchResults,
  ) {
    return searchResults.when(
      data: (establishments) {
        if (_currentQuery.length < 2) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Digite pelo menos 2 caracteres para buscar',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (establishments.isEmpty) {
          return EmptyStateWidget(
            title: 'Nenhum resultado encontrado',
            description: 'Tente buscar por outro termo',
            icon: Icons.search_off,
            action: TextButton(
              onPressed: _onClearSearch,
              child: const Text('Limpar busca'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com contagem de resultados
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${establishments.length} ${establishments.length == 1 ? 'resultado encontrado' : 'resultados encontrados'}',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Lista de resultados
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: establishments.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: context.colorScheme.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final establishment = establishments[index];
                  return EstablishmentListCard(
                    establishment: establishment,
                    onTap: () =>
                        _navigateToEstablishmentDetails(establishment.id),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const Gap(16),
            Text(
              'Buscando...',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.colorScheme.error,
              ),
              const Gap(16),
              Text(
                'Erro ao buscar',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              Text(
                error.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(24),
              FilledButton.tonal(
                onPressed: () => _onSearchChanged(_currentQuery),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
