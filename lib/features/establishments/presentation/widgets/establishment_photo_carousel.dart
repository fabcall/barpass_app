import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EstablishmentPhotoCarousel extends StatefulWidget {
  const EstablishmentPhotoCarousel({
    required this.establishmentId,
    required this.photos,
    super.key,
  });

  final String establishmentId;
  final List<String> photos;

  @override
  State<EstablishmentPhotoCarousel> createState() =>
      _EstablishmentPhotoCarouselState();
}

class _EstablishmentPhotoCarouselState
    extends State<EstablishmentPhotoCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    final carouselHeight = screenHeight * 0.4 + 20;

    // Se não há fotos, usa uma imagem placeholder
    final photos = widget.photos.isNotEmpty
        ? widget.photos
        : ['https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800'];

    return SizedBox(
      height: carouselHeight,
      child: Stack(
        children: [
          // PageView com as fotos
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Imagem com cache e fade
                  CachedNetworkImage(
                    imageUrl: photos[index],
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 300),
                    fadeOutDuration: const Duration(milliseconds: 100),
                    placeholder: (context, url) => Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // Overlay gradiente
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Contador de fotos
          if (photos.length > 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  color: context.colorScheme.inverseSurface.withValues(
                    alpha: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${photos.length}',
                  style: TextStyle(
                    color: context.colorScheme.onInverseSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
