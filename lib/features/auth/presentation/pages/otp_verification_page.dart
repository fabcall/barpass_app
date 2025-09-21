import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/auth/presentation/providers/password_reset_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/password_reset_state.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:barpass_app/shared/widgets/utilities/resend_otp_button.dart';
import 'package:barpass_app/shared/widgets/utilities/timer_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({
    required this.email,
    super.key,
  });

  final String email;

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  static const _pinLength = 6;

  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  final _timerController = TimerBuilderController();
  final _pin = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timerController.dispose();
    _pin.dispose();
    super.dispose();
  }

  void _onPinCompleted(String pin) {
    _pin.value = pin;
  }

  void _onPinChanged(String value) {
    _pin.value = value;
  }

  void _verifyOtp() {
    if (_pin.value.length == _pinLength) {
      ref
          .read(passwordResetProvider.notifier)
          .verifyOtp(
            email: widget.email,
            code: _pin.value,
          );
    }
  }

  void _resendCode() {
    ref.read(passwordResetProvider.notifier).resendCode(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (previous, next) {
      next.when(
        initial: () {},
        sendingResetCode: () {},
        codeSent: (email) {
          final wasResending =
              previous?.maybeWhen(
                resendingCode: (_) => true,
                orElse: () => false,
              ) ??
              false;

          if (wasResending) {
            _timerController.restart();
            _pinController.clear();
            _pin.value = '';

            Burnt().toast(
              context,
              title: 'Código reenviado com sucesso!',
              preset: BurntPreset.done,
            );
          }
        },
        resendingCode: (_) {},
        verifyingCode: (_) {},
        codeVerified: (email, token) {
          Burnt().toast(
            context,
            title: 'Código verificado com sucesso!',
            preset: BurntPreset.done,
          );
          context.navigate.auth.goChangePassword(token: token);
        },
        changingPassword: () {},
        passwordChanged: () {},
        error: (message, type, email) {
          if (type == PasswordResetErrorType.verifyCode ||
              type == PasswordResetErrorType.resendCode) {
            Burnt().toast(
              context,
              title: message,
              preset: BurntPreset.error,
            );

            if (type == PasswordResetErrorType.verifyCode) {
              _pinController.clear();
              _pin.value = '';
              _focusNode.requestFocus();
            }
          }
        },
      );
    });

    final resetState = ref.watch(passwordResetProvider);

    final isVerifying = resetState.maybeWhen(
      verifyingCode: (_) => true,
      orElse: () => false,
    );

    final isResending = resetState.maybeWhen(
      resendingCode: (_) => true,
      orElse: () => false,
    );

    final defaultPinTheme = PinTheme(
      width: AppSizes.imageMd,
      height: AppSizes.imageMd,
      textStyle: context.textTheme.headlineSmall,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: AppRadius.borderMd,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: context.colorScheme.primary,
        width: AppSizes.focusedBorderWidth,
      ),
      borderRadius: AppRadius.borderMd,
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.error),
      borderRadius: AppRadius.borderMd,
    );

    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Verificar código'),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<String>(
        valueListenable: _pin,
        builder: (context, pin, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isVerifying || pin.length != _pinLength
                  ? null
                  : _verifyOtp,
              child: isVerifying
                  ? const SizedBox(
                      height: AppSizes.iconSm,
                      width: AppSizes.iconSm,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Verificar'),
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
              'Digite o código de 6 dígitos enviado para',
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.xs),
            Text(
              widget.email,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.itemGap),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: AppOpacity.semiTransparent,
                ),
                borderRadius: AppRadius.borderMd,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: AppSizes.iconXs,
                    color: context.colorScheme.primary,
                  ),
                  const Gap(AppSpacing.itemGap),
                  Expanded(
                    child: Text(
                      'Verifique o console para ver o código mockado',
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.sectionGap),
            Pinput(
              controller: _pinController,
              focusNode: _focusNode,
              length: _pinLength,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: defaultPinTheme,
              errorPinTheme: errorPinTheme,
              enabled: !isVerifying,
              onCompleted: _onPinCompleted,
              onChanged: _onPinChanged,
            ),
            const Gap(AppSpacing.md),
            ResendOtpButton(
              timerController: _timerController,
              onResend: _resendCode,
              isLoading: isResending,
            ),
          ],
        ),
      ),
    ).dismissKeyboard();
  }
}
