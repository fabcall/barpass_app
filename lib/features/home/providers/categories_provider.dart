import 'package:barpass_app/features/home/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Estado das categorias (versão simplificada para AsyncNotifier)
class CategoriesState {
  const CategoriesState({
    required this.categories,
    this.selectedCategoryId,
  });

  final List<Category> categories;
  final String? selectedCategoryId;

  CategoriesState copyWith({
    List<Category>? categories,
    String? selectedCategoryId,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  Category? get selectedCategory {
    if (selectedCategoryId == null) return null;
    try {
      return categories.firstWhere((cat) => cat.id == selectedCategoryId);
    } catch (e) {
      return null;
    }
  }

  bool isCategorySelected(String categoryId) {
    return selectedCategoryId == categoryId;
  }
}

/// AsyncNotifier para gerenciar categorias
class CategoriesAsyncNotifier extends AsyncNotifier<CategoriesState> {
  @override
  Future<CategoriesState> build() async {
    // Carrega as categorias
    final categories = await _loadCategories();

    return CategoriesState(
      categories: categories,
      selectedCategoryId: categories.isNotEmpty ? categories.first.id : null,
    );
  }

  Future<List<Category>> _loadCategories() async {
    // Simular delay de API
    await Future<void>.delayed(const Duration(seconds: 2));

    // Dados mock - substituir por chamada real da API
    return const [
      Category(id: '1', name: 'Todos', slug: 'all'),
      Category(id: '2', name: 'Bares', slug: 'bars'),
      Category(id: '3', name: 'Restaurantes', slug: 'restaurants'),
      Category(id: '4', name: 'Cafeterias', slug: 'cafes'),
      Category(id: '5', name: 'Pizzarias', slug: 'pizzerias'),
      Category(id: '6', name: 'Lanches', slug: 'snacks'),
      Category(id: '7', name: 'Japonês', slug: 'japanese'),
      Category(id: '8', name: 'Italiano', slug: 'italian'),
    ];
  }

  void selectCategory(String categoryId) {
    final currentState = state.value;
    if (currentState == null) return;

    if (currentState.categories.any((cat) => cat.id == categoryId)) {
      state = AsyncData(
        currentState.copyWith(selectedCategoryId: categoryId),
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
  }
}

/// Provider para categorias (versão AsyncNotifier)
final categoriesAsyncProvider =
    AsyncNotifierProvider<CategoriesAsyncNotifier, CategoriesState>(() {
      return CategoriesAsyncNotifier();
    });

/// Provider computado para facilitar o acesso aos dados
final categoriesProvider = Provider<AsyncValue<CategoriesState>>((ref) {
  return ref.watch(categoriesAsyncProvider);
});
