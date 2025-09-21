import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A página que você está procurando não existe',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.navigate.toHome(),
              icon: const Icon(Icons.home),
              label: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    );
  }
}
