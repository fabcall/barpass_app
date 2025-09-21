import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

/// Widget que exibe um campo editável do perfil como um ListTile estilizado
///
/// Uso básico:
/// ```dart
/// ProfileEditTile(
///   icon: Icons.person_outline,
///   title: 'Nome',
///   subtitle: 'João Silva',
///   onTap: () => _showEditNameSheet(),
/// )
/// ```
///
/// Campo não editável:
/// ```dart
/// ProfileEditTile(
///   icon: Icons.email_outlined,
///   title: 'E-mail',
///   subtitle: 'joao@email.com',
///   enabled: false,
///   onTap: null,
///   trailing: Icon(Icons.verified), // Badge de verificado
/// )
/// ```
class ProfileEditTile extends StatelessWidget {
  const ProfileEditTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.enabled = true,
    super.key,
  });

  /// Ícone que representa o campo (ex: Icons.person_outline)
  final IconData icon;

  /// Label do campo (ex: "Nome", "Telefone")
  final String title;

  /// Valor atual do campo (ex: "João Silva", "Não informado")
  final String subtitle;

  /// Callback quando o tile é tocado
  /// Se null, o tile não será clicável
  final VoidCallback? onTap;

  /// Widget customizado no final do tile
  /// Útil para badges (ex: ícone verificado)
  final Widget? trailing;

  /// Se false, o tile fica visualmente desabilitado
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isEditable = onTap != null && enabled;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEditable ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              // Ícone com fundo colorido - mais discreto
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: enabled
                      ? context.colorScheme.primaryContainer.withValues(
                          alpha: 0.5,
                        )
                      : context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: enabled
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(width: 12),

              // Textos (label + valor)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label pequeno (ex: "Nome")
                    Text(
                      title,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: enabled
                            ? context.colorScheme.onSurfaceVariant
                            : context.colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.6,
                              ),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Valor (ex: "João Silva")
                    Text(
                      subtitle,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: enabled
                            ? context.colorScheme.onSurface
                            : context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Trailing customizado ou seta padrão
              if (trailing != null)
                trailing!
              else if (isEditable)
                Icon(
                  Icons.chevron_right,
                  color: context.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
