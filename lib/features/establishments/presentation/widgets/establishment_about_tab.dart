import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentAboutTab extends StatelessWidget {
  const EstablishmentAboutTab({
    required this.scrollController,
    required this.establishmentDetail,
    super.key,
  });

  final ScrollController scrollController;
  final EstablishmentDetail establishmentDetail;

  @override
  Widget build(BuildContext context) {
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
            if (establishmentDetail.hasDescription) ...[
              _buildDescriptionSection(context),
              const Gap(AppSpacing.lg),
            ],
            _buildInformationSection(context),
            const Gap(AppSpacing.lg),
            if (establishmentDetail.hasFacilities) ...[
              _buildFacilitiesSection(context),
              const Gap(AppSpacing.lg),
            ],
            if (establishmentDetail.hasPaymentMethods) ...[
              _buildPaymentMethodsSection(context),
              const Gap(AppSpacing.lg),
            ],
            const Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(AppSpacing.sm),
        Text(
          establishmentDetail.description ?? '',
          style: context.textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildInformationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(AppSpacing.md),
        _buildInfoRow(
          context,
          Icons.location_on,
          establishmentDetail.address,
        ),
        if (establishmentDetail.hasPhone)
          _buildInfoRow(
            context,
            Icons.phone,
            establishmentDetail.phone!,
          ),
        if (establishmentDetail.openingHours != null)
          _buildInfoRow(
            context,
            Icons.access_time,
            establishmentDetail.openingHours!,
          ),
        _buildInfoRow(
          context,
          Icons.discount,
          'Desconto: ${establishmentDetail.discount}',
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilidades',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: establishmentDetail.facilities
              .map<Widget>((facility) => _buildFacilityChip(context, facility))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildFacilityChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Formas de Pagamento',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: establishmentDetail.paymentMethods
              .map<Widget>((method) => _buildPaymentChip(context, method))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.payment,
            size: 16,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const Gap(AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
