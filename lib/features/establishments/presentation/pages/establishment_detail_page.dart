import 'dart:async';

import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/services/share_types.dart';
import 'package:barpass_app/core/services/url_launcher_types.dart';
import 'package:barpass_app/core/theme/app_shadows.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_about_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_info_header.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_menu_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_photo_carousel.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_reviews_tab.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
  late TabController _tabController;
  late DraggableScrollableController _sheetController;

  // ValueNotifier para otimizar re-renderizações
  final ValueNotifier<double> _sheetPosition = ValueNotifier(0.6);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _sheetController = DraggableScrollableController();

    // Usar ValueNotifier em vez de setState
    _sheetController.addListener(() {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Carrossel de fotos de fundo
          EstablishmentPhotoCarousel(
            establishmentId: widget.establishmentId,
          ),

          // DraggableScrollableSheet com conteúdo
          _buildDraggableSheet(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ValueListenableBuilder<double>(
        valueListenable: _sheetPosition,
        builder: (context, position, child) {
          final isDarkOverlay = position < 0.6;

          final iconBackgroundColor = context.colorScheme.inverseSurface
              .withValues(
                alpha: 0.6,
              );
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
            actions: [
              IconButton.filled(
                icon: const Icon(
                  Icons.favorite_border,
                ),
                onPressed: _toggleFavorite,
                style: IconButton.styleFrom(
                  backgroundColor: iconBackgroundColor,
                  foregroundColor: iconForegroundColor,
                ),
              ),
              IconButton.filled(
                icon: const Icon(
                  Icons.share,
                ),
                onPressed: _shareEstablishment,
                style: IconButton.styleFrom(
                  backgroundColor: iconBackgroundColor,
                  foregroundColor: iconForegroundColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDraggableSheet() {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = kToolbarHeight + mediaQuery.padding.top;
    final screenHeight = mediaQuery.size.height;

    final minChildSize = (screenHeight * 0.6) / screenHeight;
    final maxChildSize = (screenHeight - appBarHeight) / screenHeight;
    final initialChildSize = minChildSize;

    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      snap: true,
      builder: (context, scrollController) {
        return _DraggableSheetContent(
          scrollController: scrollController,
          tabController: _tabController,
          establishmentId: widget.establishmentId,
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: AppShadows.bottomBar,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Botão Como chegar
              Expanded(
                child: FilledButton.icon(
                  onPressed: _openDirections,
                  icon: const Icon(Icons.directions),
                  label: const Text('Como chegar'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Botão WhatsApp
              IconButton.filled(
                onPressed: _openWhatsApp,
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

  // Implementações dos métodos (mantidas iguais)
  Future<void> _toggleFavorite() async {
    try {
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        Burnt().toast(
          context,
          title: 'Adicionado aos favoritos!',
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

  Future<void> _shareEstablishment() async {
    try {
      unawaited(HapticFeedback.lightImpact());
      final shareService = ref.read(shareServiceProvider);
      final result = await shareService.shareEstablishment(
        name: 'Restaurante Exemplo',
        address: 'Rua das Flores, 123 - Centro',
        discount: '20% OFF',
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

  Future<void> _openDirections() async {
    try {
      unawaited(HapticFeedback.lightImpact());
      final urlLauncher = ref.read(urlLauncherServiceProvider);
      final result = await urlLauncher.openMaps(
        address: 'Rua das Flores, 123 - Centro',
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

  Future<void> _openWhatsApp() async {
    try {
      unawaited(HapticFeedback.lightImpact());
      final urlLauncher = ref.read(urlLauncherServiceProvider);
      final result = await urlLauncher.openWhatsApp(
        phoneNumber: '+5511999999999',
        message:
            'Olá! Vi o restaurante no barpass e gostaria de fazer uma reserva.',
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

// Widget separado para o conteúdo do sheet com sistema de callbacks
class _DraggableSheetContent extends StatefulWidget {
  const _DraggableSheetContent({
    required this.scrollController,
    required this.tabController,
    required this.establishmentId,
  });

  final ScrollController scrollController;
  final TabController tabController;
  final String establishmentId;

  @override
  State<_DraggableSheetContent> createState() => _DraggableSheetContentState();
}

class _DraggableSheetContentState extends State<_DraggableSheetContent> {
  // ✅ Map para controlar o estado de scroll de cada aba individualmente
  final Map<int, bool> _tabScrollStates = {0: false, 1: false, 2: false};

  // ✅ ValueNotifier para controlar a sombra da TabBar
  final ValueNotifier<bool> _hasScrolled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    // ✅ Adiciona listener para detectar mudança de aba
    widget.tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    // ✅ Remove o listener antes de dispose
    widget.tabController.removeListener(_onTabChanged);
    _hasScrolled.dispose();
    super.dispose();
  }

  // ✅ Atualiza o shadow baseado na aba atual
  void _onTabChanged() {
    if (!widget.tabController.indexIsChanging) {
      // Só atualiza quando a transição termina
      final currentTab = widget.tabController.index;
      _hasScrolled.value = _tabScrollStates[currentTab] ?? false;
    }
  }

  // ✅ Callback chamado pelas abas quando detectam mudança de scroll
  void _onTabScrollChanged(int tabIndex, bool hasScrolled) {
    // Atualiza o estado da aba específica
    _tabScrollStates[tabIndex] = hasScrolled;

    // Só atualiza o ValueNotifier se for a aba atual
    if (widget.tabController.index == tabIndex) {
      _hasScrolled.value = hasScrolled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // Usando a sombra padronizada para sheets
        boxShadow: AppShadows.sheet,
      ),
      child: Column(
        children: [
          // Handle do sheet
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header com informações básicas
          EstablishmentInfoHeader(establishmentId: widget.establishmentId),

          // TabBar com sombra condicional
          ValueListenableBuilder<bool>(
            valueListenable: _hasScrolled,
            builder: (context, hasScrolled, child) {
              return _buildTabBar(context, hasScrolled);
            },
          ),

          // Conteúdo das abas
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
      duration: const Duration(milliseconds: 200),
      child: Material(
        key: ValueKey<bool>(hasScrolled),
        elevation: hasScrolled
            ? appBarTheme.scrolledUnderElevation!
            : appBarTheme.elevation!,
        color: appBarTheme.backgroundColor,
        shadowColor: appBarTheme.shadowColor,
        shape: const RoundedRectangleBorder(),
        child: TabBar(
          controller: widget.tabController,
          labelColor: context.theme.primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          dividerColor: context.theme.dividerColor,
          indicatorColor: context.theme.primaryColor,
          indicatorWeight: 3,
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
        // ✅ Aba 0 - Sobre
        _KeepAliveTab(
          key: const PageStorageKey('about_tab'),
          tabIndex: 0,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentAboutTab(
            scrollController: widget.scrollController,
            establishmentId: widget.establishmentId,
          ),
        ),

        // ✅ Aba 1 - Menu
        _KeepAliveTab(
          key: const PageStorageKey('menu_tab'),
          tabIndex: 1,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentMenuTab(
            scrollController: widget.scrollController,
            establishmentId: widget.establishmentId,
          ),
        ),

        // ✅ Aba 2 - Avaliações
        _KeepAliveTab(
          key: const PageStorageKey('reviews_tab'),
          tabIndex: 2,
          onScrollChanged: _onTabScrollChanged,
          child: EstablishmentReviewsTab(
            scrollController: widget.scrollController,
            establishmentId: widget.establishmentId,
          ),
        ),
      ],
    );
  }
}

// ✅ Widget helper atualizado com sistema de callbacks
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
    super.build(context); // ✅ Importante: chame super.build()

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // ✅ Detecta scroll e notifica o parent com o índice da aba
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
