import 'package:barpass_app/core/providers/onboarding_providers.dart';
import 'package:barpass_app/features/onboarding/models/onboarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<OnboardingStep> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const OnboardingStep(
        illustration: _buildPhoneIllustration,
        title: 'Conheça o\nbarpass',
        description:
            'Um aplicativo para você economizar de verdade quando sair para comer e beber. Os descontos são aplicado ao final da conta.',
      ),
      OnboardingStep(
        illustration: _buildDiscountIllustration,
        title: 'Descontos\nincríveis',
        description:
            'Encontre os melhores descontos nos seus restaurantes e bares favoritos da sua cidade.',
        backgroundColor: const Color(0xFFFF6B35),
        titleColor: Colors.white,
        descriptionColor: Colors.white.withValues(alpha: 0.9),
      ),
      const OnboardingStep(
        illustration: _buildPaymentIllustration,
        title: 'Pague com\nfacilidade',
        description:
            'Escaneie o QR Code da mesa, escolha seus itens e pague direto pelo app com total segurança.',
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    // Redirecionamento automático pelo GoRouter
  }

  Color _getBackgroundColor(BuildContext context, int pageIndex) {
    final theme = Theme.of(context);
    final page = _pages[pageIndex];

    if (page.backgroundColor != null) {
      return page.backgroundColor!;
    }

    return theme.scaffoldBackgroundColor;
  }

  Color _getTitleColor(BuildContext context, int pageIndex) {
    final theme = Theme.of(context);
    final page = _pages[pageIndex];

    if (page.titleColor != null) {
      return page.titleColor!;
    }

    return theme.colorScheme.onSurface;
  }

  Color _getDescriptionColor(BuildContext context, int pageIndex) {
    final theme = Theme.of(context);
    final page = _pages[pageIndex];

    if (page.descriptionColor != null) {
      return page.descriptionColor!;
    }

    return theme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor(context, _currentPage);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPageContent(context, _pages[index], index);
                  },
                ),
              ),

              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final titleColor = _getTitleColor(context, _currentPage);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentPage < _pages.length - 1)
            TextButton(
              onPressed: _completeOnboarding,
              style: TextButton.styleFrom(
                foregroundColor: titleColor,
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              child: const Text('PULAR'),
            ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    OnboardingStep page,
    int index,
  ) {
    final isCurrentPage = index == _currentPage;
    final titleColor = _getTitleColor(context, index);
    final descriptionColor = _getDescriptionColor(context, index);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Spacer(),

          SizedBox(
                height: 320,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildBackgroundShapes(context),

                    Center(child: page.illustration(context)),
                  ],
                ),
              )
              .animate(target: isCurrentPage ? 1 : 0)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),

          const Spacer(),

          Text(
                page.title,
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: titleColor,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              )
              .animate(target: isCurrentPage ? 1 : 0)
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideY(begin: 0.02, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 24),

          Text(
                page.description,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: descriptionColor,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
              .animate(target: isCurrentPage ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.02, end: 0, curve: Curves.easeOut),

          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildBackgroundShapes(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Stack(
      children: [
        Positioned(
          top: -20,
          left: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),

        Positioned(
          bottom: -30,
          right: -50,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(70),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = _currentPage == _pages.length - 1;

    Color getIndicatorActiveColor() {
      if (_currentPage == 1) {
        return Colors.white;
      }
      return theme.colorScheme.primary;
    }

    Color getIndicatorInactiveColor() {
      if (_currentPage == 1) {
        return Colors.white.withOpacity(0.4);
      }
      return theme.colorScheme.onSurfaceVariant.withOpacity(0.3);
    }

    Color getButtonBackgroundColor() {
      if (_currentPage == 1) {
        return Colors.white;
      }

      return theme.colorScheme.primary;
    }

    Color getButtonForegroundColor() {
      if (_currentPage == 1) {
        return const Color(0xFFFF6B35);
      }

      return theme.colorScheme.onPrimary;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          AnimatedSmoothIndicator(
                activeIndex: _currentPage,
                count: _pages.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: getIndicatorActiveColor(),
                  dotColor: getIndicatorInactiveColor(),
                  radius: 4,
                ),
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 400.ms)
              .slideY(begin: 0.02, end: 0),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                    onPressed: _nextPage,
                    style: FilledButton.styleFrom(
                      backgroundColor: getButtonBackgroundColor(),
                      foregroundColor: getButtonForegroundColor(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      isLastPage ? 'COMEÇAR' : 'PRÓXIMO',
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.02, end: 0),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildPhoneIllustration(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SizedBox(
      width: 200,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            left: 20,
            bottom: 20,
            child: SizedBox(
              width: 60,
              height: 120,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFFFFDBCC),
                    child: Text('👤', style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Text('👕\n👖', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 20,
            child: Container(
              width: 120,
              height: 200,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.black87,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.black,
                  width: 3,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'b',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('📱', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDiscountIllustration(BuildContext context) {
    return const SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.local_offer,
            size: 80,
            color: Colors.white,
          ),

          Positioned(
            top: 20,
            right: 30,
            child: Text('💰', style: TextStyle(fontSize: 32)),
          ),
          Positioned(
            bottom: 30,
            left: 40,
            child: Text('🎯', style: TextStyle(fontSize: 28)),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Text('⭐', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }

  static Widget _buildPaymentIllustration(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.qr_code_2,
            size: 100,
            color: theme.colorScheme.onSurface,
          ),

          const Positioned(
            top: 10,
            right: 20,
            child: Text('💳', style: TextStyle(fontSize: 32)),
          ),
          const Positioned(
            bottom: 20,
            left: 30,
            child: Text('✅', style: TextStyle(fontSize: 28)),
          ),
          const Positioned(
            top: 40,
            left: 10,
            child: Text('🔒', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
