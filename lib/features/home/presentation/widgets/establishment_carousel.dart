import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/shared/widgets/base/status_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EstablishmentCarousel extends StatelessWidget {
  const EstablishmentCarousel({
    required this.establishments,
    super.key,
    this.onEstablishmentTap,
  });

  final List<Establishment> establishments;
  final void Function(String establishmentId)? onEstablishmentTap;

  @override
  Widget build(BuildContext context) {
    if (establishments.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      clipBehavior: Clip.none,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: establishments.asMap().entries.map((entry) {
          final index = entry.key;
          final establishment = entry.value;

          return Padding(
            padding: EdgeInsets.only(
              right: index < establishments.length - 1 ? AppSpacing.md : 0,
            ),
            child: EstablishmentCarouselCard(
              establishment: establishment,
              onTap: () => onEstablishmentTap?.call(establishment.id),
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
        height: 320,
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderLg,
          boxShadow: AppShadows.medium,
          color: context.colorScheme.surfaceContainerLow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Expanded(
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
              topLeft: Radius.circular(AppRadius.lg),
              topRight: Radius.circular(AppRadius.lg),
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
                  color: context.colorScheme.surfaceContainerHighest,
                  height: double.infinity,
                  child: Icon(
                    Icons.restaurant,
                    size: 40,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),

          // Discount badge
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: StatusBadge.warning(
              label: establishment.discount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
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
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: establishment.logoUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: context.colorScheme.surfaceContainerHighest,
                        child: const SizedBox.shrink(),
                      ),
                      errorWidget: (context, error, stackTrace) => Container(
                        color: context.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.restaurant_menu,
                          color: context.colorScheme.onSurfaceVariant,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    establishment.name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Endereço (altura fixa para 2 linhas)
          SizedBox(
            height: 32,
            child: Text(
              establishment.address,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(),

          // Rating e distância (sempre no bottom)
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: context.colorScheme.warning,
                    size: 14,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    establishment.rating.toStringAsFixed(1),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '(${establishment.reviewCount})',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                establishment.distance,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
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
