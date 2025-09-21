import 'package:flutter/material.dart';

class EstablishmentPhotoCarousel extends StatefulWidget {
  const EstablishmentPhotoCarousel({
    super.key,
    required this.establishmentId,
  });

  final String establishmentId;

  @override
  State<EstablishmentPhotoCarousel> createState() =>
      _EstablishmentPhotoCarouselState();
}

class _EstablishmentPhotoCarouselState
    extends State<EstablishmentPhotoCarousel> {
  late PageController _photoController;
  int _currentPhotoIndex = 0;

  // TODO: Substituir por dados reais do provider
  final List<String> _photos = [
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
    'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800',
    'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800',
    'https://images.unsplash.com/photo-1567521464027-f127ff144326?w=800',
  ];

  @override
  void initState() {
    super.initState();
    _photoController = PageController();
  }

  @override
  void dispose() {
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Stack(
        children: [
          // Carrossel de fotos
          PageView.builder(
            controller: _photoController,
            onPageChanged: (index) {
              setState(() {
                _currentPhotoIndex = index;
              });
            },
            itemCount: _photos.length,
            itemBuilder: (context, index) {
              return _buildPhoto(_photos[index]);
            },
          ),

          // Indicadores de página
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: _buildPageIndicators(),
          ),

          // Gradiente no fundo para melhor legibilidade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 200,
            child: _buildGradientOverlay(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey.shade300,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade300,
          child: const Icon(
            Icons.broken_image,
            size: 50,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _photos.asMap().entries.map((entry) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPhotoIndex == entry.key
                ? Colors.white
                : Colors.white54,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black54,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
