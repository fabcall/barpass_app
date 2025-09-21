import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentMenuTab extends StatelessWidget {
  const EstablishmentMenuTab({
    required this.scrollController,
    required this.establishmentDetail,
    super.key,
  });

  final ScrollController scrollController;
  final EstablishmentDetail establishmentDetail;

  @override
  Widget build(BuildContext context) {
    if (!establishmentDetail.hasMenu) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                size: 64,
                color: context.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.5,
                ),
              ),
              const Gap(AppSpacing.md),
              Text(
                'Menu não disponível',
                style: context.textTheme.titleLarge,
              ),
              const Gap(AppSpacing.sm),
              Text(
                'Este estabelecimento ainda não cadastrou seu menu',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...establishmentDetail.menuCategories.map(
              (category) => _buildMenuSection(context, category),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, MenuCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (category.description != null) ...[
          const Gap(AppSpacing.xs),
          Text(
            category.description!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const Gap(AppSpacing.md),
        ...category.items.map((item) => _buildMenuItem(context, item)),
        const Gap(AppSpacing.lg),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (!item.isAvailable)
                      Container(
                        margin: const EdgeInsets.only(left: AppSpacing.sm),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.error.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(
                            color: context.colorScheme.error.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Text(
                          'Indisponível',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(AppSpacing.xs),
                Text(
                  item.description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            item.price,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
