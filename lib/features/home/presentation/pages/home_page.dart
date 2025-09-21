import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_categories.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_list_card.dart';
import 'package:barpass_app/features/home/presentation/widgets/featured_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/common/empty_state_widget.dart';
import 'package:barpass_app/shared/widgets/common/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final establishmentsState = ref.watch(establishmentsProvider);
    final featuredEstablishmentsState = ref.watch(
      featuredEstablishmentsProvider,
    );
    final carouselEstablishmentsState = ref.watch(
      carouselEstablishmentsProvider,
    );

    return CustomScrollView(
      slivers: [
        const HomeAppBar(),

        // Featured Carousel - Não afetado pela categoria
        SliverToBoxAdapter(
          child: featuredEstablishmentsState.when(
            data: (establishments) => FeaturedCarousel(
              establishments: establishments,
            ),
            loading: _buildFeaturedCarouselSkeleton,
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
                'Mais estabelecimentos em destaque',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(16)),

        // Carousel de estabelecimentos (INDEPENDENTE da categoria - usa provider específico)
        SliverToBoxAdapter(
          child: carouselEstablishmentsState.when(
            data: (establishments) {
              if (establishments.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: EmptyStateWidget(
                    title: 'Nenhum estabelecimento encontrado',
                    description:
                        'Não há estabelecimentos disponíveis no momento',
                    icon: Icons.restaurant_outlined,
                  ),
                );
              }

              return EstablishmentCarousel(
                establishments: establishments.take(10).toList(),
              );
            },
            loading: _buildEstablishmentCarouselSkeleton,
            error: (error, _) => SizedBox(
              height: 200,
              child: ErrorDisplayWidget(
                message: 'Erro ao carregar estabelecimentos em destaque',
                onRetry: () =>
                    ref.read(carouselEstablishmentsProvider.notifier).refresh(),
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

        // Título da lista filtrada
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Todos os estabelecimentos',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(16)),

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
          loading: _buildEstablishmentListSkeleton,
          error: (error, _) => SliverToBoxAdapter(
            child: ErrorDisplayWidget(
              message: 'Erro ao carregar estabelecimentos',
              onRetry: () =>
                  ref.read(establishmentsProvider.notifier).refresh(),
            ),
          ),
        ),

        // Espaçamento final
        const SliverToBoxAdapter(child: Gap(256)),
      ],
    );
  }

  /// Skeleton para o carrossel em destaque
  Widget _buildFeaturedCarouselSkeleton() {
    return SizedBox(
      height: 240,
      child: Skeletonizer(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Simula conteúdo do carrossel
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    // Logo fake
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 22,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 14,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 16,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Badge fake
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  height: 24,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Skeleton para o carrossel de estabelecimentos
  Widget _buildEstablishmentCarouselSkeleton() {
    return SizedBox(
      height: 320, // Mesma altura dos cards reais
      child: Skeletonizer(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3, // Mostra 3 cards skeleton
          itemBuilder: (context, index) {
            return Container(
              width: 250,
              height: 320, // Altura fixa igual aos cards reais
              margin: EdgeInsets.only(right: index < 2 ? 16 : 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagem fake (AspectRatio 1.5 como no card real)
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  // Conteúdo fake
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header com logo e nome (mesma altura do real)
                          SizedBox(
                            height: 32,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    height: 14,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Endereço fake (mesma altura do real)
                          SizedBox(
                            height: 32,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 12,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 12,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer para empurrar rating para baixo
                          const Spacer(),
                          // Rating fake (sempre no bottom)
                          Row(
                            children: [
                              Container(
                                height: 12,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 12,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Skeleton para a lista de estabelecimentos
  Widget _buildEstablishmentListSkeleton() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Skeletonizer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildEstablishmentListCardSkeleton(),
              ),
            );
          },
          childCount: 6, // Mostra 6 cards skeleton
        ),
      ),
    );
  }

  /// Card skeleton para lista de estabelecimentos
  Widget _buildEstablishmentListCardSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo circular fake
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: 16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),

              // Conteúdo fake
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 80,
                  ), // Espaço para badge
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome fake
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Endereço fake
                      Container(
                        height: 13,
                        width: 200,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Rating e distância fake
                      Row(
                        children: [
                          Container(
                            height: 13,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 12,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Badge fake
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 24,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
