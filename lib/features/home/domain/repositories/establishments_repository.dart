import 'package:barpass_app/features/home/domain/entities/establishment.dart';

abstract class EstablishmentsRepository {
  Future<List<Establishment>> getEstablishments({String? categoryId});
  Future<List<Establishment>> getFeaturedEstablishments();
  Future<Establishment?> getEstablishmentById(String id);
  Future<List<Establishment>> searchEstablishments(String query);
}
