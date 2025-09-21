import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/common/animated_clip_align.dart';
import 'package:barpass_app/shared/widgets/common/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppBar extends StatefulWidget {
  const ProfileAppBar({
    required this.isCollapsed,
    super.key,
  });

  final bool isCollapsed;

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late Animation<double> _spaceAnimation;
  late Animation<double> _avatarAnimation;

  @override
  void initState() {
    super.initState();

    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Primeira etapa: espaço para o avatar se expande (empurra o título)
    _spaceAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    // Segunda etapa: avatar sobe de baixo para cima
    _avatarAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProfileAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      if (widget.isCollapsed) {
        _mainAnimationController.forward();
      } else {
        _mainAnimationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      title: AnimatedBuilder(
        animation: _mainAnimationController,
        builder: (context, child) {
          return Row(
            children: [
              // Espaço que se expande para "empurrar" o título para a direita
              AnimatedClipAlign(
                alignment: Alignment.centerLeft,
                innerAlignment: Alignment.centerLeft,
                axis: Axis.horizontal,
                animation: _spaceAnimation,
                builder: (context, animation) {
                  return SizedBox(
                    width: 44, // 32 (avatar) + 12 (margin)
                    height: 32,
                    child: _avatarAnimation.value > 0
                        ? Transform.translate(
                            offset: Offset(
                              0,
                              32 * (1 - _avatarAnimation.value),
                            ),
                            child: const Avatar(
                              size: 32,
                              image: NetworkImage('https://i.pravatar.cc/80'),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),

              // Título que é sempre visível, mas é empurrado para a direita
              const Text('perfil'),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/perfil/configuracoes'),
          icon: Icon(
            Icons.settings_outlined,
            color: context.colorScheme.onSurfaceVariant,
          ),
          tooltip: 'Configurações',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
              child: Row(
                children: [
                  // Avatar do usuário
                  const Avatar(
                    size: 80,
                    image: NetworkImage('https://i.pravatar.cc/80'),
                  ),

                  const SizedBox(width: 16),

                  // Informações do usuário
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, seja bem vindo',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cadastre-se agora e aproveite todos os benefícios do barpass',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
