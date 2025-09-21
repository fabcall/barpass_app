import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:barpass_app/shared/widgets/base/carousel/carousel_indicator_widget.dart';
import 'package:barpass_app/shared/widgets/base/status_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({
    required this.establishments,
    super.key,
    this.height = 240.0,
    this.onEstablishmentTap,
  });

  final List<Establishment> establishments;
  final double height;
  final void Function(String establishmentId)? onEstablishmentTap;

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.establishments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          itemCount: widget.establishments.length,
          itemBuilder: (context, index, realIndex) {
            final establishment = widget.establishments[index];
            return _FeaturedEstablishmentCard(
              establishment: establishment,
              onTap: () => widget.onEstablishmentTap?.call(establishment.id),
            );
          },
        ),
        const Gap(AppSpacing.md),
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, index, child) => CarouselIndicatorWidget(
            activeIndex: index,
            count: widget.establishments.length,
            onDotPressed: _carouselController.animateToPage,
          ),
        ),
      ],
    );
  }
}

class _FeaturedEstablishmentCard extends StatelessWidget {
  const _FeaturedEstablishmentCard({
    required this.establishment,
    this.onTap,
  });

  final Establishment establishment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderLg,
          boxShadow: AppShadows.medium,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: AppRadius.borderLg,
              child: CachedNetworkImage(
                imageUrl: establishment.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(
                  color: context.colorScheme.surfaceContainerHighest,
                  child: const SizedBox.shrink(),
                ),
                errorWidget: (context, url, error) => ColoredBox(
                  color: context.colorScheme.primary,
                  child: Icon(
                    Icons.restaurant,
                    size: 48,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),

            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppRadius.borderLg,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.6, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),

            // Content
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: Row(
                children: [
                  // Logo
                  Avatar(
                    size: 60,
                    image: NetworkImage(
                      establishment.imageUrl,
                    ),
                    shape: const CircleAvatarShape(
                      borderColor: Colors.white,
                      borderWidth: 3,
                    ),
                    name: establishment.name,
                  ),

                  const Gap(AppSpacing.md),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          establishment.name,
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          establishment.address,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(AppSpacing.sm),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.warning,
                                    size: 16,
                                  ),
                                  const Gap(AppSpacing.xs),
                                  Text(
                                    establishment.rating.toString(),
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const Gap(2),
                                  Text(
                                    '(${establishment.reviewCount})',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              establishment.distance,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Discount badge
            Positioned(
              top: AppSpacing.md,
              right: AppSpacing.md,
              child: StatusBadge.warning(label: establishment.discount),
            ),
          ],
        ),
      ),
    );
  }
}
