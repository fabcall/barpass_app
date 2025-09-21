import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/features/home/presentation/providers/establishments_provider.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_categories.dart';
import 'package:barpass_app/features/home/presentation/widgets/establishment_list_card.dart';
import 'package:barpass_app/features/home/presentation/widgets/featured_carousel.dart';
import 'package:barpass_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:barpass_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:barpass_app/shared/widgets/feedback/empty_state_widget.dart';
import 'package:barpass_app/shared/widgets/feedback/error_widget.dart';
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
  bool _isRefreshing = false;

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
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _searchAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
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
    const searchBarHeight = kToolbarHeight + 16;
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

  void _navigateToEstablishmentDetails(String establishmentId) {
    context.navigate.establishment.pushDetails(establishmentId);
  }

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await Future.wait([
        ref.read(establishmentsProvider.notifier).refresh(),
        Future(() => ref.invalidate(featuredEstablishmentsProvider)),
        ref.read(carouselEstablishmentsProvider.notifier).refresh(),
      ]);
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } on Exception catch (_) {
      ref
        ..invalidate(establishmentsProvider)
        ..invalidate(featuredEstablishmentsProvider)
        ..invalidate(carouselEstablishmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Erro ao atualizar dados. Tente novamente.'),
            backgroundColor: context.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
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

    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 80,
      backgroundColor: context.colorScheme.surface,
      color: context.colorScheme.primary,
      edgeOffset: 20,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          HomeAppBar(
            titleAnimation: _titleAnimation,
            searchAnimation: _searchAnimation,
          ),
          const HomeSearchBar(),

          // Featured Carousel
          SliverToBoxAdapter(
            child: featuredEstablishmentsState.when(
              data: (establishments) => FeaturedCarousel(
                establishments: establishments,
                onEstablishmentTap: _navigateToEstablishmentDetails,
              ),
              loading: () {
                final mockFeatured = List.generate(
                  1,
                  (_) => Establishment.skeleton(),
                );
                // Skeletonizer (box) dentro de SliverToBoxAdapter (sliver)
                return Skeletonizer(
                  child: FeaturedCarousel(
                    establishments: mockFeatured,
                    onEstablishmentTap: (_) {},
                  ),
                );
              },
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

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Novos estabelecimentos',
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
                  onEstablishmentTap: _navigateToEstablishmentDetails,
                );
              },
              loading: () {
                final mockCarousel = List.generate(
                  3,
                  (_) => Establishment.skeleton(),
                );
                // Skeletonizer (box) dentro de SliverToBoxAdapter (sliver)
                return Skeletonizer(
                  child: EstablishmentCarousel(
                    establishments: mockCarousel,
                    onEstablishmentTap: (_) {},
                  ),
                );
              },
              error: (error, _) => SizedBox(
                height: 200,
                child: ErrorDisplayWidget(
                  message: 'Erro ao carregar estabelecimentos em destaque',
                  onRetry: () => ref
                      .read(carouselEstablishmentsProvider.notifier)
                      .refresh(),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: Gap(16)),
          SliverPersistentHeader(
            pinned: true,
            delegate: EstablishmentCategoriesDelegate(
              context: context,
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
                          onTap: () => _navigateToEstablishmentDetails(
                            establishment.id,
                          ),
                        ),
                      );
                    },
                    childCount: establishments.length,
                  ),
                ),
              );
            },

            // --- ESTA É A CORREÇÃO ---
            loading: () {
              final mockList = List.generate(
                6,
                (_) => Establishment.skeleton(),
              );

              // O SliverList (ou SliverPadding) é o widget sliver principal
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final establishment = mockList[index];

                      // Cada item da lista é envolvido em seu
                      // próprio Skeletonizer (que é um box widget).
                      return Skeletonizer(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: EstablishmentListCard(
                            establishment: establishment,
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                    childCount: mockList.length,
                  ),
                ),
              );
            },

            // --- FIM DA CORREÇÃO ---
            error: (error, _) => SliverToBoxAdapter(
              child: ErrorDisplayWidget(
                message: 'Erro ao carregar estabelecimentos',
                onRetry: () =>
                    ref.read(establishmentsProvider.notifier).refresh(),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Gap(
              MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
