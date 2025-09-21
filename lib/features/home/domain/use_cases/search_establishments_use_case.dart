import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';

class SearchEstablishmentsUseCase {
  const SearchEstablishmentsUseCase(this._repository);

  final EstablishmentsRepository _repository;

  Future<List<Establishment>> call(String query) async {
    // Validar query
    if (query.isEmpty) {
      return [];
    }

    if (query.length < 2) {
      throw ArgumentError('Query must have at least 2 characters');
    }

    final results = await _repository.searchEstablishments(query.trim());

    // Aplicar filtros adicionais de negócio
    return results.where((establishment) {
      return establishment.matchesSearch(query);
    }).toList();
  }

  // Método para busca com filtros avançados
  Future<List<Establishment>> searchWithFilters({
    required String query,
    double? minRating,
    List<String>? categories,
    String? maxDistance,
  }) async {
    final results = await call(query);

    var filtered = results;

    // Aplicar filtro de rating mínimo
    if (minRating != null) {
      filtered = filtered.where((e) => e.rating >= minRating).toList();
    }

    // Aplicar filtro de categorias
    if (categories != null && categories.isNotEmpty) {
      filtered = filtered.where((e) {
        return categories.any((category) => e.categories.contains(category));
      }).toList();
    }

    // Filtro de distância seria implementado com lógica mais complexa
    // Por ora, apenas simulamos
    if (maxDistance != null) {
      // Implementar lógica de distância quando necessário
    }

    return filtered;
  }
}
