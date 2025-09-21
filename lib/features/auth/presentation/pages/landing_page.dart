import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/animations/bouncer.dart';
import 'package:barpass_app/shared/widgets/base/logos/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _secondaryController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _secondaryAnimation;

  @override
  void initState() {
    super.initState();

    // Controller principal para movimento flutuante
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    // Controller secundário para movimentos mais rápidos
    _secondaryController = AnimationController(
      duration: const Duration(milliseconds: 2500),
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
          // Background com cor padrão do tema
          Container(
            color: context.colorScheme.surface,
          ),

          // Elementos decorativos com fade in up
          _buildBackgroundElements(),

          // Logo centralizado com fade in up
          Center(
            child: const LogoWidget(height: 64)
                .animate()
                .fadeIn(
                  duration: 800.ms,
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.3, // Movimento mais pronunciado
                  end: 0,
                  duration: 800.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),

          // Container de botões com fade in up em cascata
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
        // Elemento decorativo 1
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              top: 100 + _floatingAnimation.value,
              right: 50 + (_secondaryAnimation.value * 0.5),
              child:
                  Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.12),
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
                      .rotate(
                        begin: 0,
                        end: 0.1,
                        duration: 8000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .rotate(
                        begin: 0.1,
                        end: -0.1,
                        duration: 8000.ms,
                        curve: Curves.easeInOut,
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(
                        begin: 1,
                        end: 1.15,
                        duration: 4000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 1.15,
                        end: 1,
                        duration: 4000.ms,
                        curve: Curves.easeInOut,
                      ),
            );
          },
        ),

        // Elemento decorativo 2
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              top: 200 + (_floatingAnimation.value * 0.8),
              left: 30 + (_secondaryAnimation.value * 0.7),
              child:
                  Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withValues(alpha: 0.15),
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
                      .scaleXY(
                        begin: 1,
                        end: 1.2,
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 1.2,
                        end: 0.9,
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 0.9,
                        end: 1,
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                      ),
            );
          },
        ),

        // Elemento decorativo 3
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              bottom: 300 + (_secondaryAnimation.value * 1.2),
              left: 60 + (_floatingAnimation.value * 0.6),
              child:
                  Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
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
                        curve: Curves.easeInOut,
                        builder: (context, value, child) => Opacity(
                          opacity: 0.5 + (0.5 * value),
                          child: child,
                        ),
                      )
                      .then()
                      .custom(
                        duration: 2000.ms,
                        curve: Curves.easeInOut,
                        builder: (context, value, child) => Opacity(
                          opacity: 1.0 - (0.5 * value),
                          child: child,
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .rotate(
                        begin: 0,
                        end: -0.2,
                        duration: 5000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .rotate(
                        begin: -0.2,
                        end: 0.2,
                        duration: 5000.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .rotate(
                        begin: 0.2,
                        end: 0,
                        duration: 5000.ms,
                        curve: Curves.easeInOut,
                      ),
            );
          },
        ),

        // Elemento decorativo 4
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              top: 350 - (_floatingAnimation.value * 0.9),
              right: 80 - (_secondaryAnimation.value * 0.8),
              child:
                  Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
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
                      .scaleXY(
                        begin: 1,
                        end: 1.3,
                        duration: 4500.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 1.3,
                        end: 0.8,
                        duration: 4500.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 0.8,
                        end: 1,
                        duration: 4500.ms,
                        curve: Curves.easeInOut,
                      ),
            );
          },
        ),

        // Elemento decorativo 5
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              bottom: 450,
              right: 120 + (_floatingAnimation.value * 0.4),
              child:
                  Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFF6B35,
                          ).withValues(alpha: 0.12),
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
                      .scaleXY(
                        begin: 1,
                        end: 1.4,
                        duration: 2500.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 1.4,
                        end: 1,
                        duration: 2500.ms,
                        curve: Curves.easeInOut,
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .custom(
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                        builder: (context, value, child) => Opacity(
                          opacity: 0.3 + (0.7 * value),
                          child: child,
                        ),
                      )
                      .then()
                      .custom(
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                        builder: (context, value, child) => Opacity(
                          opacity: 1.0 - (0.7 * value),
                          child: child,
                        ),
                      ),
            );
          },
        ),

        // Elemento decorativo 6
        AnimatedBuilder(
          animation: Listenable.merge([
            _floatingAnimation,
            _secondaryAnimation,
          ]),
          builder: (context, child) {
            return Positioned(
              top: 150 + (_secondaryAnimation.value * 0.3),
              left: 100 + (_floatingAnimation.value * 1.1),
              child:
                  Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
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
                      .scaleXY(
                        begin: 1,
                        end: 1.6,
                        duration: 3500.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scaleXY(
                        begin: 1.6,
                        end: 1,
                        duration: 3500.ms,
                        curve: Curves.easeInOut,
                      ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildButtonSection() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size.fromWidth(360)),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: context.viewPadding.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Botão 1 - Entrar
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

              const SizedBox(height: 12),

              // Botão 2 - Cadastrar
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

              const SizedBox(height: 12),

              // Botão 3 - Convidado
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
