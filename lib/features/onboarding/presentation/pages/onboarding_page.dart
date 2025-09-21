import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingStep {
  const OnboardingStep({
    required this.illustration,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
  });

  final Widget Function(BuildContext) illustration;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
}

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
        title: 'conheça o\nbarpass',
        description:
            'Um aplicativo para você economizar de verdade quando sair para comer e beber. Os descontos são aplicado ao final da conta.',
      ),
      OnboardingStep(
        illustration: _buildDiscountIllustration,
        title: 'descontos\nincríveis',
        description:
            'Encontre os melhores descontos nos seus restaurantes e bares favoritos da sua cidade.',
        backgroundColor: const Color(0xFFFF6B35),
        titleColor: Colors.white,
        descriptionColor: Colors.white.withValues(alpha: 0.9),
      ),
      const OnboardingStep(
        illustration: _buildPaymentIllustration,
        title: 'pague com\nfacilidade',
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
    await ref.read(onboardingProvider.notifier).markAsCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background que muda baseado na página atual
          _buildAnimatedBackground(context),

          // Conteúdo principal
          SafeArea(
            child: Column(
              children: [
                // Header com altura fixa para evitar shifts
                SizedBox(
                  height: 56, // Altura padrão de AppBar
                  child: _buildHeader(context),
                ),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _pages.length,
                    // Usar physics que não interfere com o layout
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      // Cada página é completamente independente
                      return _OnboardingPageContent(
                        key: ValueKey(
                          'page_$index',
                        ), // Key única para cada página
                        page: _pages[index],
                        pageIndex: index,
                        isCurrentPage: index == _currentPage,
                      );
                    },
                  ),
                ),

                // Footer com altura dinâmica baseada no safe area
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(BuildContext context) {
    final currentPage = _pages[_currentPage];

    final backgroundColor =
        currentPage.backgroundColor ?? context.theme.scaffoldBackgroundColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final currentPage = _pages[_currentPage];
    final titleColor = currentPage.titleColor ?? context.colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentPage < _pages.length - 1)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: TextButton(
                key: ValueKey('skip_$_currentPage'),
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
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    // Cores baseadas na página atual
    Color getIndicatorActiveColor() {
      if (_currentPage == 1) {
        return Colors.white;
      }
      return context.colorScheme.primary;
    }

    Color getIndicatorInactiveColor() {
      if (_currentPage == 1) {
        return Colors.white.withValues(alpha: 0.4);
      }
      return context.colorScheme.onSurfaceVariant.withValues(alpha: 0.3);
    }

    Color getButtonBackgroundColor() {
      if (_currentPage == 1) {
        return Colors.white;
      }
      return context.colorScheme.primary;
    }

    Color getButtonForegroundColor() {
      if (_currentPage == 1) {
        return const Color(0xFFFF6B35);
      }
      return context.colorScheme.onPrimary;
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg + MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Importante: usar min ao invés de max
        children: [
          // Indicador de páginas
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
          ),

          const SizedBox(height: 32),

          // Botão
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: FilledButton(
                  onPressed: _nextPage,
                  style: FilledButton.styleFrom(
                    backgroundColor: getButtonBackgroundColor(),
                    foregroundColor: getButtonForegroundColor(),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildPhoneIllustration(BuildContext context) {
    final isDarkMode = context.theme.brightness == Brightness.dark;

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
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.black,
                  width: 3,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  borderRadius: AppRadius.borderLg,
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
                          color: context.colorScheme.primary,
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
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.qr_code_2,
            size: 100,
            color: context.colorScheme.onSurface,
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

// Widget separado para cada página para evitar interferência
class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({
    required super.key,
    required this.page,
    required this.pageIndex,
    required this.isCurrentPage,
  });

  final OnboardingStep page;
  final int pageIndex;
  final bool isCurrentPage;

  @override
  Widget build(BuildContext context) {
    // Cores específicas desta página
    final titleColor = page.titleColor ?? context.colorScheme.onSurface;
    final descriptionColor =
        page.descriptionColor ?? context.colorScheme.onSurfaceVariant;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),

          // Ilustração
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

          // Título - usando Comfortaa
          RepaintBoundary(
                child: Text(
                  page.title,
                  style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    height: 1.1,
                  ).copyWith(color: titleColor),
                  textAlign: TextAlign.center,
                ),
              )
              .animate(target: isCurrentPage ? 1 : 0)
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideY(begin: 0.02, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 24),

          // Descrição - usando fonte padrão do tema
          RepaintBoundary(
                child: Text(
                  page.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: descriptionColor,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
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
    final primaryColor = context.colorScheme.primary;

    return Stack(
      children: [
        Positioned(
          top: -20,
          left: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.pill * 2.25),
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
              color: primaryColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.pill * 1.75),
            ),
          ),
        ),
      ],
    );
  }
}
