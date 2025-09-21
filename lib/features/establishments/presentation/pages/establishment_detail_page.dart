import 'dart:async';

import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/services/share_types.dart';
import 'package:barpass_app/core/services/url_launcher_types.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/features/establishments/presentation/providers/establishment_detail_provider.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_about_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_info_header.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_menu_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_photo_carousel.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_reviews_tab.dart';
import 'package:barpass_app/shared/widgets/base/buttons/favorite_button.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/feedback/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EstablishmentDetailPage extends ConsumerStatefulWidget {
  const EstablishmentDetailPage({
    required this.establishmentId,
    super.key,
  });

  final String establishmentId;

  @override
  ConsumerState<EstablishmentDetailPage> createState() =>
      _EstablishmentDetailPageState();
}

class _EstablishmentDetailPageState
    extends ConsumerState<EstablishmentDetailPage>
    with TickerProviderStateMixin {
  static const _initialSheetSize = 0.6;
  static const _tabCount = 3;

  late TabController _tabController;
  late DraggableScrollableController _sheetController;
  final ValueNotifier<double> _sheetPosition = ValueNotifier(_initialSheetSize);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: this);
    _sheetController = DraggableScrollableController()
      ..addListener(() {
        _sheetPosition.value = _sheetController.size;
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _sheetController.dispose();
    _sheetPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final establishmentState = ref.watch(
      establishmentDetailProvider(widget.establishmentId),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar(establishmentState),
      body: establishmentState.when(
        data: (establishment) {
          if (establishment == null) {
            return _buildNotFoundContent();
          }
          return _buildDetailContent(
            establishment,
            attachSheetController: true,
          );
        },
        loading: _buildLoadingBody,
        error: (error, stackTrace) => _buildErrorContent(error),
      ),
      bottomNavigationBar: establishmentState.when(
        data: (establishment) {
          if (establishment == null) {
            return null;
          }
          return _buildBottomNavigationBar(establishment);
        },
        loading: _buildLoadingBottomBar,
        error: (_, _) => null,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(AsyncValue<EstablishmentDetail?> state) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ValueListenableBuilder<double>(
        valueListenable: _sheetPosition,
        builder: (context, position, child) {
          final isDarkOverlay = position < _initialSheetSize;
          final iconBackgroundColor = context.colorScheme.inverseSurface
              .withValues(alpha: AppOpacity.overlay);
          final iconForegroundColor = context.colorScheme.onInverseSurface;

          return AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: isDarkOverlay
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            leading: IconButton.filled(
              icon: const BackButtonIcon(),
              onPressed: context.pop,
              style: IconButton.styleFrom(
                backgroundColor: iconBackgroundColor,
                foregroundColor: iconForegroundColor,
              ),
            ),
            actions: state.when(
              data: (establishment) {
                if (establishment == null) {
                  return const [];
                }
                return [
                  // ✨ NOVO: Widget especializado de favorito
                  FavoriteButton(
                    key: const ValueKey('favorite_button'),
                    isFavorite: establishment.isFavorite ?? false,
                    onToggle: _toggleFavorite,
                    backgroundColor: iconBackgroundColor,
                    foregroundColor: iconForegroundColor,
                  ),

                  // Mantém o botão de compartilhar existente
                  _AnimatedActionButton(
                    key: const ValueKey('share_button'),
                    icon: Icons.share,
                    onPressed: () => _shareEstablishment(establishment),
                    backgroundColor: iconBackgroundColor,
                    foregroundColor: iconForegroundColor,
                    animationDelay: const Duration(
                      milliseconds: 50,
                    ),
                  ),
                ];
              },
              loading: () => const [],
              error: (error, stackTrace) => const [],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
    final mockEstablishment = EstablishmentDetail.skeleton();

    return Skeletonizer(
      child: _buildDetailContent(
        mockEstablishment,
        attachSheetController: false,
      ),
    );
  }

  Widget _buildLoadingBottomBar() {
    final mockEstablishment = EstablishmentDetail.skeleton();

    return Skeletonizer(
      child: _buildBottomNavigationBar(mockEstablishment),
    );
  }

  Widget _buildNotFoundContent() {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const Gap(AppSpacing.md),
            Text(
              'Estabelecimento não encontrado',
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.itemGap),
            Text(
              'O estabelecimento que você procura não existe ou foi removido',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.sectionGap),
            FilledButton.icon(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorContent(Object error) {
    return Center(
      child: ErrorDisplayWidget(
        message: 'Erro ao carregar estabelecimento',
        onRetry: () {
          ref
              .read(
                establishmentDetailProvider(
                  widget.establishmentId,
                ).notifier,
              )
              .refresh();
        },
      ),
    );
  }

  Widget _buildDetailContent(
    EstablishmentDetail establishmentDetail, {
    required bool attachSheetController,
  }) {
    return Stack(
      children: [
        EstablishmentPhotoCarousel(
          establishmentId: widget.establishmentId,
          photos: establishmentDetail.photos,
        ),
        _buildDraggableSheet(
          establishmentDetail,
          attachSheetController: attachSheetController,
        ),
      ],
    );
  }

  Widget _buildDraggableSheet(
    EstablishmentDetail establishmentDetail, {
    required bool attachSheetController,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = kToolbarHeight + mediaQuery.padding.top;
    final screenHeight = mediaQuery.size.height;

    final minChildSize = (screenHeight * _initialSheetSize) / screenHeight;
    final maxChildSize = (screenHeight - appBarHeight) / screenHeight;
    final initialChildSize = minChildSize;

    return DraggableScrollableSheet(
      controller: attachSheetController ? _sheetController : null,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      snap: true,
      builder: (context, scrollController) {
        return _DraggableSheetContent(
          scrollController: scrollController,
          tabController: _tabController,
          establishmentDetail: establishmentDetail,
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(EstablishmentDetail establishmentDetail) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        boxShadow: AppShadows.bottomBar,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _openDirections(establishmentDetail),
                  icon: const Icon(Icons.directions),
                  label: const Text('Como chegar'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.componentGap,
                    ),
                  ),
                ),
              ),
              const Gap(AppSpacing.componentGap),
              if (establishmentDetail.hasPhone)
                IconButton.filled(
                  onPressed: () => _openWhatsApp(establishmentDetail),
                  icon: SvgPicture.asset(
                    'assets/icons/whatsapp.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  tooltip: 'Contatar via WhatsApp',
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF25D366),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite() async {
    if (Skeletonizer.maybeOf(context)?.enabled ?? false) return;

    try {
      unawaited(HapticFeedback.lightImpact());

      // O provider deve retornar o novo estado
      await ref
          .read(
            establishmentDetailProvider(
              widget.establishmentId,
            ).notifier,
          )
          .toggleFavorite();

      // Toast de sucesso (opcional, remova se preferir feedback mais sutil)
      if (mounted) {
        final establishment = ref
            .read(
              establishmentDetailProvider(widget.establishmentId),
            )
            .value;

        final isFavorite = establishment?.isFavorite ?? false;

        Burnt().toast(
          context,
          title: isFavorite
              ? 'Adicionado aos favoritos!'
              : 'Removido dos favoritos',
          preset: BurntPreset.done,
        );
      }
    } on Exception catch (error) {
      debugPrint('Erro ao favoritar: $error');
      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao favoritar estabelecimento',
          preset: BurntPreset.error,
        );
      }
    }
  }

  Future<void> _shareEstablishment(
    EstablishmentDetail establishmentDetail,
  ) async {
    if (Skeletonizer.maybeOf(context)?.enabled ?? false) return;
    try {
      unawaited(HapticFeedback.lightImpact());
      final shareService = ref.read(shareServiceProvider);
      final result = await shareService.shareEstablishment(
        name: establishmentDetail.name,
        address: establishmentDetail.address,
        discount: establishmentDetail.discount,
        sharePositionOrigin: _getSharePosition(),
      );
      if (result == ShareStatus.success) {
        debugPrint('Estabelecimento compartilhado com sucesso');
      }
    } on Exception catch (error) {
      debugPrint('Erro ao compartilhar: $error');
      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao compartilhar estabelecimento',
          preset: BurntPreset.error,
        );
      }
    }
  }

  Future<void> _openDirections(EstablishmentDetail establishmentDetail) async {
    if (Skeletonizer.maybeOf(context)?.enabled ?? false) return;
    try {
      unawaited(HapticFeedback.lightImpact());
      final urlLauncher = ref.read(urlLauncherServiceProvider);
      final result = await urlLauncher.openMaps(
        address: establishmentDetail.address,
      );
      if (result != LaunchResult.success) {
        if (mounted) {
          Burnt().toast(
            context,
            title: 'Não foi possível abrir o mapa',
            preset: BurntPreset.error,
          );
        }
      }
    } on Exception catch (error) {
      debugPrint('Erro ao abrir direções: $error');
      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao abrir direções',
          preset: BurntPreset.error,
        );
      }
    }
  }

  Future<void> _openWhatsApp(EstablishmentDetail establishmentDetail) async {
    if (Skeletonizer.maybeOf(context)?.enabled ?? false) return;
    try {
      unawaited(HapticFeedback.lightImpact());
      final urlLauncher = ref.read(urlLauncherServiceProvider);
      final result = await urlLauncher.openWhatsApp(
        phoneNumber: establishmentDetail.phone ?? '',
        message:
            'Olá! Vi o ${establishmentDetail.name} no barpass e gostaria de fazer uma reserva.',
      );
      if (result != LaunchResult.success) {
        if (mounted) {
          Burnt().toast(
            context,
            title: 'Não foi possível abrir o WhatsApp',
            preset: BurntPreset.error,
          );
        }
      }
    } on Exception catch (error) {
      debugPrint('Erro ao abrir WhatsApp: $error');
      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao contatar estabelecimento',
          preset: BurntPreset.error,
        );
      }
    }
  }

  Rect? _getSharePosition() {
    try {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        return Rect.fromLTWH(
          position.dx + box.size.width - 100,
          position.dy + 50,
          100,
          50,
        );
      }
    } on Exception catch (_) {}
    return null;
  }
}

// ===================================================================
// WIDGET: _AnimatedActionButton
// ===================================================================

class _AnimatedActionButton extends StatefulWidget {
  const _AnimatedActionButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.animationDelay = Duration.zero,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Duration animationDelay;

  @override
  State<_AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<_AnimatedActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(1.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: IconButton.filled(
        icon: Icon(widget.icon),
        onPressed: widget.onPressed,
        style: IconButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
        ),
      ),
    );
  }
}

// ===================================================================
// WIDGETS INTERNOS (Sheet Content e KeepAlive)
// ===================================================================

class _DraggableSheetContent extends StatefulWidget {
  const _DraggableSheetContent({
    required this.scrollController,
    required this.tabController,
    required this.establishmentDetail,
  });

  final ScrollController scrollController;
  final TabController tabController;
  final EstablishmentDetail establishmentDetail;

  @override
  State<_DraggableSheetContent> createState() => _DraggableSheetContentState();
}

class _DraggableSheetContentState extends State<_DraggableSheetContent>
    with TickerProviderStateMixin {
  static const _sheetBorderRadius = 20.0;
  static const _handleWidth = 40.0;
  static const _handleHeight = 4.0;

  final Map<int, bool> _tabScrollStates = {0: false, 1: false, 2: false};
  final ValueNotifier<bool> _hasScrolled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChanged);
    _hasScrolled.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!widget.tabController.indexIsChanging) {
      final currentTab = widget.tabController.index;
      _hasScrolled.value = _tabScrollStates[currentTab] ?? false;
    }
  }

  void _onTabScrollChanged(int tabIndex, bool hasScrolled) {
    _tabScrollStates[tabIndex] = hasScrolled;

    if (widget.tabController.index == tabIndex) {
      _hasScrolled.value = hasScrolled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_sheetBorderRadius),
          topRight: Radius.circular(_sheetBorderRadius),
        ),
        boxShadow: AppShadows.sheet,
      ),
      child: Column(
        children: [
          Container(
            width: _handleWidth,
            height: _handleHeight,
            margin: const EdgeInsets.only(
              top: AppSpacing.componentGap,
              bottom: AppSpacing.itemGap,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppRadius.sm / 2),
            ),
          ),
          EstablishmentInfoHeader(
            establishmentDetail: widget.establishmentDetail,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _hasScrolled,
            builder: (context, hasScrolled, child) {
              return _buildTabBar(context, hasScrolled);
            },
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: _buildTabBarView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, bool hasScrolled) {
    final theme = context.theme;
    final appBarTheme = theme.appBarTheme;

    return AnimatedSwitcher(
      duration: AppDuration.normal,
      child: Material(
        key: ValueKey<bool>(hasScrolled),
        elevation: hasScrolled
            ? appBarTheme.scrolledUnderElevation!
            : appBarTheme.elevation!,
        // --- CORREÇÃO AQUI ---
        // A TabBar faz parte do sheet, usa 'surfaceContainer',
        // não a cor da AppBar.
        color: context.colorScheme.surfaceContainer,
        // --- FIM DA CORREÇÃO ---
        shadowColor: appBarTheme.shadowColor,
        shape: const RoundedRectangleBorder(),
        child: TabBar(
          controller: widget.tabController,
          labelColor: context.theme.primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          dividerColor: context.theme.dividerColor,
          indicatorColor: context.theme.primaryColor,
          indicatorWeight: AppSizes.tabBarIndicatorWeight,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'Sobre'),
            Tab(text: 'Menu'),
            Tab(text: 'Avaliações'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: widget.tabController,
      children: [
        _KeepAliveTab(
          key: const PageStorageKey('about_tab'),
          tabIndex: 0,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentAboutTab(
            scrollController: widget.scrollController,
            establishmentDetail: widget.establishmentDetail,
          ),
        ),
        _KeepAliveTab(
          key: const PageStorageKey('menu_tab'),
          tabIndex: 1,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentMenuTab(
            scrollController: widget.scrollController,
            establishmentDetail: widget.establishmentDetail,
          ),
        ),
        _KeepAliveTab(
          key: const PageStorageKey('reviews_tab'),
          tabIndex: 2,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentReviewsTab(
            scrollController: widget.scrollController,
            establishmentDetail: widget.establishmentDetail,
          ),
        ),
      ],
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({
    required this.child,
    required this.tabIndex,
    required this.onScrollChanged,
    super.key,
  });

  final Widget child;
  final int tabIndex;
  final void Function(int tabIndex, bool hasScrolled) onScrollChanged;

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (isSkeleton) return false;

        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          final hasScrolled = notification.metrics.pixels > 0;
          widget.onScrollChanged(widget.tabIndex, hasScrolled);
        }
        return false;
      },
      child: widget.child,
    );
  }
}
