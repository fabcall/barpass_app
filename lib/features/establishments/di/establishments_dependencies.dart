import 'package:barpass_app/features/establishments/data/datasources/establishment_detail_local_datasource.dart';
import 'package:barpass_app/features/establishments/data/repositories/establishment_detail_repository_impl.dart';
import 'package:barpass_app/features/establishments/domain/repositories/establishment_detail_repository.dart';
import 'package:barpass_app/features/establishments/domain/use_cases/get_establishment_detail_use_case.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'establishments_dependencies.g.dart';

/// Dependências do módulo establishments
class EstablishmentsDependencies {
  EstablishmentsDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Datasources
    establishmentDetailLocalDataSourceProvider,

    // Repositories
    establishmentDetailRepositoryProvider,

    // Use Cases
    getEstablishmentDetailUseCaseProvider,
  ];
}

// === DATASOURCES ===
@Riverpod(keepAlive: true)
EstablishmentDetailLocalDataSource establishmentDetailLocalDataSource(Ref ref) {
  return EstablishmentDetailLocalDataSourceImpl();
}

// === REPOSITORIES ===
@Riverpod(keepAlive: true)
EstablishmentDetailRepository establishmentDetailRepository(Ref ref) {
  final datasource = ref.read(establishmentDetailLocalDataSourceProvider);
  return EstablishmentDetailRepositoryImpl(datasource);
}

// === USE CASES ===
@Riverpod(keepAlive: true)
GetEstablishmentDetailUseCase getEstablishmentDetailUseCase(Ref ref) {
  final repository = ref.read(establishmentDetailRepositoryProvider);
  return GetEstablishmentDetailUseCase(repository);
}
