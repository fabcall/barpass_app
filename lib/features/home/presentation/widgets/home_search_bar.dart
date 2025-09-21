import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: _HomeSearchBarDelegate(),
    );
  }
}

class _HomeSearchBarDelegate extends SliverPersistentHeaderDelegate {
  static const horizontalPadding = 16.0;
  static const verticalPadding = 16.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SearchBarWidget(),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight + verticalPadding * 2;

  @override
  double get minExtent => kToolbarHeight + verticalPadding * 2;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// Widget da barra de pesquisa
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.navigate.pushSearch(),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: kToolbarHeight,
          decoration: ShapeDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            shape: StadiumBorder(
              side: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.search,
                color: context.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Busque por bares, restaurantes...',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
