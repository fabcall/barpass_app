import 'package:barpass_app/shared/widgets/common/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      actions: [
        FilterButton(),
      ],
      scrolledUnderElevation: 0,
      title: HomeAppBarTitle(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 2 * 8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SearchBarWidget(),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Implementar lógica do filtro
      },
      icon: const Icon(Icons.tune),
    );
  }
}

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'barpass',
      style: TextStyle(
        fontFamily: 'Comfortaa',
      ),
    );
  }
}
