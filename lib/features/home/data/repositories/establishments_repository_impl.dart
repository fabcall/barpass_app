import 'package:barpass_app/features/home/data/datasources/establishments_datasource.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/domain/repositories/establishments_repository.dart';

class EstablishmentsRepositoryImpl implements EstablishmentsRepository {
  const EstablishmentsRepositoryImpl(this._datasource);

  final EstablishmentsDatasource _datasource;

  @override
  Future<List<Establishment>> getEstablishments({String? categoryId}) async {
    final models = await _datasource.getEstablishments(categoryId: categoryId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Establishment>> getFeaturedEstablishments() async {
    final models = await _datasource.getFeaturedEstablishments();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Establishment?> getEstablishmentById(String id) async {
    final model = await _datasource.getEstablishmentById(id);
    return model?.toEntity();
  }

  @override
  Future<List<Establishment>> searchEstablishments(String query) async {
    final models = await _datasource.searchEstablishments(query);
    return models.map((model) => model.toEntity()).toList();
  }
}
