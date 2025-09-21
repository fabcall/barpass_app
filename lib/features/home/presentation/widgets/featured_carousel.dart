import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/carousel/carousel_indicator_widget.dart';
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
  final void Function(Establishment)? onEstablishmentTap;

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
              onTap: () => widget.onEstablishmentTap?.call(establishment),
            );
          },
        ),
        const Gap(16),
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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: establishment.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: context.colorScheme.surfaceContainerHighest,
                  child:
                      const SizedBox.shrink(), // Remove o CircularProgressIndicator
                ),
                errorWidget: (context, url, error) => Container(
                  color: context.colorScheme.primary,
                  child: const Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.6, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),

            // Content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: establishment.logoUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ColoredBox(
                          color: Colors.white,
                          child:
                              SizedBox.shrink(), // Remove o CircularProgressIndicator
                        ),
                        errorWidget: (context, url, error) => const ColoredBox(
                          color: Colors.white,
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          establishment.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          establishment.address,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    establishment.rating.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '(${establishment.reviewCount})',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              establishment.distance,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
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
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  establishment.discount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
