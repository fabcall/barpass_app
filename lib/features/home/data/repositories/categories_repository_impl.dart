import 'package:barpass_app/features/home/data/datasources/categories_datasource.dart';
import 'package:barpass_app/features/home/domain/entities/category.dart';
import 'package:barpass_app/features/home/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  const CategoriesRepositoryImpl(this._datasource);

  final CategoriesDatasource _datasource;

  @override
  Future<List<Category>> getCategories() {
    return _datasource.getCategories();
  }
}
