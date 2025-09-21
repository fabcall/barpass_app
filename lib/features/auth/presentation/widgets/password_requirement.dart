import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Widget reutilizável que mostra um requisito de senha com validação em tempo real
class PasswordRequirement extends StatefulWidget {
  const PasswordRequirement({
    required this.text,
    required this.passwordController,
    required this.validator,
    super.key,
  });

  final String text;
  final TextEditingController passwordController;
  final bool Function(String password) validator;

  @override
  State<PasswordRequirement> createState() => _PasswordRequirementState();
}

class _PasswordRequirementState extends State<PasswordRequirement> {
  late final ValueNotifier<bool> _isValid;

  @override
  void initState() {
    super.initState();
    _isValid = ValueNotifier(widget.validator(widget.passwordController.text));
    widget.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_onPasswordChanged);
    _isValid.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _isValid.value = widget.validator(widget.passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isValid,
      builder: (context, isValid, child) {
        return Row(
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.radio_button_unchecked,
              size: AppSizes.iconXs,
              color: isValid
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),
            Gap(AppSpacing.itemGap),
            Expanded(
              child: Text(
                widget.text,
                style: context.textTheme.bodySmall?.copyWith(
                  color: isValid
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Widget que agrupa múltiplos requisitos de senha
class PasswordRequirementsCard extends StatelessWidget {
  const PasswordRequirementsCard({
    required this.passwordController,
    super.key,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: AppOpacity.semiTransparent,
        ),
        borderRadius: AppRadius.borderMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sua senha deve conter:',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.xs),
          PasswordRequirement(
            text: 'Pelo menos 8 caracteres',
            passwordController: passwordController,
            validator: (password) => password.length >= 8,
          ),
          PasswordRequirement(
            text: '1 letra maiúscula',
            passwordController: passwordController,
            validator: (password) => RegExp('[A-Z]').hasMatch(password),
          ),
          PasswordRequirement(
            text: '1 letra minúscula',
            passwordController: passwordController,
            validator: (password) => RegExp('[a-z]').hasMatch(password),
          ),
          PasswordRequirement(
            text: '1 número',
            passwordController: passwordController,
            validator: (password) => RegExp(r'\d').hasMatch(password),
          ),
        ],
      ),
    );
  }
}
