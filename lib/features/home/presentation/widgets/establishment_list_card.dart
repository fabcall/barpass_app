import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:flutter/material.dart';

/// Card de estabelecimento baseado no design original
///
/// Layout com logo circular à esquerda e badge de desconto flutuante
class EstablishmentListCard extends StatelessWidget {
  const EstablishmentListCard({
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo circular à esquerda
                Avatar(
                  image: NetworkImage(establishment.logoUrl),
                  name: establishment.name,
                  size: AppSizes.avatarMd,
                ),
                const SizedBox(width: AppSpacing.lg),
                // Conteúdo principal
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 80,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do estabelecimento
                        Text(
                          establishment.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: AppSpacing.xs),

                        // Endereço
                        Text(
                          establishment.address,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        // Rating e distância
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: context.colorScheme.warning,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              establishment.rating.toString(),
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '(${establishment.reviewCount})',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: context.colorScheme.warning,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              establishment.distance,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
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
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs + 2,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.warning,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  boxShadow: AppShadows.badgeShadow(
                    context.colorScheme.warning,
                  ),
                ),
                child: Text(
                  establishment.discount,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onWarning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
