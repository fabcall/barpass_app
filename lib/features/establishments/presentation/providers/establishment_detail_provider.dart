import 'package:barpass_app/features/establishments/di/establishments_dependencies.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'establishment_detail_provider.g.dart';

/// Provider para carregar detalhes de um estabelecimento específico
///
/// Usa o padrão Family do Riverpod para criar um provider único
/// para cada establishmentId diferente
@riverpod
class EstablishmentDetailNotifier extends _$EstablishmentDetailNotifier {
  @override
  Future<EstablishmentDetail?> build(String establishmentId) async {
    final useCase = ref.read(getEstablishmentDetailUseCaseProvider);
    return useCase.call(establishmentId);
  }

  /// Recarrega os dados do estabelecimento
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(getEstablishmentDetailUseCaseProvider);

    try {
      final establishment = await useCase.call(establishmentId);
      state = AsyncValue.data(establishment);
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Marca estabelecimento como favorito (simulado)
  Future<void> toggleFavorite() async {
    final currentState = await future;
    if (currentState == null) return;

    // Aqui você implementaria a lógica real de favoritar
    // Por ora, apenas simula o comportamento
    await Future<void>.delayed(const Duration(milliseconds: 300));

    // Não altera o estado pois isso seria gerenciado por outro provider
    // (FavoritesProvider, por exemplo)
  }
}

/// Provider auxiliar para verificar se um estabelecimento existe
@riverpod
Future<bool> establishmentExists(Ref ref, String establishmentId) async {
  final useCase = ref.read(getEstablishmentDetailUseCaseProvider);
  return useCase.exists(establishmentId);
}
