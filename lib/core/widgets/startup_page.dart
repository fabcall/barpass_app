import 'package:barpass_app/core/providers/onboarding_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupPage extends ConsumerWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escutar mudanças para redirecionamento automático
    ref.listen(onboardingProvider, (previous, next) {
      // O redirecionamento é feito pelo GoRouter
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_bar,
              size: 80,
              color: Colors.orange,
            ),
            SizedBox(height: 24),
            Text(
              'barpass',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
