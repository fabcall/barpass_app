import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bem-vindo (a) de volta',
              style: Theme.of(
                context,
              ).textTheme.titleLarge,
            ),
            Text(
              'Informe seus dados de acesso',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge,
            ),
            const Gap(24),
            const TextField(
              autofocus: true,
              decoration: InputDecoration(
                label: Text('E-mail'),
              ),
            ),
            const Gap(12),
            const TextField(
              decoration: InputDecoration(
                label: Text('Senha'),
              ),
            ),
            const Gap(8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/login/password-reset'),
                child: const Text(
                  'Esqueceu sua senha?',
                ),
              ),
            ),
            const Gap(8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text(
                  'Enviar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
