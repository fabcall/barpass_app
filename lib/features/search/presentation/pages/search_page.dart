import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/di/home_dependencies.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_list_card.dart';
import 'package:barpass_app/features/search/presentation/providers/search_history_provider.dart';
import 'package:barpass_app/shared/widgets/feedback/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
            _buildSearchHeader(context),
            Divider(
              height: 1,
              color: context.colorScheme.outlineVariant,
            ),
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

  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
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
              borderRadius: BorderRadius.circular(AppRadius.xl),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerHighest,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }

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
      error: (_, __) => _buildEmptyHistoryState(context),
    );
  }

  Widget _buildEmptyHistoryState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
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
            SizedBox(height: AppSpacing.md),
            Text(
              'Busque por bares, restaurantes, cafés e muito mais',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xl),
            _buildSearchSuggestions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryState(BuildContext context, List<String> historyIds) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                const Divider(),
                SizedBox(height: AppSpacing.lg),
                Text(
                  'Ou busque por',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                _buildSearchSuggestions(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, String establishmentId) {
    final establishmentsRepository = ref.read(establishmentsRepositoryProvider);

    return FutureBuilder<Establishment?>(
      future: establishmentsRepository.getEstablishmentById(establishmentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
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
            padding: EdgeInsets.only(right: AppSpacing.md),
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

  Widget _buildSearchSuggestions(BuildContext context) {
    final suggestions = ['Pizza', 'Hamburger', 'Sushi', 'Café', 'Bar'];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
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

  Widget _buildSearchResults(
    BuildContext context,
    AsyncValue<List<Establishment>> searchResults,
  ) {
    return searchResults.when(
      data: (establishments) {
        if (_currentQuery.length < 2) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
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
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                '${establishments.length} ${establishments.length == 1 ? 'resultado encontrado' : 'resultados encontrados'}',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                itemCount: establishments.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: context.colorScheme.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                  indent: AppSpacing.md,
                  endIndent: AppSpacing.md,
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
            SizedBox(height: AppSpacing.md),
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
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.colorScheme.error,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'Erro ao buscar',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                error.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.lg),
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
