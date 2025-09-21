import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/auth_state.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _obscurePassword = ValueNotifier<bool>(true);
  final _isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _emailFocus.requestFocus();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _obscurePassword.dispose();
    _isFormValid.dispose();
    super.dispose();
  }

  void _validateForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    _isFormValid.value = email.isNotEmpty && password.isNotEmpty;
  }

  void _handleLogin() {
    ref
        .read(authProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    // Escutar mudanças no estado de autenticação
    ref.listen(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (session) {
          Burnt().toast(
            context,
            title: 'Bem-vindo!',
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
        title: const Text('Bem-vindo (a) de volta'),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: _isFormValid,
        builder: (context, isValid, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isLoading || !isValid ? null : _handleLogin,
              child: isLoading
                  ? SizedBox(
                      height: AppSizes.iconSm,
                      width: AppSizes.iconSm,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Entrar'),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Informe seus dados de acesso',
              style: context.textTheme.bodyLarge,
            ),
            Gap(AppSpacing.sectionGap),
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
              onSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            Gap(AppSpacing.componentGap),
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
                    hintText: 'Teste123',
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
                    if (_isFormValid.value) {
                      _handleLogin();
                    }
                  },
                );
              },
            ),
            Gap(AppSpacing.itemGap),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => context.navigate.auth.goPasswordReset(),
                child: const Text('Esqueceu sua senha?'),
              ),
            ),
          ],
        ),
      ),
    ).dismissKeyboard();
  }
}
