import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

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
              'Esqueci minha senha',
              style: context.textTheme.titleLarge,
            ),
            Text(
              'Por favor, digite o seu e-mail e nós lhe enviaremos um e-mail com as instruções para recuperar sua conta',
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            const TextField(
              autofocus: true,
              decoration: InputDecoration(
                label: Text('E-mail'),
              ),
            ),
            const Gap(16),
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
}
