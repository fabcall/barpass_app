import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/auth/presentation/providers/password_reset_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/password_reset_state.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class PasswordResetPage extends ConsumerStatefulWidget {
  const PasswordResetPage({super.key});

  @override
  ConsumerState<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends ConsumerState<PasswordResetPage> {
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final _isEmailValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _emailFocus.requestFocus();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController
      ..removeListener(_validateEmail)
      ..dispose();
    _emailFocus.dispose();
    _isEmailValid.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    _isEmailValid.value = _isValidEmail(email);
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _submitPasswordReset() {
    ref
        .read(passwordResetProvider.notifier)
        .sendResetCode(
          _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (previous, next) {
      next.when(
        initial: () {},
        sendingResetCode: () {},
        codeSent: (email) {
          Burnt().toast(
            context,
            title: 'Código enviado com sucesso!',
            preset: BurntPreset.done,
          );
          context.navigate.auth.goOtpVerification(email: email);
        },
        resendingCode: (_) {},
        verifyingCode: (_) {},
        codeVerified: (email, token) {},
        changingPassword: () {},
        passwordChanged: () {},
        error: (message, type, email) {
          if (type == PasswordResetErrorType.sendCode) {
            Burnt().toast(
              context,
              title: message,
              preset: BurntPreset.error,
            );
          }
        },
      );
    });

    final resetState = ref.watch(passwordResetProvider);
    final isLoading = resetState.maybeWhen(
      sendingResetCode: () => true,
      orElse: () => false,
    );

    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Esqueci minha senha'),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: _isEmailValid,
        builder: (context, isValid, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isLoading || !isValid ? null : _submitPasswordReset,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Enviar código'),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Por favor, digite o seu e-mail e nós lhe enviaremos um código de verificação',
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            TextField(
              controller: _emailController,
              focusNode: _emailFocus,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
              decoration: const InputDecoration(
                label: Text('E-mail'),
                hintText: 'teste@barpass.com',
              ),
              onSubmitted: (_) {
                if (_isEmailValid.value) {
                  _submitPasswordReset();
                }
              },
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.colorScheme.primary,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      'Use: teste@barpass.com para testar',
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).dismissKeyboard();
  }
}
