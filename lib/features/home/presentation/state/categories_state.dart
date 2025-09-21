import 'package:barpass_app/features/home/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_state.freezed.dart';

@freezed
sealed class CategoriesState with _$CategoriesState {
  const CategoriesState._();

  const factory CategoriesState({
    @Default([]) List<Category> categories,
    String? selectedCategoryId,
    @Default(false) bool isLoading,
    String? error,
  }) = _CategoriesState;

  bool get hasError => error != null;
  bool get hasCategories => categories.isNotEmpty;

  Category? get selectedCategory {
    if (selectedCategoryId == null) return null;
    try {
      return categories.firstWhere((cat) => cat.id == selectedCategoryId);
    } catch (e) {
      return null;
    }
  }
}
