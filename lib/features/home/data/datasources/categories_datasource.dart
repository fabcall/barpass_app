import 'package:barpass_app/features/home/domain/entities/category.dart';

abstract class CategoriesDatasource {
  Future<List<Category>> getCategories();
}

class CategoriesDatasourceImpl implements CategoriesDatasource {
  // Dados mockados de categorias
  static const List<Map<String, dynamic>> _mockCategories = [
    {
      'id': 'all',
      'name': 'Todos',
      'slug': 'all',
      'icon': 'restaurant',
      'color': '#FF6B35',
      'description': 'Todos os tipos de estabelecimentos',
    },
    {
      'id': 'hamburger',
      'name': 'Burger',
      'slug': 'hamburger',
      'icon': 'lunch_dining',
      'color': '#E53935',
      'description': 'Hamburguerias e fast food',
    },
    {
      'id': 'pizza',
      'name': 'Pizza',
      'slug': 'pizza',
      'icon': 'local_pizza',
      'color': '#D32F2F',
      'description': 'Pizzarias e comida italiana',
    },
    {
      'id': 'sushi',
      'name': 'Sushi',
      'slug': 'sushi',
      'icon': 'ramen_dining',
      'color': '#2E7D32',
      'description': 'Culinária japonesa',
    },
    {
      'id': 'cafe',
      'name': 'Café',
      'slug': 'cafe',
      'icon': 'local_cafe',
      'color': '#8D6E63',
      'description': 'Cafeterias e padarias',
    },
    {
      'id': 'churrascaria',
      'name': 'Churrasco',
      'slug': 'churrascaria',
      'icon': 'outdoor_grill',
      'color': '#795548',
      'description': 'Churrascarias e carnes',
    },
    {
      'id': 'mexicana',
      'name': 'Mexicana',
      'slug': 'mexicana',
      'icon': 'emoji_food_beverage',
      'color': '#FF9800',
      'description': 'Culinária mexicana',
    },
    {
      'id': 'bar',
      'name': 'Bar',
      'slug': 'bar',
      'icon': 'local_bar',
      'color': '#FFC107',
      'description': 'Bares e petiscos',
    },
    {
      'id': 'vegetariana',
      'name': 'Vegetariana',
      'slug': 'vegetariana',
      'icon': 'eco',
      'color': '#4CAF50',
      'description': 'Comida vegetariana e vegana',
    },
  ];

  @override
  Future<List<Category>> getCategories() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    ); // Simula network delay

    return _mockCategories
        .map(
          (data) => Category(
            id: data['id'] as String,
            name: data['name'] as String,
            slug: data['slug'] as String,
            icon: data['icon'] as String?,
            color: data['color'] as String?,
            description: data['description'] as String?,
          ),
        )
        .toList();
  }
}
