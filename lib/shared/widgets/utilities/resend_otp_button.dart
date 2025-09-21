import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/utilities/timer_builder.dart';
import 'package:flutter/material.dart';

/// Botão inline de reenvio de OTP com timer integrado
///
/// Exibe um contador quando o timer está ativo e um botão clicável quando não está.
/// Design minimalista e inline para melhor aproveitamento de espaço.
class ResendOtpButton extends StatelessWidget {
  const ResendOtpButton({
    required this.timerController,
    required this.onResend,
    super.key,
    this.timerDuration = const Duration(seconds: 30),
    this.isLoading = false,
    this.isDisabled = false,
  });

  final TimerBuilderController timerController;
  final VoidCallback? onResend;
  final Duration timerDuration;
  final bool isLoading;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return TimerBuilder(
      controller: timerController,
      duration: timerDuration,
      builder: (context, remainingSeconds, isActive) {
        // Se o timer está ativo, mostra o contador
        if (isActive && remainingSeconds > 0) {
          return _buildTimerText(context, remainingSeconds);
        }

        // Se está carregando, mostra o loading
        if (isLoading) {
          return _buildLoadingState(context);
        }

        // Caso contrário, mostra o botão clicável
        return _buildButton(context);
      },
    );
  }

  /// Texto com o contador do timer
  Widget _buildTimerText(BuildContext context, int remainingSeconds) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Não recebeu o código? ',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          'Reenviar em ${remainingSeconds}s',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Estado de carregamento (reenviando código)
  Widget _buildLoadingState(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Não recebeu o código? ',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colorScheme.warning,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Reenviando...',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.warning,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Botão clicável para reenviar
  Widget _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Não recebeu o código? ',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        GestureDetector(
          onTap: (isDisabled || isLoading) ? null : onResend,
          child: MouseRegion(
            cursor: (isDisabled || isLoading)
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click,
            child: Text(
              'Reenviar',
              style: context.textTheme.bodyMedium?.copyWith(
                color: (isDisabled || isLoading)
                    ? context.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      )
                    : context.colorScheme.success,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: (isDisabled || isLoading)
                    ? context.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      )
                    : context.colorScheme.success,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
