import 'package:flutter/material.dart';

/// Um badge reutilizável para exibir status, tags ou informações
/// com cores e ícones personalizáveis.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.variant = StatusBadgeVariant.filled,
    super.key,
  });

  /// Construtor para badge de status (aberto/fechado)
  factory StatusBadge.status({
    required bool isOpen,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: isOpen ? 'Aberto' : 'Fechado',
      backgroundColor: isOpen ? Colors.green.shade50 : Colors.red.shade50,
      foregroundColor: isOpen ? Colors.green.shade700 : Colors.red.shade700,
      borderColor: isOpen ? Colors.green.shade200 : Colors.red.shade200,
    );
  }

  /// Construtor para badge de verificação
  factory StatusBadge.verified({
    String label = 'Conta verificada',
    Color? backgroundColor,
    Color? foregroundColor,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: label,
      icon: Icons.verified_user,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  /// Construtor para badge de sucesso
  factory StatusBadge.success({
    required String label,
    IconData? icon,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: label,
      icon: icon,
      backgroundColor: Colors.green.shade50,
      foregroundColor: Colors.green.shade700,
      borderColor: Colors.green.shade200,
    );
  }

  /// Construtor para badge de erro
  factory StatusBadge.error({
    required String label,
    IconData? icon,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: label,
      icon: icon,
      backgroundColor: Colors.red.shade50,
      foregroundColor: Colors.red.shade700,
      borderColor: Colors.red.shade200,
    );
  }

  /// Construtor para badge de aviso
  factory StatusBadge.warning({
    required String label,
    IconData? icon,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: label,
      icon: icon,
      backgroundColor: Colors.orange.shade50,
      foregroundColor: Colors.orange.shade700,
      borderColor: Colors.orange.shade200,
    );
  }

  /// Construtor para badge de informação
  factory StatusBadge.info({
    required String label,
    IconData? icon,
    Key? key,
  }) {
    return StatusBadge(
      key: key,
      label: label,
      icon: icon,
      backgroundColor: Colors.blue.shade50,
      foregroundColor: Colors.blue.shade700,
      borderColor: Colors.blue.shade200,
    );
  }

  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final StatusBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Cores padrão se não fornecidas
    final bgColor = backgroundColor ?? colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: variant == StatusBadgeVariant.filled ? bgColor : null,
        borderRadius: BorderRadius.circular(20),
        border: variant == StatusBadgeVariant.outlined
            ? Border.all(
                color: borderColor ?? fgColor.withValues(alpha: 0.3),
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: fgColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Variante do badge (preenchido ou com borda)
enum StatusBadgeVariant {
  /// Badge com fundo colorido
  filled,

  /// Badge com borda colorida e fundo transparente
  outlined,
}
