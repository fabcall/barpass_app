import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:barpass_app/shared/widgets/base/rating/rating_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentReviewsTab extends StatefulWidget {
  const EstablishmentReviewsTab({
    required this.scrollController,
    required this.establishmentDetail,
    super.key,
  });

  final ScrollController scrollController;
  final EstablishmentDetail establishmentDetail;

  @override
  State<EstablishmentReviewsTab> createState() =>
      _EstablishmentReviewsTabState();
}

class _EstablishmentReviewsTabState extends State<EstablishmentReviewsTab>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _ratingAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _ratingAnimation =
        Tween<double>(
          begin: 0,
          end: widget.establishmentDetail.rating,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.establishmentDetail.hasReviews) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const Gap(16),
              const Text(
                'Sem avaliações ainda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              Text(
                'Seja o primeiro a avaliar este estabelecimento!',
                style: TextStyle(
                  fontSize: 14,
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
      controller: widget.scrollController,
      clipBehavior: Clip.none,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          24,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReviewsSummary(context),
            const Gap(24),
            _buildReviewsHeader(),
            const Gap(16),
            ..._buildReviewsList(),
            const Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildOverallRating(context),
          const Gap(24),
          Expanded(
            child: RatingBarChart(
              ratings: widget.establishmentDetail.ratingDistribution,
              barColor: Colors.amber.shade600,
              barBackgroundColor: Colors.grey.shade200,
              ratingNumberWidth: 12,
              animationDuration: const Duration(milliseconds: 1500),
              animationCurve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating(BuildContext context) {
    return AnimatedBuilder(
      animation: _ratingAnimation,
      builder: (context, child) {
        return Column(
          children: [
            Text(
              _ratingAnimation.value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade600,
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < _ratingAnimation.value
                      ? Icons.star
                      : Icons.star_border,
                  size: 16,
                  color: Colors.amber.shade600,
                );
              }),
            ),
            const Gap(4),
            Text(
              '${widget.establishmentDetail.reviewCount} avaliações',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        );
      },
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
    return widget.establishmentDetail.reviews
        .map<Widget>(_buildReviewItem)
        .toList();
  }

  Widget _buildReviewItem(Review review) {
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

  Widget _buildReviewHeader(Review review) {
    return Row(
      children: [
        Avatar(
          backgroundColor: Colors.grey.shade300,
          size: 40,
          name: review.userName,
          image: review.hasAvatar ? NetworkImage(review.userAvatarUrl!) : null,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.userName,
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
                    review.timeAgo,
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
