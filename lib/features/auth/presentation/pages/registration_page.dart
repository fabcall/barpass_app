import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cadastrar nova conta',
              style: context.textTheme.titleLarge,
            ),
            Text(
              '',
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
