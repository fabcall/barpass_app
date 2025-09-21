import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/auth_state.dart';
import 'package:barpass_app/features/auth/presentation/widgets/password_requirement.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final _obscurePassword = ValueNotifier<bool>(true);
  final _obscureConfirmPassword = ValueNotifier<bool>(true);
  final _isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nameFocus.requestFocus();

    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    _isFormValid.dispose();
    super.dispose();
  }

  void _validateForm() {
    _isFormValid.value =
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  void _handleRegister() {
    if (_passwordController.text != _confirmPasswordController.text) {
      Burnt().toast(
        context,
        title: 'As senhas não coincidem',
        preset: BurntPreset.error,
      );
      return;
    }

    ref
        .read(authProvider.notifier)
        .register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          Burnt().toast(
            context,
            title: 'Conta criada com sucesso!',
            preset: BurntPreset.done,
          );
          context.navigate.goHome();
        },
        unauthenticated: () {},
        error: (message) {
          Burnt().toast(
            context,
            title: message,
            preset: BurntPreset.error,
          );
        },
      );
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastrar nova conta'),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: _isFormValid,
        builder: (context, isValid, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isLoading || !isValid ? null : _handleRegister,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Criar conta'),
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
              'Preencha os dados abaixo para criar sua conta',
              style: context.textTheme.bodyLarge,
            ),
            const Gap(24),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              autofocus: true,
              enabled: !isLoading,
              decoration: const InputDecoration(
                label: Text('Nome completo'),
                hintText: 'João Silva',
              ),
              onSubmitted: (_) => _emailFocus.requestFocus(),
            ),
            const Gap(12),
            TextField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
              decoration: const InputDecoration(
                label: Text('E-mail'),
                hintText: 'joao@email.com',
              ),
              onSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const Gap(12),
            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, obscure, child) {
                return TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: obscure,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                    ),
                  ),
                  onSubmitted: (_) => _confirmPasswordFocus.requestFocus(),
                );
              },
            ),
            const Gap(12),
            ValueListenableBuilder<bool>(
              valueListenable: _obscureConfirmPassword,
              builder: (context, obscure, child) {
                return TextField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  obscureText: obscure,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    label: const Text('Confirmar senha'),
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
                    if (_isFormValid.value) _handleRegister();
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
