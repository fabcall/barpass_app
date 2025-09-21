import 'package:barpass_app/features/home/domain/entities/category.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories();
}
