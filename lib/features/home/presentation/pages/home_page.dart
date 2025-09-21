import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomePageBody();
  }
}

class HomePageBody extends ConsumerWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final establishmentsState = ref.watch(establishmentsNotifierProvider);
    final featuredEstablishmentsState = ref.watch(
      featuredEstablishmentsProvider,
    );

    return CustomScrollView(
      slivers: [
        const HomeAppBar(),

        // Featured Carousel
        SliverToBoxAdapter(
          child: featuredEstablishmentsState.when(
            data: (establishments) => FeaturedCarousel(
              establishments: establishments,
            ),
            loading: () => const SizedBox(
              height: 240,
              child: LoadingWidget(message: 'Carregando destaques...'),
            ),
            error: (error, _) => SizedBox(
              height: 240,
              child: ErrorDisplayWidget(
                message: 'Erro ao carregar destaques',
                onRetry: () => ref.invalidate(featuredEstablishmentsProvider),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(24)),

        // Título da seção
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Estabelecimentos em destaque',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(16)),

        // Carousel de estabelecimentos
        SliverToBoxAdapter(
          child: establishmentsState.when(
            data: (establishments) {
              if (establishments.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: EmptyStateWidget(
                    title: 'Nenhum estabelecimento encontrado',
                    description:
                        'Tente ajustar os filtros ou fazer uma nova busca',
                    icon: Icons.restaurant_outlined,
                  ),
                );
              }

              return EstablishmentCarousel(
                establishments: establishments.take(10).toList(),
              );
            },
            loading: () => const SizedBox(
              height: 300,
              child: LoadingWidget(message: 'Carregando estabelecimentos...'),
            ),
            error: (error, _) => SizedBox(
              height: 200,
              child: ErrorDisplayWidget(
                message: 'Erro ao carregar estabelecimentos',
                onRetry: () =>
                    ref.read(establishmentsNotifierProvider.notifier).refresh(),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(16)),

        // Header persistente de categorias
        SliverPersistentHeader(
          pinned: true,
          delegate: EstablishmentCategoriesDelegate(
            topPadding: context.viewPadding.top,
          ),
        ),

        const SliverToBoxAdapter(child: Gap(8)),

        // Lista de estabelecimentos
        establishmentsState.when(
          data: (establishments) {
            if (establishments.isEmpty) {
              return const SliverToBoxAdapter(
                child: EmptyStateWidget(
                  title: 'Nenhum estabelecimento encontrado',
                  description:
                      'Tente uma categoria diferente ou faça uma busca',
                  icon: Icons.search_off,
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= establishments.length) return null;

                    final establishment = establishments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: EstablishmentListCard(
                        establishment: establishment,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
            child: LoadingWidget(message: 'Carregando...'),
          ),
          error: (error, _) => SliverToBoxAdapter(
            child: ErrorDisplayWidget(
              message: 'Erro ao carregar estabelecimentos',
              onRetry: () =>
                  ref.read(establishmentsNotifierProvider.notifier).refresh(),
            ),
          ),
        ),

        // Espaçamento final
        const SliverToBoxAdapter(child: Gap(256)),
      ],
    );
  }
}
