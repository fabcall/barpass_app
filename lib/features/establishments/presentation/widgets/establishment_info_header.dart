import 'package:barpass_app/core/theme/tokens/tokens.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/widgets/avatar_widget.dart';
import 'package:barpass_app/shared/widgets/base/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentInfoHeader extends StatelessWidget {
  const EstablishmentInfoHeader({
    required this.establishmentDetail,
    super.key,
  });

  final EstablishmentDetail establishmentDetail;

  @override
  Widget build(BuildContext context) {
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
    return Avatar(
      image: NetworkImage(
        establishmentDetail.logoUrl,
      ),
      size: AppSizes.avatarMd,
    );
  }

  Widget _buildEstablishmentInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          establishmentDetail.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(4),
        Text(
          '${establishmentDetail.categories.join(" • ")} • €€€',
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
        Text(
          establishmentDetail.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          '(${establishmentDetail.reviewCount} avaliações)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return StatusBadge.status(isOpen: establishmentDetail.isOpen ?? false);
  }
}
