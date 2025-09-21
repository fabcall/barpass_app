import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:barpass_app/shared/widgets/animations/animated_clip_align.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:barpass_app/shared/widgets/base/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppBar extends StatefulWidget {
  const ProfileAppBar({
    required this.isCollapsed,
    required this.user,
    super.key,
  });

  final bool isCollapsed;
  final User? user;

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
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    // Segunda etapa: avatar sobe de baixo para cima
    _avatarAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.4, 1, curve: Curves.easeOutCubic),
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

  String? get _displayName {
    return widget.user?.name.split(' ').first;
  }

  String get _welcomeMessage {
    if (widget.user == null) {
      return 'Cadastre-se agora e aproveite todos os benefícios do barpass';
    }
    return 'Aproveite os melhores descontos da cidade';
  }

  String get _greeting {
    if (widget.user == null) {
      return 'Olá, seja bem vindo';
    }
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Bom dia'
        : hour < 18
        ? 'Boa tarde'
        : 'Boa noite';
    return '$greeting, $_displayName';
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      title: AnimatedBuilder(
        animation: _mainAnimationController,
        builder: (context, child) {
          return Row(
            children: [
              // Espaço que se expande para "empurrar" o título para a direita
              AnimatedClipAlign(
                alignment: Alignment.centerLeft,
                innerAlignment: Alignment.centerLeft,
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
                            child: Avatar(
                              size: 32,
                              name: widget.user?.name,
                              image: widget.user?.avatarUrl != null
                                  ? NetworkImage(widget.user!.avatarUrl!)
                                  : null,
                              child: widget.user == null
                                  ? const Icon(Icons.person)
                                  : null,
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
                  // Avatar do usuário - o widget gera automaticamente
                  // o gradiente, iniciais e trata a imagem
                  Avatar(
                    size: 80,
                    name: widget.user?.name,
                    image: widget.user?.avatarUrl != null
                        ? NetworkImage(widget.user!.avatarUrl!)
                        : null,
                    child: widget.user == null
                        ? const Icon(Icons.person)
                        : null,
                  ),

                  const SizedBox(width: 16),

                  // Informações do usuário
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _welcomeMessage,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        if (widget.user != null) ...[
                          const SizedBox(height: 8),
                          StatusBadge.verified(),
                        ],
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
