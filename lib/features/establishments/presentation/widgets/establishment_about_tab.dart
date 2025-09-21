import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
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
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (establishmentDetail.hasDescription) ...[
              _buildDescriptionSection(),
              const Gap(24),
            ],
            _buildInformationSection(),
            const Gap(24),
            if (establishmentDetail.hasFacilities) ...[
              _buildFacilitiesSection(context),
              const Gap(24),
            ],
            if (establishmentDetail.hasPaymentMethods) ...[
              _buildPaymentMethodsSection(context),
              const Gap(24),
            ],
            const Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          establishmentDetail.description ?? '',
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        _buildInfoRow(Icons.location_on, establishmentDetail.address),
        if (establishmentDetail.hasPhone)
          _buildInfoRow(Icons.phone, establishmentDetail.phone!),
        if (establishmentDetail.openingHours != null)
          _buildInfoRow(Icons.access_time, establishmentDetail.openingHours!),
        _buildInfoRow(
          Icons.discount,
          'Desconto: ${establishmentDetail.discount}',
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
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
        const Text(
          'Facilidades',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: establishmentDetail.facilities
              .map<Widget>((facility) => _buildFacilityChip(context, facility))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildFacilityChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: context.theme.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Formas de Pagamento',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: establishmentDetail.paymentMethods
              .map<Widget>((method) => _buildPaymentChip(context, method))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.payment,
            size: 16,
            color: Colors.grey.shade700,
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
