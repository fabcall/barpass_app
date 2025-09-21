import 'package:barpass_app/features/home/models/category.dart';
import 'package:barpass_app/features/home/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Delegate para header persistente de categorias
class EstablishmentCategoriesDelegate extends SliverPersistentHeaderDelegate {
  const EstablishmentCategoriesDelegate({
    this.topPadding = 0.0,
  });

  final double topPadding;

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
        color: ColorScheme.of(context).surface,
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
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

/// Widget principal da lista de categorias (versão para AsyncNotifier)
class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  // Dados mock para o skeleton
  static const List<Category> _mockCategories = [
    Category(id: '1', name: 'Todos os tipos', slug: 'all'),
    Category(id: '2', name: 'Restaurantes', slug: 'restaurants'),
    Category(id: '3', name: 'Bares e Pubs', slug: 'bars'),
    Category(id: '4', name: 'Cafeterias', slug: 'cafes'),
    Category(id: '5', name: 'Pizzarias', slug: 'pizzerias'),
    Category(id: '6', name: 'Comida Japonesa', slug: 'japanese'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesAsyncProvider);

    return SizedBox(
      height: kToolbarHeight,
      child: categoriesAsync.when(
        loading: () => Skeletonizer(
          child: CategoryChipsList(
            categories: _mockCategories,
            selectedCategoryId: _mockCategories.first.id,
            onCategorySelected: (_) {}, // Sem ação durante loading
          ),
        ),
        error: (error, stackTrace) => CategoryErrorWidget(
          error: error.toString(),
          onRetry: () => ref.read(categoriesAsyncProvider.notifier).refresh(),
        ),
        data: (categoriesState) => CategoryChipsList(
          categories: categoriesState.categories,
          selectedCategoryId: categoriesState.selectedCategoryId,
          onCategorySelected: (categoryId) {
            ref
                .read(categoriesAsyncProvider.notifier)
                .selectCategory(categoryId);
          },
        ),
      ),
    );
  }
}

/// Lista horizontal de categorias usando FilterChips
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
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategoryId == category.id;

        return Padding(
          padding: EdgeInsets.only(
            right: index < categories.length - 1 ? 8 : 0,
          ),
          child: CategoryFilterChip(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.id),
          ),
        );
      },
    );
  }
}

/// FilterChip personalizado para categorias
class CategoryFilterChip extends StatelessWidget {
  const CategoryFilterChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(category.name),
      selected: isSelected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      selectedColor: theme.colorScheme.primary,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isSelected ? theme.colorScheme.primary : Colors.grey.shade300,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade400,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Erro ao carregar',
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onRetry,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Tentar novamente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
