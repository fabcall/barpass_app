import 'package:barpass_app/features/home/models/carousel_item.dart';
import 'package:barpass_app/shared/widgets/carousel/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeaturedCarousel extends StatefulWidget {
  final List<CarouselItem>? items;
  final double height;

  const FeaturedCarousel({
    super.key,
    this.items,
    this.height = 240.0,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<CarouselItem> get _items =>
      widget.items ??
      List.generate(
        5,
        (index) => CarouselItem(
          id: index.toString(),
          title: 'text ${index + 1}',
        ),
      );

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          itemCount: _items.length,
          itemBuilder: (context, index, realIndex) {
            return CarouselItemWidget(item: _items[index]);
          },
        ),
        const Gap(16),
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, index, child) => CarouselIndicator(
            activeIndex: index,
            count: _items.length,
            onDotClicked: _carouselController.animateToPage,
          ),
        ),
        const Gap(16),
      ],
    );
  }
}

class CarouselItemWidget extends StatelessWidget {
  final CarouselItem item;

  const CarouselItemWidget({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          image: const DecorationImage(
            image: NetworkImage(
              'https://lirp.cdn-website.com/3a0c1a25/dms3rep/multi/opt/DSCF0421023Aweb-1500x1042-1920w.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
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
          child: Stack(
            children: [
              // Main content - logo + info
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    // Logo circular
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=200&h=200&fit=crop&crop=center',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.white,
                                child: const Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Info do estabelecimento
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Barbecue Grill',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Rua Augusta, 77 • São Paulo - SP',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              // Rating
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
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
                                    const Text(
                                      '4.9',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '(1.400)',
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),

                              // Distance
                              Text(
                                '14,19KM',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
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
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    '5% a 10%',
                    style: TextStyle(
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
      ),
    );
  }
}
