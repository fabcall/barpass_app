import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';

class GetEstablishmentsUseCase {
  GetEstablishmentsUseCase({required this.repository});

  final EstablishmentsRepository repository;

  Future<List<Establishment>> call(String? categoryId) {
    return repository.getEstablishments(categoryId: categoryId);
  }
}
