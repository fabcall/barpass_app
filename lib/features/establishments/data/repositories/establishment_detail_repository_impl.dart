import 'package:barpass_app/features/establishments/data/datasources/establishment_detail_local_datasource.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/features/establishments/domain/repositories/establishment_detail_repository.dart';

class EstablishmentDetailRepositoryImpl
    implements EstablishmentDetailRepository {
  const EstablishmentDetailRepositoryImpl(this._datasource);

  final EstablishmentDetailLocalDataSource _datasource;

  @override
  Future<EstablishmentDetail?> getEstablishmentDetail(String id) async {
    final model = await _datasource.getEstablishmentDetail(id);
    return model?.toEntity();
  }
}
