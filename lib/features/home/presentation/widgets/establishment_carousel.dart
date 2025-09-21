import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EstablishmentCarousel extends StatelessWidget {
  const EstablishmentCarousel({
    required this.establishments,
    super.key,
    this.onEstablishmentTap,
  });

  final List<Establishment> establishments;
  final void Function(Establishment)? onEstablishmentTap;

  @override
  Widget build(BuildContext context) {
    if (establishments.isEmpty) {
      return const SizedBox.shrink();
    }

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
            child: EstablishmentCarouselCard(
              establishment: establishment,
              onTap: () => onEstablishmentTap?.call(establishment),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class EstablishmentCarouselCard extends StatelessWidget {
  const EstablishmentCarouselCard({
    required this.establishment,
    super.key,
    this.onTap,
  });

  final Establishment establishment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 320, // Altura fixa para todos os cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: context.colorScheme.surfaceContainerLow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Expanded(
              // Faz o conteúdo ocupar o espaço restante
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return AspectRatio(
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
              child: CachedNetworkImage(
                imageUrl: establishment.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(
                  color: context.colorScheme.surfaceContainerHighest,
                  child: const SizedBox.shrink(),
                ),
                errorWidget: (context, url, error) => Container(
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

          // Discount badge
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                establishment.discount,
                style: TextStyle(
                  color: context.colorScheme.onPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com logo e nome (altura fixa)
          SizedBox(
            height: 32,
            child: Row(
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
                    child: CachedNetworkImage(
                      imageUrl: establishment.logoUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[100],
                        child: const SizedBox.shrink(),
                      ),
                      errorWidget: (context, error, stackTrace) => Container(
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
                    establishment.name,
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Endereço (altura fixa para 2 linhas)
          SizedBox(
            height: 32, // Altura fixa para 2 linhas de texto
            child: Text(
              establishment.address,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Spacer para empurrar o rating para o bottom
          const Spacer(),

          // Rating e distância (sempre no bottom)
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
                    establishment.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '(${establishment.reviewCount})',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                establishment.distance,
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
    );
  }
}
