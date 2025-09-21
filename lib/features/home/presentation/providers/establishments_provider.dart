import 'package:barpass_app/features/home/di/home_dependencies.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'establishments_provider.g.dart';

// Provider principal para lista de estabelecimentos (afetado por categoria)
@riverpod
class EstablishmentsNotifier extends _$EstablishmentsNotifier {
  @override
  Future<List<Establishment>> build() async {
    final useCase = ref.read(getEstablishmentsUseCaseProvider);
    return useCase.all();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(getEstablishmentsUseCaseProvider);

    try {
      final establishments = await useCase.all();
      state = AsyncValue.data(establishments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> filterByCategory(String? categoryId) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(getEstablishmentsUseCaseProvider);

    try {
      final establishments = await useCase.call(categoryId: categoryId);
      state = AsyncValue.data(establishments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Provider para estabelecimentos em destaque (INDEPENDENTE de categoria)
// Carrega apenas uma vez e mantém os dados em cache
@Riverpod(keepAlive: true)
class FeaturedEstablishmentsNotifier extends _$FeaturedEstablishmentsNotifier {
  @override
  Future<List<Establishment>> build() async {
    final useCase = ref.read(getFeaturedEstablishmentsUseCaseProvider);
    return useCase.call();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(getFeaturedEstablishmentsUseCaseProvider);

    try {
      final establishments = await useCase.call();
      state = AsyncValue.data(establishments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Força o reload dos dados (útil para pull-to-refresh)
  Future<void> forceRefresh() async {
    // Invalida o provider para forçar uma nova chamada
    ref.invalidateSelf();
    await future;
  }
}

// Provider para o carrossel de estabelecimentos (INDEPENDENTE de categoria)
// Mostra uma seleção diferente dos featured, mas também não muda com categoria
@Riverpod(keepAlive: true)
class CarouselEstablishmentsNotifier extends _$CarouselEstablishmentsNotifier {
  @override
  Future<List<Establishment>> build() async {
    final useCase = ref.read(getEstablishmentsUseCaseProvider);
    // Busca todos os estabelecimentos e pega os melhores avaliados
    final allEstablishments = await useCase.all();

    // Retorna estabelecimentos com boa avaliação, ordenados por rating
    return allEstablishments.where((e) => e.rating >= 4.0).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(getEstablishmentsUseCaseProvider);

    try {
      final allEstablishments = await useCase.all();
      final carouselEstablishments =
          allEstablishments.where((e) => e.rating >= 4.0).toList()
            ..sort((a, b) => b.rating.compareTo(a.rating));

      state = AsyncValue.data(carouselEstablishments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Força o reload dos dados
  Future<void> forceRefresh() async {
    ref.invalidateSelf();
    await future;
  }
}

// Provider para busca de estabelecimentos
@riverpod
class SearchEstablishments extends _$SearchEstablishments {
  @override
  Future<List<Establishment>> build(String query) async {
    if (query.isEmpty) return [];

    // Implementar busca quando houver use case de search
    return [];
  }

  Future<void> search(String newQuery) async {
    if (newQuery.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    try {
      // Quando implementar SearchEstablishmentsUseCase:
      // final useCase = ref.read(searchEstablishmentsUseCaseProvider);
      // final results = await useCase.call(newQuery);
      // state = AsyncValue.data(results);

      // Por ora, filtrar da lista existente
      final allEstablishments = await ref.read(
        establishmentsProvider.future,
      );
      final filtered = allEstablishments
          .where((e) => e.matchesSearch(newQuery))
          .toList();
      state = AsyncValue.data(filtered);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
