import 'package:barpass_app/features/home/data/models/establishment_model.dart';

abstract class EstablishmentsDatasource {
  Future<List<EstablishmentModel>> getEstablishments({String? categoryId});
  Future<List<EstablishmentModel>> getFeaturedEstablishments();
  Future<EstablishmentModel?> getEstablishmentById(String id);
  Future<List<EstablishmentModel>> searchEstablishments(String query);
}

class EstablishmentsDatasourceImpl implements EstablishmentsDatasource {
  // Dados mockados de estabelecimentos
  static final List<Map<String, dynamic>> _mockEstablishments = [
    {
      'id': '1',
      'name': 'Burger House',
      'address': 'Rua das Flores, 123 - Centro',
      'rating': 4.8,
      'image_url':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=BH&background=FF6B35&color=fff&size=100',
      'distance': '850m',
      'discount': '20% OFF',
      'review_count': 127,
      'categories': ['hamburger', 'fast-food'],
      'api_id': 'api_1',
      'last_updated': '2024-01-20T10:00:00.000Z',
      'is_active': true,
    },
    {
      'id': '2',
      'name': 'Pizzaria Bella',
      'address': 'Av. Principal, 456 - Bairro Alto',
      'rating': 4.6,
      'image_url':
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=PB&background=E53935&color=fff&size=100',
      'distance': '1.2km',
      'discount': '15% OFF',
      'review_count': 89,
      'categories': ['pizza', 'italiana'],
      'api_id': 'api_2',
      'last_updated': '2024-01-20T11:30:00.000Z',
      'is_active': true,
    },
    {
      'id': '3',
      'name': 'Sushi Zen',
      'address': 'Rua Japão, 789 - Vila Oriental',
      'rating': 4.9,
      'image_url':
          'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=SZ&background=2E7D32&color=fff&size=100',
      'distance': '650m',
      'discount': '25% OFF',
      'review_count': 203,
      'categories': ['sushi', 'japonesa'],
      'api_id': 'api_3',
      'last_updated': '2024-01-20T09:15:00.000Z',
      'is_active': true,
    },
    {
      'id': '4',
      'name': 'Café Central',
      'address': 'Praça da Matriz, 321 - Centro Histórico',
      'rating': 4.4,
      'image_url':
          'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=CC&background=8D6E63&color=fff&size=100',
      'distance': '420m',
      'discount': '10% OFF',
      'review_count': 156,
      'categories': ['cafe', 'padaria'],
      'api_id': 'api_4',
      'last_updated': '2024-01-20T08:45:00.000Z',
      'is_active': true,
    },
    {
      'id': '5',
      'name': 'Churrascaria Gaúcha',
      'address': 'Av. Rio Grande, 567 - Zona Sul',
      'rating': 4.7,
      'image_url':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=CG&background=795548&color=fff&size=100',
      'distance': '2.1km',
      'discount': '30% OFF',
      'review_count': 312,
      'categories': ['churrascaria', 'brasileira'],
      'api_id': 'api_5',
      'last_updated': '2024-01-20T12:00:00.000Z',
      'is_active': true,
    },
    {
      'id': '6',
      'name': 'Taco Loco',
      'address': 'Rua México, 890 - Bairro Latino',
      'rating': 4.3,
      'image_url':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=TL&background=FF9800&color=fff&size=100',
      'distance': '1.8km',
      'discount': '18% OFF',
      'review_count': 74,
      'categories': ['mexicana', 'tacos'],
      'api_id': 'api_6',
      'last_updated': '2024-01-20T13:20:00.000Z',
      'is_active': true,
    },
    {
      'id': '7',
      'name': 'Bar do João',
      'address': 'Largo da Cerveja, 111 - Boemia',
      'rating': 4.5,
      'image_url':
          'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=BJ&background=FFC107&color=000&size=100',
      'distance': '950m',
      'discount': '22% OFF',
      'review_count': 189,
      'categories': ['bar', 'petiscos'],
      'api_id': 'api_7',
      'last_updated': '2024-01-20T14:10:00.000Z',
      'is_active': true,
    },
    {
      'id': '8',
      'name': 'Vegetariano Verde',
      'address': 'Rua Saúde, 234 - Jardim Botânico',
      'rating': 4.2,
      'image_url':
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
      'logo_url':
          'https://ui-avatars.com/api/?name=VV&background=4CAF50&color=fff&size=100',
      'distance': '1.4km',
      'discount': '12% OFF',
      'review_count': 98,
      'categories': ['vegetariana', 'saudavel'],
      'api_id': 'api_8',
      'last_updated': '2024-01-20T15:30:00.000Z',
      'is_active': true,
    },
  ];

  @override
  Future<List<EstablishmentModel>> getEstablishments({
    String? categoryId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 800),
    ); // Simula network delay

    var establishments = _mockEstablishments
        .map(EstablishmentModel.fromJson)
        .toList();

    // Filtrar por categoria se especificada
    if (categoryId != null && categoryId != 'all' && categoryId.isNotEmpty) {
      establishments = establishments
          .where((e) => e.categories.contains(categoryId))
          .toList();
    }

    // Ordenar por rating (melhor primeiro)
    establishments.sort((a, b) => b.rating.compareTo(a.rating));

    return establishments;
  }

  @override
  Future<List<EstablishmentModel>> getFeaturedEstablishments() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Retorna estabelecimentos com rating >= 4.5 e muitas avaliações
    final featured =
        _mockEstablishments
            .map(EstablishmentModel.fromJson)
            .where((e) => e.rating >= 4.5 && e.reviewCount >= 100)
            .toList()
          // Ordenar por número de avaliações (mais populares primeiro)
          ..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));

    return featured.take(5).toList(); // Apenas os top 5
  }

  @override
  Future<EstablishmentModel?> getEstablishmentById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    try {
      final data = _mockEstablishments.firstWhere((e) => e['id'] == id);
      return EstablishmentModel.fromJson(data);
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<List<EstablishmentModel>> searchEstablishments(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    final results =
        _mockEstablishments
            .map(EstablishmentModel.fromJson)
            .where(
              (e) =>
                  e.name.toLowerCase().contains(lowerQuery) ||
                  e.address.toLowerCase().contains(lowerQuery) ||
                  e.categories.any(
                    (cat) => cat.toLowerCase().contains(lowerQuery),
                  ),
            )
            .toList()
          // Ordenar por relevância (nome primeiro, depois endereço)
          ..sort((a, b) {
            final aNameMatch = a.name.toLowerCase().contains(lowerQuery);
            final bNameMatch = b.name.toLowerCase().contains(lowerQuery);

            if (aNameMatch && !bNameMatch) return -1;
            if (!aNameMatch && bNameMatch) return 1;

            return b.rating.compareTo(a.rating);
          });

    return results;
  }
}
