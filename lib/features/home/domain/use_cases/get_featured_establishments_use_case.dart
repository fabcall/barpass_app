import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';

class GetFeaturedEstablishmentsUseCase {
  const GetFeaturedEstablishmentsUseCase(this._repository);

  final EstablishmentsRepository _repository;

  Future<List<Establishment>> call() async {
    final establishments = await _repository.getFeaturedEstablishments();

    // Aplicar regras de negócio específicas para destaques
    return establishments.where((establishment) {
      // Apenas estabelecimentos com boa avaliação e populares
      return establishment.hasGoodRating && establishment.isPopular;
    }).toList();
  }

  // Método para buscar destaques por categoria
  Future<List<Establishment>> byCategory(String categoryId) async {
    final allFeatured = await call();

    return allFeatured.where((establishment) {
      return establishment.matchesCategory(categoryId);
    }).toList();
  }
}
