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
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const Gap(16),
              Text(
                'Menu não disponível',
                style: context.textTheme.titleLarge,
              ),
              const Gap(8),
              Text(
                'Este estabelecimento ainda não cadastrou seu menu',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
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
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (category.description != null) ...[
          const Gap(4),
          Text(
            category.description!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
        const Gap(16),
        ...category.items.map((item) => _buildMenuItem(context, item)),
        const Gap(24),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (!item.isAvailable)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          'Indisponível',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Text(
            item.price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
