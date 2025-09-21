import 'package:barpass_app/features/home/data/datasources/categories_datasource.dart';
import 'package:barpass_app/features/home/data/datasources/establishments_datasource.dart';
import 'package:barpass_app/features/home/data/repositories/categories_repository_impl.dart';
import 'package:barpass_app/features/home/data/repositories/establishments_repository_impl.dart';
import 'package:barpass_app/features/home/domain/repositories/categories_repository.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';
import 'package:barpass_app/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:barpass_app/features/home/domain/use_cases/get_establishments_use_case.dart';
import 'package:barpass_app/features/home/domain/use_cases/get_featured_establishments_use_case.dart';
import 'package:barpass_app/features/home/domain/use_cases/search_establishments_use_case.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_dependencies.g.dart';

/// Dependências do módulo home
class HomeDependencies {
  HomeDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Datasources
    establishmentsDatasourceProvider,
    categoriesDatasourceProvider,

    // Repositories
    establishmentsRepositoryProvider,
    categoriesRepositoryProvider,

    // Use Cases
    getEstablishmentsUseCaseProvider,
    getFeaturedEstablishmentsUseCaseProvider,
    searchEstablishmentsUseCaseProvider,
    getCategoriesUseCaseProvider,
  ];
}

// === DATASOURCES ===
@Riverpod(keepAlive: true)
EstablishmentsDatasource establishmentsDatasource(Ref ref) {
  return EstablishmentsDatasourceImpl();
}

@Riverpod(keepAlive: true)
CategoriesDatasource categoriesDatasource(Ref ref) {
  return CategoriesDatasourceImpl();
}

// === REPOSITORIES ===
@Riverpod(keepAlive: true)
EstablishmentsRepository establishmentsRepository(Ref ref) {
  final datasource = ref.read(establishmentsDatasourceProvider);
  return EstablishmentsRepositoryImpl(datasource);
}

@Riverpod(keepAlive: true)
CategoriesRepository categoriesRepository(Ref ref) {
  final datasource = ref.read(categoriesDatasourceProvider);
  return CategoriesRepositoryImpl(datasource);
}

// === USE CASES ===
@Riverpod(keepAlive: true)
GetEstablishmentsUseCase getEstablishmentsUseCase(Ref ref) {
  final repository = ref.read(establishmentsRepositoryProvider);
  return GetEstablishmentsUseCase(repository);
}

@Riverpod(keepAlive: true)
GetFeaturedEstablishmentsUseCase getFeaturedEstablishmentsUseCase(Ref ref) {
  final repository = ref.read(establishmentsRepositoryProvider);
  return GetFeaturedEstablishmentsUseCase(repository);
}

@Riverpod(keepAlive: true)
SearchEstablishmentsUseCase searchEstablishmentsUseCase(Ref ref) {
  final repository = ref.read(establishmentsRepositoryProvider);
  return SearchEstablishmentsUseCase(repository);
}

@Riverpod(keepAlive: true)
GetCategoriesUseCase getCategoriesUseCase(Ref ref) {
  final repository = ref.read(categoriesRepositoryProvider);
  return GetCategoriesUseCase(repository);
}
