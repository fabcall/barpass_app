import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class EstablishmentsNotifier extends _$EstablishmentsNotifier {
  @override
  Future<List<Establishment>> build() {
    final useCase = ref.read(getEstablishmentsUseCaseProvider);
    return useCase();
  }
}
