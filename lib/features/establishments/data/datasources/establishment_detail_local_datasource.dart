import 'package:barpass_app/features/establishments/data/models/establishment_detail_model.dart';

abstract class EstablishmentDetailLocalDataSource {
  Future<EstablishmentDetailModel?> getEstablishmentDetail(String id);
}

class EstablishmentDetailLocalDataSourceImpl
    implements EstablishmentDetailLocalDataSource {
  // Dados mockados completos
  static final Map<String, Map<String, dynamic>> _mockEstablishments = {
    '1': {
      'id': '1',
      'name': 'Burger House',
      'address': 'Rua das Flores, 123 - Centro',
      'rating': 4.8,
      'image_url':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
      'logo_url':
          'https://ui-avatars.com/api/?name=BH&background=FF6B35&color=fff&size=100',
      'distance': '850m',
      'discount': '20% OFF',
      'review_count': 127,
      'categories': ['hamburger', 'fast-food'],
      'description':
          'A Burger House é especializada em hambúrgueres artesanais feitos com ingredientes frescos e de alta qualidade. Nossos pães são assados diariamente e nossas carnes são 100% bovinas.',
      'phone': '+5511999999999',
      'email': 'contato@burgerhouse.com',
      'website': 'https://burgerhouse.com',
      'opening_hours': 'Seg - Dom: 18:00 - 23:00',
      'is_open': true,
      'payment_methods': ['Cartão', 'PIX', 'Dinheiro', 'Vale Refeição'],
      'facilities': [
        'Wi-Fi Gratuito',
        'Estacionamento',
        'Acessível',
        'Delivery',
        'Aceita Reservas',
      ],
      'photos': [
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
        'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
        'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=800',
        'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=800',
      ],
      'menu_categories': [
        {
          'id': 'burgers',
          'name': 'Burgers',
          'description': 'Nossos hambúrgueres artesanais',
          'items': [
            {
              'id': 'classic',
              'name': 'Clássico',
              'description':
                  'Hambúrguer 180g, queijo, alface, tomate e molho especial',
              'price': r'R$ 28,90',
              'is_available': true,
            },
            {
              'id': 'bacon',
              'name': 'Bacon Burger',
              'description':
                  'Hambúrguer 180g, queijo, bacon crocante e cebola caramelizada',
              'price': r'R$ 32,90',
              'is_available': true,
            },
            {
              'id': 'veggie',
              'name': 'Veggie Burger',
              'description':
                  'Hambúrguer vegetariano, queijo, rúcula e tomate seco',
              'price': r'R$ 26,90',
              'is_available': true,
            },
          ],
        },
        {
          'id': 'sides',
          'name': 'Acompanhamentos',
          'items': [
            {
              'id': 'fries',
              'name': 'Batatas Fritas',
              'description': 'Porção de batatas fritas crocantes',
              'price': r'R$ 12,90',
              'is_available': true,
            },
            {
              'id': 'onion-rings',
              'name': 'Onion Rings',
              'description': 'Anéis de cebola empanados',
              'price': r'R$ 14,90',
              'is_available': true,
            },
          ],
        },
      ],
      'reviews': [
        {
          'id': '1',
          'user_name': 'Maria Silva',
          'rating': 5,
          'comment':
              'Excelente hambúrguer! A carne é suculenta e os ingredientes são frescos. O atendimento também foi ótimo.',
          'created_at': DateTime.now()
              .subtract(Duration(days: 2))
              .toIso8601String(),
        },
        {
          'id': '2',
          'user_name': 'João Santos',
          'rating': 4,
          'comment': 'Muito bom! Só achei o preço um pouco alto.',
          'created_at': DateTime.now()
              .subtract(Duration(days: 5))
              .toIso8601String(),
        },
        {
          'id': '3',
          'user_name': 'Ana Costa',
          'rating': 5,
          'comment': 'Melhor hambúrguer da região! Super recomendo.',
          'created_at': DateTime.now()
              .subtract(Duration(days: 7))
              .toIso8601String(),
        },
      ],
    },
    // Adicionar mais estabelecimentos conforme necessário
    '2': {
      'id': '2',
      'name': 'Pizzaria Bella',
      'address': 'Av. Principal, 456 - Bairro Alto',
      'rating': 4.6,
      'image_url':
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
      'logo_url':
          'https://ui-avatars.com/api/?name=PB&background=E53935&color=fff&size=100',
      'distance': '1.2km',
      'discount': '15% OFF',
      'review_count': 89,
      'categories': ['pizza', 'italiana'],
      'description':
          'Pizzaria tradicional italiana com massas artesanais e ingredientes importados. Ambiente aconchegante perfeito para família.',
      'phone': '+5511988888888',
      'opening_hours': 'Ter - Dom: 18:00 - 23:30',
      'is_open': true,
      'payment_methods': ['Cartão', 'PIX', 'Dinheiro'],
      'facilities': ['Wi-Fi Gratuito', 'Estacionamento', 'Kids Friendly'],
      'photos': [
        'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800',
      ],
      'menu_categories': [
        {
          'id': 'pizzas',
          'name': 'Pizzas',
          'items': [
            {
              'id': 'margherita',
              'name': 'Margherita',
              'description': 'Molho de tomate, mussarela e manjericão',
              'price': r'R$ 45,90',
              'is_available': true,
            },
          ],
        },
      ],
      'reviews': [],
    },
  };

  @override
  Future<EstablishmentDetailModel?> getEstablishmentDetail(String id) async {
    // Simula delay de rede
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final data = _mockEstablishments[id];
    if (data == null) return null;

    return EstablishmentDetailModel.fromJson(data);
  }
}
