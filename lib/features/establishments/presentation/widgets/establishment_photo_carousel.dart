import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class EstablishmentPhotoCarousel extends StatefulWidget {
  const EstablishmentPhotoCarousel({
    required this.establishmentId,
    super.key,
  });

  final String establishmentId;

  @override
  State<EstablishmentPhotoCarousel> createState() =>
      _EstablishmentPhotoCarouselState();
}

class _EstablishmentPhotoCarouselState
    extends State<EstablishmentPhotoCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  // Lista de fotos mock - substitua pela sua fonte de dados
  final List<String> _photos = [
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
    'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=800',
    'https://images.unsplash.com/photo-1552566063-b4e07ecc4e78?w=800',
    'https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=800',
  ];

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

    // Altura disponível para o carrossel (60% da tela + altura das bordas arredondadas)
    final carouselHeight =
        screenHeight * 0.4 + 20; // +20 para cobrir as bordas arredondadas

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
            itemCount: _photos.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: carouselHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_photos[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay gradiente para melhor legibilidade
                child: Container(
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
              );
            },
          ),

          // Contador de fotos (opcional)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              margin: const EdgeInsets.only(
                bottom: 40,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.inverseSurface.withValues(
                  alpha: 0.6,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${_currentIndex + 1} / ${_photos.length}',
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
