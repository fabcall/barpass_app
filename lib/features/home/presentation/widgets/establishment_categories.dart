import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/domain/entities/category.dart';
import 'package:barpass_app/features/home/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Delegate para header persistente de categorias
class EstablishmentCategoriesDelegate extends SliverPersistentHeaderDelegate {
  const EstablishmentCategoriesDelegate({
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = context.theme;
    final appBarTheme = theme.appBarTheme;

    // A lógica do Material e elevação é mantida
    return AnimatedContainer(
      duration: AppDuration.normal,
      curve: Curves.fastOutSlowIn,
      child: Material(
        elevation: overlapsContent
            ? appBarTheme.scrolledUnderElevation!
            : appBarTheme.elevation!,
        color: overlapsContent
            ? appBarTheme.backgroundColor
            : theme.scaffoldBackgroundColor,
        shadowColor: appBarTheme.shadowColor,
        child: const CategoriesList(),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant EstablishmentCategoriesDelegate oldDelegate) {
    return true;
  }
}

/// Widget principal da lista de categorias
class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  // A lista mock estática foi removida daqui.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return SizedBox(
      height: 100,
      child: categories.when(
        // --- SKELETON REATORADO ---
        loading: () {
          // 2. Cria uma lista de categorias mockadas na hora
          final mockCategories = List.generate(6, (_) => Category.skeleton());

          // 3. Envolve o widget REAL com o Skeletonizer
          return Skeletonizer(
            child: CategoryChipsList(
              categories: mockCategories,
              selectedCategoryId: null, // Sem seleção no skeleton
              onCategorySelected: (_) {}, // Sem ação no skeleton
            ),
          );
        },
        // --- FIM DA REATORAÇÃO ---
        error: (error, stackTrace) => CategoryErrorWidget(
          error: error.toString(),
          onRetry: () => ref.read(categoriesProvider.notifier).refresh(),
        ),
        data: (categoriesState) => CategoryChipsList(
          categories: categoriesState.categories,
          selectedCategoryId: categoriesState.selectedCategoryId,
          onCategorySelected: (categoryId) {
            ref.read(categoriesProvider.notifier).selectCategory(categoryId);
          },
        ),
      ),
    );
  }
}

/// Lista horizontal de categorias usando chips circulares
class CategoryChipsList extends StatefulWidget {
  const CategoryChipsList({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    super.key,
  });

  final List<Category> categories;
  final String? selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  @override
  State<CategoryChipsList> createState() => _CategoryChipsListState();
}

class _CategoryChipsListState extends State<CategoryChipsList> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _categoryKeys = {};

  @override
  void initState() {
    super.initState();
    // Cria keys para cada categoria
    for (final category in widget.categories) {
      _categoryKeys[category.id] = GlobalKey();
    }
  }

  @override
  void didUpdateWidget(CategoryChipsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Se a categoria selecionada mudou, faz o scroll
    if (oldWidget.selectedCategoryId != widget.selectedCategoryId &&
        widget.selectedCategoryId != null) {
      _scrollToCategory(widget.selectedCategoryId!);
    }
  }

  void _scrollToCategory(String categoryId) {
    final key = _categoryKeys[categoryId];
    if (key?.currentContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: AppDuration.normal,
          curve: Curves.easeInOut,
          alignment: 0.5, // Centraliza o item na tela
        );
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Desabilita o scroll durante o loading para evitar interações
    final isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;

    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: isSkeleton
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        final category = widget.categories[index];
        final isSelected = widget.selectedCategoryId == category.id;

        return Padding(
          key: _categoryKeys[category.id],
          padding: EdgeInsets.only(
            right: index < widget.categories.length - 1 ? AppSpacing.md : 0,
          ),
          child: CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () => widget.onCategorySelected(category.id),
          ),
        );
      },
    );
  }
}

/// Chip circular personalizado para categorias
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  // Mapeamento de ícones baseado no slug/id da categoria
  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'all':
        return Icons.restaurant;
      case 'hamburger':
        return Icons.lunch_dining;
      case 'pizza':
        return Icons.local_pizza;
      case 'sushi':
        return Icons.ramen_dining;
      case 'cafe':
        return Icons.local_cafe;
      case 'churrascaria':
        return Icons.outdoor_grill;
      case 'mexicana':
        return Icons.emoji_food_beverage;
      case 'bar':
        return Icons.local_bar;
      case 'vegetariana':
        return Icons.eco;
      default:
        return Icons.restaurant_menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getCategoryIcon(category.id);
    final isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;

    return GestureDetector(
      onTap: isSkeleton ? null : onTap, // Desabilita o tap no skeleton
      child: AnimatedContainer(
        duration: AppDuration.normal,
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container circular do ícone
            AnimatedContainer(
              duration: AppDuration.normal,
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow:
                    isSelected &&
                        !isSkeleton // Sem sombra no skeleton
                    ? [
                        BoxShadow(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Label da categoria
            AnimatedDefaultTextStyle(
              duration: AppDuration.normal,
              style: context.textTheme.labelSmall!.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
              ),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de erro para categorias
class CategoryErrorWidget extends StatelessWidget {
  const CategoryErrorWidget({
    required this.error,
    required this.onRetry,
    super.key,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: context.colorScheme.error,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Erro ao carregar categorias',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              error,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
