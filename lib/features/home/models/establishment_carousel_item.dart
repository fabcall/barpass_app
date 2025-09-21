// Novo modelo para estabelecimentos compatível com CarouselItem
import 'package:barpass_app/features/home/models/carousel_item.dart';

class EstablishmentCarouselItem extends CarouselItem {
  final String logoUrl;
  final String address;
  final double rating;
  final int reviewCount;
  final String distance;
  final String discount;

  const EstablishmentCarouselItem({
    required super.id,
    required super.title,
    required super.imageUrl,
    required this.logoUrl,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.discount,
    super.onTap,
  });
}
