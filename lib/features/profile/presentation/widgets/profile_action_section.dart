// lib/features/profile/presentation/widgets/profile_action_section.dart
import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_action_card.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/common/theme_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileActionSection extends ConsumerWidget {
  const ProfileActionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return Column(
      children: [
        // Seção de ações principais (Login/Cadastro)
        ProfileActionCard(
          children: [
            ProfileActionTile(
              icon: Icons.login,
              title: 'Fazer login',
              subtitle: 'Acesse sua conta',
              iconColor: context.colorScheme.primary,
              onTap: () {
                HapticFeedback.lightImpact();
                context.go('/login');
              },
            ),
            ProfileActionTile(
              icon: Icons.person_add,
              title: 'Cadastrar',
              subtitle: 'Crie sua conta agora',
              iconColor: Colors.green.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                context.go('/registration');
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Menu secundário
        ProfileActionCard(
          children: [
            ProfileActionTile(
              icon: Icons.favorite_outline,
              title: 'Favoritos',
              subtitle: 'Seus lugares favoritos',
              iconColor: Colors.red.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                context.go('/favoritos');
              },
            ),
            ProfileActionTile(
              icon: Icons.history,
              title: 'Histórico',
              subtitle: 'Seus pedidos anteriores',
              iconColor: Colors.blue.shade600,
              onTap: HapticFeedback.lightImpact,
            ),
            ProfileActionTile(
              icon: Icons.help_outline,
              title: 'Ajuda',
              subtitle: 'Central de ajuda e suporte',
              iconColor: Colors.orange.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                context.push('/help');
              },
            ),
            ProfileActionTile(
              icon: Icons.info_outline,
              title: 'Sobre',
              subtitle: 'Informações do app',
              iconColor: Colors.purple.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                _showAboutDialog(context, ref);
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Configurações
        ProfileActionCard(
          children: [
            ProfileActionTile(
              icon: Icons.notifications_outlined,
              title: 'Notificações',
              subtitle: 'Gerenciar notificações',
              iconColor: Colors.indigo.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                context.push('/notifications');
              },
            ),
            ProfileActionTile(
              icon: Icons.language_outlined,
              title: 'Idioma',
              subtitle: 'Português (Brasil)',
              iconColor: Colors.teal.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                _showLanguageDialog(context);
              },
            ),
            // TEMA ATUALIZADO - Agora usa o provider
            ProfileActionTile(
              icon: themeState.when(
                data: (theme) => theme.icon,
                loading: () => Icons.auto_mode,
                error: (_, __) => Icons.auto_mode,
              ),
              title: 'Tema',
              subtitle: themeState.when(
                data: (theme) => theme.label,
                loading: () => 'Carregando...',
                error: (_, __) => 'Sistema',
              ),
              iconColor: Colors.grey.shade700,
              onTap: () {
                HapticFeedback.lightImpact();
                ThemeSelectionDialog.show(context);
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Informações legais
        ProfileActionCard(
          children: [
            ProfileActionTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacidade',
              subtitle: 'Política de privacidade',
              iconColor: Colors.green.shade700,
              onTap: HapticFeedback.lightImpact,
            ),
            ProfileActionTile(
              icon: Icons.description_outlined,
              title: 'Termos de uso',
              subtitle: 'Termos e condições',
              iconColor: Colors.brown.shade600,
              onTap: HapticFeedback.lightImpact,
            ),
          ],
        ),
      ],
    );
  }

  void _showAboutDialog(BuildContext context, WidgetRef ref) {
    final appInfoService = ref.read(appInfoServiceProvider);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.restaurant,
          color: context.colorScheme.primary,
          size: 32,
        ),
        title: Text(appInfoService.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Versão ${appInfoService.fullVersion}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getEnvironmentColor(appInfoService.environment),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                appInfoService.environment.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'O melhor app para encontrar descontos em restaurantes e bares da sua cidade.',
              textAlign: TextAlign.center,
            ),
            if (appInfoService.isDebugBuild) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Debug Info:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Package: ${appInfoService.packageName}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Build: ${appInfoService.buildNumber}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Color _getEnvironmentColor(String environment) {
    switch (environment) {
      case 'production':
        return Colors.green;
      case 'staging':
        return Colors.orange;
      case 'development':
      default:
        return Colors.blue;
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolher idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇧🇷'),
              title: const Text('Português (Brasil)'),
              trailing: Icon(
                Icons.check,
                color: context.colorScheme.primary,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              onTap: () {
                // TODO: Implementar mudança de idioma
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Text('🇪🇸'),
              title: const Text('Español'),
              onTap: () {
                // TODO: Implementar mudança de idioma
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
