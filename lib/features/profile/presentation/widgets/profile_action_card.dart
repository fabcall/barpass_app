import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfileActionCard extends StatelessWidget {
  const ProfileActionCard({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: _buildChildrenWithDividers(context),
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers(BuildContext context) {
    final List<Widget> result = [];

    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);

      // Adiciona divider entre os itens (exceto no último)
      if (i < children.length - 1) {
        result.add(
          Divider(
            height: 1,
            thickness: 0.5,
            color: context.colorScheme.outlineVariant.withOpacity(0.5),
            indent: 60,
          ),
        );
      }
    }

    return result;
  }
}
