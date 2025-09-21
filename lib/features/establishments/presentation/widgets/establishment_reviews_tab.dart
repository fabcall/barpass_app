import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentReviewsTab extends StatelessWidget {
  const EstablishmentReviewsTab({
    super.key,
    required this.scrollController,
    required this.establishmentId,
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
            _buildReviewsSummary(context),
            const Gap(24),
            _buildReviewsHeader(),
            const Gap(16),
            ..._buildReviewsList(),
            const Gap(50), // Espaço extra para melhor scroll
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildOverallRating(context),
          const Gap(24),
          Expanded(
            child: _buildRatingBreakdown(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating(BuildContext context) {
    return Column(
      children: [
        Text(
          '4.5', // TODO: Dados reais
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade600,
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < 4 ? Icons.star : Icons.star_border,
              size: 16,
              color: Colors.amber.shade600,
            );
          }),
        ),
        const Gap(4),
        Text(
          '234 avaliações', // TODO: Dados reais
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBreakdown() {
    // TODO: Substituir por dados reais
    final ratings = [
      (5, 150),
      (4, 60),
      (3, 20),
      (2, 3),
      (1, 1),
    ];

    return Column(
      children: ratings
          .map((rating) => _buildRatingBar(rating.$1, rating.$2))
          .toList(),
    );
  }

  Widget _buildRatingBar(int stars, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$stars'),
          const Gap(8),
          Expanded(
            child: LinearProgressIndicator(
              value: count / 234, // TODO: Total real
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(Colors.amber.shade600),
            ),
          ),
          const Gap(8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return const Text(
      'Avaliações',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildReviewsList() {
    // TODO: Substituir por dados reais do provider
    final reviews = [
      ReviewData(
        'Maria Silva',
        5,
        'Excelente restaurante! A comida estava deliciosa e o atendimento foi impecável.',
        '2 dias atrás',
      ),
      ReviewData(
        'João Santos',
        4,
        'Ótima experiência, ambiente aconchegante e pratos bem preparados.',
        '1 semana atrás',
      ),
      ReviewData(
        'Ana Costa',
        5,
        'Melhor risotto que já comi! Voltarei com certeza.',
        '2 semanas atrás',
      ),
    ];

    return reviews.map((review) => _buildReviewItem(review)).toList();
  }

  Widget _buildReviewItem(ReviewData review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewHeader(review),
          const Gap(12),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const Gap(16),
          Divider(color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _buildReviewHeader(ReviewData review) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
          child: Text(
            review.name[0].toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < review.rating ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber.shade600,
                      );
                    }),
                  ),
                  const Gap(8),
                  Text(
                    review.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Model class for reviews
class ReviewData {
  final String name;
  final int rating;
  final String comment;
  final String time;

  ReviewData(this.name, this.rating, this.comment, this.time);
}
