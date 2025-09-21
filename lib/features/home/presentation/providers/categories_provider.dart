import 'package:barpass_app/features/home/di/home_dependencies.dart';
import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/state/categories_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_provider.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<CategoriesState> build() async {
    final useCase = ref.read(getCategoriesUseCaseProvider);

    try {
      final categories = await useCase.call();
      return CategoriesState(
        categories: categories,
        selectedCategoryId: categories.isNotEmpty ? categories.first.id : null,
      );
    } on Exception catch (error) {
      return CategoriesState(error: error.toString());
    }
  }

  Future<void> selectCategory(String categoryId) async {
    final currentState = await future;

    // Atualizar estado local
    state = AsyncValue.data(
      currentState.copyWith(selectedCategoryId: categoryId),
    );

    // Notificar o provider de estabelecimentos para filtrar
    ref
        .read(establishmentsProvider.notifier)
        .filterByCategory(categoryId == 'all' ? null : categoryId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}
