import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/common/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 152,
      collapsedHeight: kToolbarHeight + 50,
      scrolledUnderElevation: 0,
      backgroundColor: context.colorScheme.surface,
      surfaceTintColor: context.colorScheme.surfaceTint,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'barpass',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => context.push('/notifications'),
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            color: context.colorScheme.onSurface,
                          ),
                          // Notification badge
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      tooltip: 'Notificações',
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implementar lógica do filtro
                      },
                      icon: const Icon(Icons.tune),
                      tooltip: 'Filtros',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SearchBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
