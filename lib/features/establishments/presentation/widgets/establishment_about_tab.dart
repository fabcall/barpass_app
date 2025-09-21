import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentAboutTab extends StatelessWidget {
  const EstablishmentAboutTab({
    required this.scrollController,
    required this.establishmentId,
    super.key,
  });

  final ScrollController scrollController;
  final String establishmentId;

  @override
  Widget build(BuildContext context) {
    // TODO: Substituir por dados reais do provider
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom, // Padding para safe area
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDescriptionSection(),
            const Gap(24),
            _buildInformationSection(),
            const Gap(24),
            _buildFacilitiesSection(context),
            const Gap(50), // Espaço extra para melhor scroll
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Text(
          'Um restaurante aconchegante especializado em culinária italiana autêntica. Oferecemos pratos tradicionais preparados com ingredientes frescos e importados diretamente da Itália.',
          style: TextStyle(fontSize: 16, height: 1.5),
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
        _buildInfoRow(Icons.location_on, 'Rua das Flores, 123 - Centro'),
        _buildInfoRow(Icons.phone, '+55 11 9999-9999'),
        _buildInfoRow(Icons.access_time, 'Seg - Dom: 18:00 - 23:00'),
        _buildInfoRow(Icons.credit_card, 'Cartão, PIX, Dinheiro'),
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
    // TODO: Substituir por dados reais
    final facilities = [
      'Wi-Fi Gratuito',
      'Estacionamento',
      'Acessível',
      'Pet Friendly',
      'Reservas',
    ];

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
          children: facilities
              .map((facility) => _buildFacilityChip(context, facility))
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
}
