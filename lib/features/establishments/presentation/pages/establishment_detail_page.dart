import 'package:barpass_app/features/establishments/presentation/widgets/establishment_about_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_info_header.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_menu_tab.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_photo_carousel.dart';
import 'package:barpass_app/features/establishments/presentation/widgets/establishment_reviews_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EstablishmentDetailPage extends StatefulWidget {
  const EstablishmentDetailPage({
    required this.establishmentId,
    super.key,
  });

  final String establishmentId;

  @override
  State<EstablishmentDetailPage> createState() =>
      _EstablishmentDetailPageState();
}

class _EstablishmentDetailPageState extends State<EstablishmentDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late DraggableScrollableController _sheetController;

  double _sheetPosition = 0.6;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _sheetController = DraggableScrollableController();

    _sheetController.addListener(() {
      setState(() {
        _sheetPosition = _sheetController.size;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // Carrossel de fotos de fundo
          EstablishmentPhotoCarousel(
            establishmentId: widget.establishmentId,
          ),

          // DraggableScrollableSheet com conteúdo
          _buildDraggableSheet(context),

          // Rodapé fixo
          _buildFixedFooter(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDarkOverlay = _sheetPosition < 0.6;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: isDarkOverlay
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              // TODO: Implementar favoritos
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Implementar compartilhamento
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableSheet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = kToolbarHeight + mediaQuery.padding.top;
    final screenHeight = mediaQuery.size.height;

    // Calcula as posições considerando a AppBar
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
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
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

              // TabBar
              _buildTabBar(),

              // Conteúdo das abas com SafeArea e padding para o footer
              Expanded(
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 80,
                    ), // Espaço para o footer
                    child: _buildTabBarView(scrollController),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: Theme.of(context).primaryColor,
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
    );
  }

  Widget _buildTabBarView(ScrollController scrollController) {
    return TabBarView(
      controller: _tabController,
      children: [
        EstablishmentAboutTab(
          scrollController: scrollController,
          establishmentId: widget.establishmentId,
        ),
        EstablishmentMenuTab(
          scrollController: scrollController,
          establishmentId: widget.establishmentId,
        ),
        EstablishmentReviewsTab(
          scrollController: scrollController,
          establishmentId: widget.establishmentId,
        ),
      ],
    );
  }

  Widget _buildFixedFooter(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Botão Como chegar
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implementar navegação/direções
                      _openDirections();
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Como chegar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Botão WhatsApp
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366), // Cor oficial do WhatsApp
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Implementar abertura do WhatsApp
                      _openWhatsApp();
                    },
                    icon: const Icon(
                      Icons
                          .chat, // Você pode usar um ícone personalizado do WhatsApp aqui
                      color: Colors.white,
                      size: 24,
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openDirections() {
    // TODO: Implementar a lógica para abrir direções
    // Você pode usar url_launcher para abrir Google Maps/Apple Maps
    // ou integrar com alguma API de mapas
    print('Abrir direções para o estabelecimento ${widget.establishmentId}');
  }

  void _openWhatsApp() {
    // TODO: Implementar a lógica para abrir WhatsApp
    // Você pode usar url_launcher para abrir o WhatsApp
    // com um número específico do estabelecimento
    print('Abrir WhatsApp do estabelecimento ${widget.establishmentId}');
  }
}
