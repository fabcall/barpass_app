import 'package:freezed_annotation/freezed_annotation.dart';

part 'establishment_detail.freezed.dart';

/// Entidade detalhada de estabelecimento
/// Contém todas as informações necessárias para a tela de detalhes

@freezed
sealed class EstablishmentDetail with _$EstablishmentDetail {
  const factory EstablishmentDetail({
    required String id,
    required String name,
    required String address,
    required double rating,
    required String imageUrl,
    required String logoUrl,
    required String distance,
    required String discount,
    @Default(0) int reviewCount,
    @Default([]) List<String> categories,

    // ✨ NOVO: Estado de favorito
    @Default(false) bool isFavorite,

    // Informações adicionais para detalhes
    String? description,
    String? phone,
    String? email,
    String? website,

    // Horário de funcionamento
    String? openingHours,
    bool? isOpen,

    // Formas de pagamento
    @Default([]) List<String> paymentMethods,

    // Facilidades
    @Default([]) List<String> facilities,

    // Fotos
    @Default([]) List<String> photos,

    // Menu
    @Default([]) List<MenuCategory> menuCategories,

    // Avaliações
    @Default([]) List<Review> reviews,
  }) = _EstablishmentDetail;

  factory EstablishmentDetail.skeleton() {
    return EstablishmentDetail(
      id: 'skeleton',
      name: 'Burger House',
      address: 'Endereço completo, 123 - Bairro',
      rating: 4.5,
      imageUrl: 'skeleton_img',
      logoUrl: 'https://dummyimage.com/56x56/000/000000',
      distance: '1.2 km',
      discount: '10%',
      reviewCount: 123,
      categories: ['Categoria 1', 'Categoria 2'],
      isFavorite: false, // ✨ NOVO
      description:
          'Texto de descrição longo para preencher o espaço de várias linhas no skeleton shimmer.',
      phone: '999999999',
      email: 'skeleton@email.com',
      website: 'skeleton.com',
      openingHours: 'Seg - Sex: 08:00 - 18:00',
      isOpen: true,
      paymentMethods: ['skeleton'],
      facilities: ['skeleton'],
      photos: ['s1', 's2', 's3'],
      menuCategories: [
        MenuCategory.skeleton(),
        MenuCategory.skeleton(name: 'Bebidas'),
      ],
      reviews: [
        Review.skeleton(),
        Review.skeleton(),
      ],
    );
  }

  const EstablishmentDetail._();

  // Business logic existente...
  bool get hasDescription => description != null && description!.isNotEmpty;
  bool get hasPhone => phone != null && phone!.isNotEmpty;
  bool get hasEmail => email != null && email!.isNotEmpty;
  bool get hasWebsite => website != null && website!.isNotEmpty;
  bool get hasPhotos => photos.isNotEmpty;
  bool get hasMenu => menuCategories.isNotEmpty;
  bool get hasReviews => reviews.isNotEmpty;
  bool get hasFacilities => facilities.isNotEmpty;
  bool get hasPaymentMethods => paymentMethods.isNotEmpty;

  String get statusText => (isOpen ?? false) ? 'Aberto' : 'Fechado';
  double get averageRating => rating;

  Map<int, int> get ratingDistribution {
    if (reviews.isEmpty) return {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final review in reviews) {
      distribution[review.rating] = (distribution[review.rating] ?? 0) + 1;
    }
    return distribution;
  }
}

/// Categoria de menu
@freezed
sealed class MenuCategory with _$MenuCategory {
  const factory MenuCategory({
    required String id,
    required String name,
    String? description,
    @Default([]) List<MenuItem> items,
  }) = _MenuCategory;

  // --- ADICIONE ISSO ---
  factory MenuCategory.skeleton({String name = 'Pratos Principais'}) {
    return MenuCategory(
      id: 'skeleton_cat',
      name: name,
      description: 'Descrição da categoria de menu',
      items: [
        MenuItem.skeleton(),
        MenuItem.skeleton(),
        MenuItem.skeleton(),
      ],
    );
  }
  // --- FIM DA ADIÇÃO ---

  const MenuCategory._();

  bool get hasItems => items.isNotEmpty;
}

/// Item do menu
@freezed
sealed class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String name,
    required String description,
    required String price,
    String? imageUrl,
    @Default(false) bool isAvailable,
  }) = _MenuItem;

  // --- ADICIONE ISSO ---
  factory MenuItem.skeleton() {
    return const MenuItem(
      id: 'skeleton_item',
      name: 'Nome do Item do Menu',
      description: 'Descrição breve do item com alguns ingredientes.',
      price: 'R\$ 29,90',
      imageUrl: 'skeleton_item_img',
      isAvailable: true,
    );
  }
  // --- FIM DA ADIÇÃO ---

  const MenuItem._();

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}

/// Avaliação de usuário
@freezed
sealed class Review with _$Review {
  const factory Review({
    required String id,
    required String userName,
    required int rating,
    required String comment,
    required DateTime createdAt,
    String? userAvatarUrl,
  }) = _Review;

  // --- ADICIONE ISSO ---
  factory Review.skeleton() {
    return Review(
      id: 'skeleton_review',
      userName: 'Nome do Usuário',
      rating: 5,
      comment:
          'Este é um comentário de avaliação para preencher espaço e ser skeletonizado.',
      createdAt: DateTime.now(),
      userAvatarUrl: 'skeleton_avatar',
    );
  }
  // --- FIM DA ADIÇÃO ---

  const Review._();

  bool get hasAvatar => userAvatarUrl != null && userAvatarUrl!.isNotEmpty;

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 ano atrás' : '$years anos atrás';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 mês atrás' : '$months meses atrás';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 dia atrás'
          : '${difference.inDays} dias atrás';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hora atrás'
          : '${difference.inHours} horas atrás';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minuto atrás'
          : '${difference.inMinutes} minutos atrás';
    } else {
      return 'Agora mesmo';
    }
  }
}
