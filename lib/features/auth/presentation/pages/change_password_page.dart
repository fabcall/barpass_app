import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/features/auth/presentation/providers/password_reset_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/password_reset_state.dart';
import 'package:barpass_app/features/auth/presentation/widgets/password_requirement.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({
    required this.token,
    super.key,
  });

  final String token;

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _obscurePassword = ValueNotifier<bool>(true);
  final _obscureConfirmPassword = ValueNotifier<bool>(true);
  final _passwordError = ValueNotifier<String?>(null);
  final _confirmPasswordError = ValueNotifier<String?>(null);
  final _isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.requestFocus();

    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    _passwordError.dispose();
    _confirmPasswordError.dispose();
    _isFormValid.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;

    if (password.isEmpty) {
      _passwordError.value = null;
    } else if (password.length < 8) {
      _passwordError.value = 'A senha deve ter pelo menos 8 caracteres';
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      _passwordError.value =
          'A senha deve conter: 1 maiúscula, 1 minúscula e 1 número';
    } else {
      _passwordError.value = null;
    }

    if (_confirmPasswordController.text.isNotEmpty) {
      _validateConfirmPassword();
    }

    _updateFormValidity();
  }

  void _validateConfirmPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (confirmPassword.isEmpty) {
      _confirmPasswordError.value = null;
    } else if (password != confirmPassword) {
      _confirmPasswordError.value = 'As senhas não coincidem';
    } else {
      _confirmPasswordError.value = null;
    }

    _updateFormValidity();
  }

  void _updateFormValidity() {
    _isFormValid.value =
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordError.value == null &&
        _confirmPasswordError.value == null &&
        _passwordController.text == _confirmPasswordController.text;
  }

  void _changePassword() {
    if (_isFormValid.value) {
      ref
          .read(passwordResetProvider.notifier)
          .changePassword(
            token: widget.token,
            newPassword: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (previous, next) {
      next.when(
        initial: () {},
        sendingResetCode: () {},
        codeSent: (_) {},
        resendingCode: (_) {},
        verifyingCode: (_) {},
        codeVerified: (email, token) {},
        changingPassword: () {},
        passwordChanged: () {
          Burnt().toast(
            context,
            title: 'Senha alterada com sucesso!',
            preset: BurntPreset.done,
          );
          context.navigate.auth.goLogin();
          ref.read(passwordResetProvider.notifier).reset();
        },
        error: (message, type, email) {
          if (type == PasswordResetErrorType.changePassword) {
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
      changingPassword: () => true,
      orElse: () => false,
    );

    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Nova senha'),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: _isFormValid,
        builder: (context, isValid, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isLoading || !isValid ? null : _changePassword,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Alterar senha'),
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
              'Defina uma nova senha para sua conta',
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            ValueListenableBuilder<String?>(
              valueListenable: _passwordError,
              builder: (context, error, child) {
                return ValueListenableBuilder<bool>(
                  valueListenable: _obscurePassword,
                  builder: (context, obscure, child) {
                    return TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: obscure,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Nova senha',
                        errorText: error,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _obscurePassword.value = !_obscurePassword.value;
                          },
                        ),
                      ),
                      onSubmitted: (_) {
                        _confirmPasswordFocusNode.requestFocus();
                      },
                    );
                  },
                );
              },
            ),
            const Gap(12),
            ValueListenableBuilder<String?>(
              valueListenable: _confirmPasswordError,
              builder: (context, error, child) {
                return ValueListenableBuilder<bool>(
                  valueListenable: _obscureConfirmPassword,
                  builder: (context, obscure, child) {
                    return TextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      obscureText: obscure,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Confirmar nova senha',
                        errorText: error,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _obscureConfirmPassword.value =
                                !_obscureConfirmPassword.value;
                          },
                        ),
                      ),
                      onSubmitted: (_) {
                        if (_isFormValid.value) {
                          _changePassword();
                        }
                      },
                    );
                  },
                );
              },
            ),
            const Gap(8),
            PasswordRequirementsCard(
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    ).dismissKeyboard();
  }
}
