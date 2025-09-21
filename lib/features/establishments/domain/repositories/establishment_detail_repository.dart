import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';

// Interface do Repository (Domain Layer)
abstract class EstablishmentDetailRepository {
  Future<EstablishmentDetail?> getEstablishmentDetail(String id);
}
