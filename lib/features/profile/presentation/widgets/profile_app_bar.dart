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
      duration: AppDuration.medium,
      vsync: this,
    );

    _spaceAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainAnimationController,
        curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _avatarAnimation = Tween<double>(begin: 0, end: 1).animate(
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

  static const double expandedAppBarHeight = 220;

  String? get _displayName => widget.user?.name.split(' ').first;

  String get _welcomeMessage {
    if (widget.user == null) {
      return 'Cadastre-se agora e aproveite todos os benefícios do barpass';
    }
    return 'Aproveite os melhores descontos da cidade';
  }

  String get _greeting {
    if (widget.user == null) return 'Olá, seja bem vindo';
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
      expandedHeight: expandedAppBarHeight,
      pinned: true,
      title: AnimatedBuilder(
        animation: _mainAnimationController,
        builder: (context, child) {
          return Row(
            children: [
              AnimatedClipAlign(
                alignment: Alignment.centerLeft,
                innerAlignment: Alignment.centerLeft,
                animation: _spaceAnimation,
                builder: (context, animation) {
                  return SizedBox(
                    width: AppSizes.avatarSm + AppSpacing.md,
                    height: AppSizes.avatarSm,
                    child: _avatarAnimation.value > 0
                        ? Transform.translate(
                            offset: Offset(
                              0,
                              AppSizes.avatarSm * (1 - _avatarAnimation.value),
                            ),
                            child: Avatar(
                              size: AppSizes.avatarSm,
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
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                80,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Row(
                children: [
                  Avatar(
                    size: AppSizes.avatarLg,
                    name: widget.user?.name,
                    image: widget.user?.avatarUrl != null
                        ? NetworkImage(widget.user!.avatarUrl!)
                        : null,
                    child: widget.user == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
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
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _welcomeMessage,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        if (widget.user != null) ...[
                          const SizedBox(height: AppSpacing.sm),
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
