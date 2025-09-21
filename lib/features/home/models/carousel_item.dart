import 'package:flutter/foundation.dart';

@immutable
class CarouselItem {
  final String id;
  final String title;
  final String? imageUrl;
  final VoidCallback? onTap;

  const CarouselItem({
    required this.id,
    required this.title,
    this.imageUrl,
    this.onTap,
  });
}
