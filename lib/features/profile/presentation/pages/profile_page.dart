import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_action_section.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    const expandedHeight = 200.0;
    const toolbarHeight = 56.0;
    const collapsePoint = expandedHeight - toolbarHeight;

    final shouldCollapse = _scrollController.offset > collapsePoint;

    if (shouldCollapse != _isCollapsed) {
      setState(() {
        _isCollapsed = shouldCollapse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ProfileAppBar(
            isCollapsed: _isCollapsed,
            user: user,
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Seções de ações
          SliverToBoxAdapter(
            child: ProfileActionSection(isAuthenticated: user != null),
          ),

          // Espaçamento final
          SliverToBoxAdapter(
            child: Gap(MediaQuery.of(context).padding.bottom),
          ),
        ],
      ),
    );
  }
}
