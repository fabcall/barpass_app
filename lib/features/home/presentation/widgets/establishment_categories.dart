import 'package:barpass_app/features/home/domain/entities/category.dart';
import 'package:barpass_app/features/home/presentation/providers/categories_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Delegate para header persistente de categorias
class EstablishmentCategoriesDelegate extends SliverPersistentHeaderDelegate {
  final ColorScheme colorScheme;

  const EstablishmentCategoriesDelegate({
    required this.colorScheme,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color:
            colorScheme.surface, // Usando o colorScheme passado como parâmetro
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: const CategoriesList(),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant EstablishmentCategoriesDelegate oldDelegate) {
    // Reconstrói se o colorScheme mudou
    return colorScheme != oldDelegate.colorScheme;
  }
}

// SOLUÇÃO 2: Usando ThemeData completo para comparação mais robusta
class EstablishmentCategoriesDelegateV2 extends SliverPersistentHeaderDelegate {
  final ThemeData theme;

  const EstablishmentCategoriesDelegateV2({
    required this.theme,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: const CategoriesList(),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant EstablishmentCategoriesDelegateV2 oldDelegate) {
    return theme != oldDelegate.theme;
  }
}

// SOLUÇÃO 3: Usando hash do tema para comparação mais eficiente
class EstablishmentCategoriesDelegateV3 extends SliverPersistentHeaderDelegate {
  final int themeHashCode;
  final ColorScheme colorScheme;

  const EstablishmentCategoriesDelegateV3({
    required this.themeHashCode,
    required this.colorScheme,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: const CategoriesList(),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant EstablishmentCategoriesDelegateV3 oldDelegate) {
    return themeHashCode != oldDelegate.themeHashCode;
  }
}

/// Widget principal da lista de categorias
class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  // Dados mock para o skeleton
  static const List<Category> _mockCategories = [
    Category(id: '1', name: 'Todos', slug: 'all'),
    Category(id: '2', name: 'Burger', slug: 'burger'),
    Category(id: '3', name: 'Pizza', slug: 'pizza'),
    Category(id: '4', name: 'Sushi', slug: 'sushi'),
    Category(id: '5', name: 'Café', slug: 'cafe'),
    Category(id: '6', name: 'Bar', slug: 'bar'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return SizedBox(
      height: 100,
      child: categories.when(
        loading: () => Skeletonizer(
          child: CategoryChipsList(
            categories: _mockCategories,
            selectedCategoryId: _mockCategories.first.id,
            onCategorySelected: (_) {},
          ),
        ),
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
class CategoryChipsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategoryId == category.id;

        return Padding(
          padding: EdgeInsets.only(
            right: index < categories.length - 1 ? 12 : 0,
          ),
          child: CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.id),
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
    final theme = Theme.of(context);
    final icon = _getCategoryIcon(category.id);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container circular do ícone
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),

            const SizedBox(height: 8),

            // Label da categoria
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: context.colorScheme.error,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Erro ao carregar categorias',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              error,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
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
