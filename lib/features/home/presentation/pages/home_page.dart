import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_categories.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_list_card.dart';
import 'package:barpass_app/features/home/presentation/widgets/featured_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:barpass_app/features/home/presentation/widgets/home_search_bar.dart';
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

class HomePageBody extends ConsumerStatefulWidget {
  const HomePageBody({super.key});

  @override
  ConsumerState<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends ConsumerState<HomePageBody>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _titleAnimation;
  late Animation<double> _searchAnimation;

  bool _showSearchInAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _titleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _searchAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Altura aproximada da SearchBar + padding
    const searchBarHeight = kToolbarHeight + 16;

    // Se scrollamos além da SearchBar, mostra pesquisa na AppBar
    final shouldShowSearchInAppBar = _scrollController.offset > searchBarHeight;

    if (shouldShowSearchInAppBar != _showSearchInAppBar) {
      setState(() {
        _showSearchInAppBar = shouldShowSearchInAppBar;
      });

      if (_showSearchInAppBar) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final establishmentsState = ref.watch(establishmentsProvider);
    final featuredEstablishmentsState = ref.watch(
      featuredEstablishmentsProvider,
    );
    final carouselEstablishmentsState = ref.watch(
      carouselEstablishmentsProvider,
    );

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // AppBar com título/pesquisa animados
        HomeAppBar(
          titleAnimation: _titleAnimation,
          searchAnimation: _searchAnimation,
        ),

        // Barra de pesquisa flutuante
        const HomeSearchBar(),

        // Featured Carousel
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

        // Carousel de estabelecimentos
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

        // Header de categorias
        SliverPersistentHeader(
          pinned: true,
          delegate: EstablishmentCategoriesDelegate(
            colorScheme: context.colorScheme,
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
        SliverToBoxAdapter(
          child: Gap(
            MediaQuery.of(context).padding.bottom,
          ),
        ),
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
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
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
      height: 320,
      child: Skeletonizer(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              width: 250,
              height: 320,
              margin: EdgeInsets.only(right: index < 2 ? 16 : 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const Spacer(),
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
          childCount: 6,
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
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: 16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 13,
                        width: 200,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(height: 8),
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
