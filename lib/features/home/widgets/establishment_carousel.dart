import 'package:barpass_app/features/home/models/establishment_carousel_item.dart';
import 'package:flutter/material.dart';

class EstablishmentCarouselWidget extends StatelessWidget {
  const EstablishmentCarouselWidget({
    required this.item,
    super.key,
  });

  final EstablishmentCarouselItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: ColorScheme.of(context).surfaceContainerLow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        item.imageUrl ??
                            'https://lirp.cdn-website.com/3a0c1a25/dms3rep/multi/opt/DSCF0421023Aweb-1500x1042-1920w.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          height: double.infinity,
                          child: const Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: ColorScheme.of(context).primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.discount,
                        style: TextStyle(
                          color: ColorScheme.of(context).onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            item.logoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[100],
                                  child: const Icon(
                                    Icons.restaurant_menu,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: ColorScheme.of(context).onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            item.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '(${item.reviewCount})',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Text(
                        item.distance,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Carrossel específico para estabelecimentos (altura dinâmica)
class EstablishmentCarousel extends StatelessWidget {
  final List<EstablishmentCarouselItem> establishments;

  const EstablishmentCarousel({
    required this.establishments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.none,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: establishments.asMap().entries.map((entry) {
          final index = entry.key;
          final establishment = entry.value;

          return Padding(
            padding: EdgeInsets.only(
              right: index < establishments.length - 1 ? 16 : 0,
            ),
            child: EstablishmentCarouselWidget(
              item: establishment,
            ),
          );
        }).toList(),
      ),
    );
  }
}
