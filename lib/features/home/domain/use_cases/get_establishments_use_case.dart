import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';

class GetEstablishmentsUseCase {
  const GetEstablishmentsUseCase(this._repository);

  final EstablishmentsRepository _repository;

  Future<List<Establishment>> call({String? categoryId}) async {
    return _repository.getEstablishments(categoryId: categoryId);
  }

  // Método auxiliar para buscar por categoria específica
  Future<List<Establishment>> byCategory(String categoryId) async {
    if (categoryId.isEmpty) {
      throw ArgumentError('Category ID cannot be empty');
    }

    return _repository.getEstablishments(categoryId: categoryId);
  }

  // Método auxiliar para buscar todos os estabelecimentos
  Future<List<Establishment>> all() async {
    return _repository.getEstablishments();
  }
}
