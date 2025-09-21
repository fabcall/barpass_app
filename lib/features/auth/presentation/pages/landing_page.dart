import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/animations/bouncer.dart';
import 'package:barpass_app/shared/widgets/base/logos/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  // Constantes específicas das animações desta página
  static const _floatDuration = Duration(milliseconds: 3500);
  static const _secondaryDuration = Duration(milliseconds: 2500);

  // Constantes de posicionamento dos elementos decorativos
  static const _element1Top = 100.0;
  static const _element1Right = 50.0;
  static const _element2Top = 200.0;
  static const _element2Left = 30.0;
  static const _element3Bottom = 300.0;
  static const _element3Left = 60.0;
  static const _element4Top = 350.0;
  static const _element4Right = 80.0;
  static const _element5Bottom = 450.0;
  static const _element5Right = 120.0;
  static const _element6Top = 150.0;
  static const _element6Left = 100.0;

  // Tamanhos dos elementos decorativos
  static const _element1Size = 80.0;
  static const _element2Size = 60.0;
  static const _element3Size = 45.0;
  static const _element4Size = 55.0;
  static const _element5Size = 35.0;
  static const _element6Size = 25.0;

  late AnimationController _floatingController;
  late AnimationController _secondaryController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _secondaryAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: _floatDuration,
      vsync: this,
    );

    _secondaryController = AnimationController(
      duration: _secondaryDuration,
      vsync: this,
    );

    _floatingAnimation =
        Tween<double>(
          begin: -12,
          end: 12,
        ).animate(
          CurvedAnimation(
            parent: _floatingController,
            curve: Curves.easeInOut,
          ),
        );

    _secondaryAnimation =
        Tween<double>(
          begin: -15,
          end: 15,
        ).animate(
          CurvedAnimation(
            parent: _secondaryController,
            curve: Curves.easeInOut,
          ),
        );

    _floatingController.repeat(reverse: true);
    _secondaryController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: context.colorScheme.surface,
          ),
          _buildBackgroundElements(),
          Center(
            child: const LogoWidget(height: 64)
                .animate()
                .fadeIn(
                  duration: 800.ms,
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: 800.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildButtonSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        _buildElement1(),
        _buildElement2(),
        _buildElement3(),
        _buildElement4(),
        _buildElement5(),
        _buildElement6(),
      ],
    );
  }

  Widget _buildElement1() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          top: _element1Top + _floatingAnimation.value,
          right: _element1Right + (_secondaryAnimation.value * 0.5),
          child:
              Container(
                    width: _element1Size,
                    height: _element1Size,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: AppOpacity.medium),
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 300.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 300.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(begin: 0, end: 0.1, duration: 8000.ms)
                  .then()
                  .rotate(begin: 0.1, end: -0.1, duration: 8000.ms)
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1, end: 1.15, duration: 4000.ms)
                  .then()
                  .scaleXY(begin: 1.15, end: 1, duration: 4000.ms),
        );
      },
    );
  }

  Widget _buildElement2() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          top: _element2Top + (_floatingAnimation.value * 0.8),
          left: _element2Left + (_secondaryAnimation.value * 0.7),
          child:
              Container(
                    width: _element2Size,
                    height: _element2Size,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withValues(
                        alpha: AppOpacity.light,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 500.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 500.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(
                    begin: 0,
                    end: 2,
                    duration: 20000.ms,
                    curve: Curves.linear,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1, end: 1.2, duration: 3000.ms)
                  .then()
                  .scaleXY(begin: 1.2, end: 0.9, duration: 3000.ms)
                  .then()
                  .scaleXY(begin: 0.9, end: 1, duration: 3000.ms),
        );
      },
    );
  }

  Widget _buildElement3() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          bottom: _element3Bottom + (_secondaryAnimation.value * 1.2),
          left: _element3Left + (_floatingAnimation.value * 0.6),
          child:
              Container(
                    width: _element3Size,
                    height: _element3Size,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFF6B35,
                      ).withValues(alpha: AppOpacity.subtle),
                      borderRadius: BorderRadius.circular(22),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 700.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 700.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .custom(
                    duration: 2000.ms,
                    builder: (context, value, child) => Opacity(
                      opacity: 0.5 + (0.5 * value),
                      child: child,
                    ),
                  )
                  .then()
                  .custom(
                    duration: 2000.ms,
                    builder: (context, value, child) => Opacity(
                      opacity: 1.0 - (0.5 * value),
                      child: child,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(begin: 0, end: -0.2, duration: 5000.ms)
                  .then()
                  .rotate(begin: -0.2, end: 0.2, duration: 5000.ms)
                  .then()
                  .rotate(begin: 0.2, end: 0, duration: 5000.ms),
        );
      },
    );
  }

  Widget _buildElement4() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          top: _element4Top - (_floatingAnimation.value * 0.9),
          right: _element4Right - (_secondaryAnimation.value * 0.8),
          child:
              Container(
                    width: _element4Size,
                    height: _element4Size,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: AppOpacity.light),
                      borderRadius: AppRadius.borderMd,
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 900.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 900.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(
                    begin: 0,
                    end: 1,
                    duration: 12000.ms,
                    curve: Curves.linear,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1, end: 1.3, duration: 4500.ms)
                  .then()
                  .scaleXY(begin: 1.3, end: 0.8, duration: 4500.ms)
                  .then()
                  .scaleXY(begin: 0.8, end: 1, duration: 4500.ms),
        );
      },
    );
  }

  Widget _buildElement5() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          bottom: _element5Bottom,
          right: _element5Right + (_floatingAnimation.value * 0.4),
          child:
              Container(
                    width: _element5Size,
                    height: _element5Size,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFF6B35,
                      ).withValues(alpha: AppOpacity.medium),
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 1100.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 1100.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1, end: 1.4, duration: 2500.ms)
                  .then()
                  .scaleXY(begin: 1.4, end: 1, duration: 2500.ms)
                  .animate(onPlay: (controller) => controller.repeat())
                  .custom(
                    duration: 3000.ms,
                    builder: (context, value, child) => Opacity(
                      opacity: 0.3 + (0.7 * value),
                      child: child,
                    ),
                  )
                  .then()
                  .custom(
                    duration: 3000.ms,
                    builder: (context, value, child) => Opacity(
                      opacity: 1.0 - (0.7 * value),
                      child: child,
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildElement6() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _secondaryAnimation]),
      builder: (context, child) {
        return Positioned(
          top: _element6Top + (_secondaryAnimation.value * 0.3),
          left: _element6Left + (_floatingAnimation.value * 1.1),
          child:
              Container(
                    width: _element6Size,
                    height: _element6Size,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withValues(
                        alpha: AppOpacity.subtle,
                      ),
                      borderRadius: AppRadius.borderSm,
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 1300.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.4,
                    end: 0,
                    delay: 1300.ms,
                    duration: 700.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .then()
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(
                    begin: 0,
                    end: -1,
                    duration: 8000.ms,
                    curve: Curves.linear,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1, end: 1.6, duration: 3500.ms)
                  .then()
                  .scaleXY(begin: 1.6, end: 1, duration: 3500.ms),
        );
      },
    );
  }

  Widget _buildButtonSection() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          const Size.fromWidth(AppSizes.contentMaxWidthSm),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: context.viewPadding.bottom + AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Bouncer(
                    onTap: context.navigate.auth.goLogin,
                    child: FilledButton(
                      onPressed: context.navigate.auth.goLogin,
                      child: const Text('Entrar com minha conta'),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 1000.ms,
                    duration: 800.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    delay: 1000.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const Gap(AppSpacing.componentGap),
              Bouncer(
                    onTap: context.navigate.auth.goRegister,
                    child: OutlinedButton(
                      onPressed: context.navigate.auth.goRegister,
                      child: const Text('Cadastrar uma nova conta'),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 1200.ms,
                    duration: 800.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    delay: 1200.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const Gap(AppSpacing.componentGap),
              Bouncer(
                    onTap: context.navigate.goHome,
                    child: TextButton(
                      onPressed: context.navigate.goHome,
                      child: const Text('Entrar como convidado'),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: 1400.ms,
                    duration: 800.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    delay: 1400.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
