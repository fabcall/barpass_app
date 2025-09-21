import 'package:barpass_app/features/home/domain/entities/category.dart';
import 'package:barpass_app/features/home/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final CategoriesRepository _repository;

  Future<List<Category>> call() async {
    final categories = await _repository.getCategories();

    // Garantir que "Todos" seja sempre o primeiro
    final allCategory = categories.where((c) => c.id == 'all').firstOrNull;
    final otherCategories = categories.where((c) => c.id != 'all').toList();

    if (allCategory != null) {
      return [allCategory, ...otherCategories];
    }

    return categories;
  }
}
