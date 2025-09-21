import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/features/establishments/domain/repositories/establishment_detail_repository.dart';

class GetEstablishmentDetailUseCase {
  const GetEstablishmentDetailUseCase(this._repository);

  final EstablishmentDetailRepository _repository;

  Future<EstablishmentDetail?> call(String id) async {
    // Validação
    if (id.isEmpty) {
      throw ArgumentError('Establishment ID cannot be empty');
    }

    final establishment = await _repository.getEstablishmentDetail(id);

    // Poderia adicionar mais lógica de negócio aqui
    // Por exemplo, verificar se o estabelecimento está ativo,
    // aplicar filtros baseados em preferências do usuário, etc.

    return establishment;
  }

  // Método auxiliar para verificar se existe
  Future<bool> exists(String id) async {
    final establishment = await call(id);
    return establishment != null;
  }
}
