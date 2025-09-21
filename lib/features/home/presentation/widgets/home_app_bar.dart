import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/common/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    required this.titleAnimation,
    required this.searchAnimation,
    super.key,
  });

  final Animation<double> titleAnimation;
  final Animation<double> searchAnimation;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0,
      backgroundColor: context.colorScheme.surface,
      surfaceTintColor: context.colorScheme.surfaceTint,
      title: AnimatedBuilder(
        animation: titleAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // Título original
              Opacity(
                opacity: titleAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, (1 - titleAnimation.value) * 10),
                  child: Transform.translate(
                    offset: const Offset(0, 6),
                    child: const LogoWidget(height: 26),
                  ),
                ),
              ),
              // Campo de pesquisa
              Opacity(
                opacity: searchAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, (1 - searchAnimation.value) * -10),
                  child: const _CompactSearchBar(),
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/notifications'),
          icon: Badge(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.notifications_outlined,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune),
          tooltip: 'Filtros',
        ),
      ],
    );
  }
}

// Barra de pesquisa compacta para a AppBar
class _CompactSearchBar extends StatelessWidget {
  const _CompactSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(
            Icons.search,
            size: 18,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Busque por bares...',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
