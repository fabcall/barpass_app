import 'package:barpass_app/features/home/models/establishment_carousel_item.dart';
import 'package:barpass_app/features/home/widgets/establishment_carousel.dart';
import 'package:barpass_app/features/home/widgets/establishment_categories.dart';
import 'package:barpass_app/features/home/widgets/featured_carousel.dart';
import 'package:barpass_app/features/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ========================================
// Widget para card de estabelecimento em lista
// ========================================
class EstablishmentListCard extends StatelessWidget {
  const EstablishmentListCard({
    required this.establishment,
    super.key,
  });

  final EstablishmentCarouselItem establishment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo circular à esquerda
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: ClipOval(
                  child: establishment.logoUrl.isNotEmpty
                      ? Image.network(
                          establishment.logoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.restaurant_menu,
                            size: 24,
                            color: Colors.grey[600],
                          ),
                        )
                      : Icon(
                          Icons.restaurant_menu,
                          size: 24,
                          color: Colors.grey[600],
                        ),
                ),
              ),

              // Conteúdo principal
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome do estabelecimento
                      Text(
                        establishment.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Endereço
                      Text(
                        establishment.address,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Rating e distância
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orange[400],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            establishment.rating.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.orange[400],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            establishment.distance,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
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

          // Badge de desconto no canto superior direito
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                establishment.discount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageBody();
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeAppBar(),

        // Featured Carousel
        const SliverToBoxAdapter(
          child: FeaturedCarousel(),
        ),

        // Espaçamento
        const SliverToBoxAdapter(
          child: Gap(24),
        ),

        // Título da seção de estabelecimentos
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

        // Espaçamento
        const SliverToBoxAdapter(
          child: Gap(16),
        ),

        // Carousel de estabelecimentos
        SliverToBoxAdapter(
          child: EstablishmentCarousel(
            establishments: _getSampleEstablishments(),
          ),
        ),

        // Espaçamento antes das categorias
        const SliverToBoxAdapter(
          child: Gap(16),
        ),

        // Header persistente de categorias
        SliverPersistentHeader(
          pinned: true,
          delegate: EstablishmentCategoriesDelegate(
            topPadding: MediaQuery.of(context).padding.top,
          ),
        ),

        // Espaçamento antes das categorias
        const SliverToBoxAdapter(
          child: Gap(8),
        ),

        // Lista de estabelecimentos filtrados por categoria
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Aqui você pode filtrar estabelecimentos por categoria selecionada
                final establishments = _getSampleEstablishments();
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
        ),

        // Espaçamento final
        const SliverToBoxAdapter(
          child: Gap(256),
        ),
      ],
    );
  }

  static List<EstablishmentCarouselItem> _getSampleEstablishments() {
    return [
      const EstablishmentCarouselItem(
        id: '1',
        title: 'Barbecue Grill',
        imageUrl:
            'https://lirp.cdn-website.com/3a0c1a25/dms3rep/multi/opt/DSCF0421023Aweb-1500x1042-1920w.jpg',
        logoUrl:
            'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=200&h=200&fit=crop&crop=center',
        address: 'Rua Augusta, 77 • São Paulo - SP',
        rating: 4.9,
        reviewCount: 1400,
        distance: '14,19KM',
        discount: '5% a 10%',
      ),
      const EstablishmentCarouselItem(
        id: '2',
        title: 'Pizzaria do Bairro',
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800&h=600&fit=crop',
        logoUrl:
            'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?w=200&h=200&fit=crop&crop=center',
        address: 'Av. Paulista, 1000 • São Paulo - SP',
        rating: 4.7,
        reviewCount: 890,
        distance: '8,5KM',
        discount: '15%',
      ),
      const EstablishmentCarouselItem(
        id: '3',
        title: 'Sushi Premium',
        imageUrl:
            'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=600&fit=crop',
        logoUrl:
            'https://images.unsplash.com/photo-1563612198817-087fb2de1dc2?w=200&h=200&fit=crop&crop=center',
        address: 'Rua das Flores, 123 • São Paulo - SP',
        rating: 4.8,
        reviewCount: 650,
        distance: '12,3KM',
        discount: '20%',
      ),
      const EstablishmentCarouselItem(
        id: '4',
        title: 'Café Central',
        imageUrl:
            'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&h=600&fit=crop',
        logoUrl:
            'https://images.unsplash.com/photo-1559305616-f42934d0c7d0?w=200&h=200&fit=crop&crop=center',
        address: 'Rua do Café, 45 • São Paulo - SP',
        rating: 4.5,
        reviewCount: 320,
        distance: '2,3KM',
        discount: '10%',
      ),
      const EstablishmentCarouselItem(
        id: '5',
        title: 'Bar do Mercado',
        imageUrl:
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop',
        logoUrl:
            'https://images.unsplash.com/photo-1580874015473-40eda5a9a7ee?w=200&h=200&fit=crop&crop=center',
        address: 'Mercado Municipal • São Paulo - SP',
        rating: 4.4,
        reviewCount: 156,
        distance: '5,7KM',
        discount: '8%',
      ),
    ];
  }
}

// ========================================
// Versão com Riverpod (opcional)
// ========================================
/*
// Se quiser usar Riverpod para filtrar por categoria:

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/categories_provider.dart';

class HomePageBodyWithRiverpod extends ConsumerWidget {
  const HomePageBodyWithRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesProvider);
    
    return CustomScrollView(
      slivers: [
        // ... outros slivers ...

        // Lista filtrada por categoria
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Filtrar estabelecimentos pela categoria selecionada
                final allEstablishments = _getSampleEstablishments();
                final filteredEstablishments = _filterByCategory(
                  allEstablishments, 
                  categoriesState.selectedCategory?.slug,
                );
                
                if (index >= filteredEstablishments.length) return null;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: EstablishmentListCard(
                    establishment: filteredEstablishments[index],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<EstablishmentCarouselItem> _filterByCategory(
    List<EstablishmentCarouselItem> establishments, 
    String? categorySlug,
  ) {
    if (categorySlug == null || categorySlug == 'all') {
      return establishments;
    }
    
    // Aqui você implementaria a lógica de filtro real
    // Por enquanto, retorna todos
    return establishments;
  }
}
*/
