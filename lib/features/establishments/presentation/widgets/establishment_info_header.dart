import 'dart:math';

import 'package:barpass_app/shared/widgets/base/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentInfoHeader extends StatelessWidget {
  const EstablishmentInfoHeader({
    required this.establishmentId,
    super.key,
  });

  final String establishmentId;

  @override
  Widget build(BuildContext context) {
    // TODO: Substituir por dados reais do provider
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildEstablishmentLogo(),
              const Gap(12),
              Expanded(
                child: _buildEstablishmentInfo(context),
              ),
              _buildStatusBadge(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstablishmentLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://images.unsplash.com/photo-1567521464027-f127ff144326?w=60',
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEstablishmentInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Restaurante Exemplo', // TODO: Dados reais
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(4),
        Text(
          'Culinária Italiana • €€€', // TODO: Dados reais
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const Gap(8),
        _buildRatingRow(context),
      ],
    );
  }

  Widget _buildRatingRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 16,
          color: Colors.amber.shade600,
        ),
        const Gap(4),
        const Text(
          '4.5', // TODO: Dados reais
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          '(234 avaliações)', // TODO: Dados reais
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final isOpen = Random().nextBool();
    return StatusBadge.status(isOpen: isOpen);
  }
}
