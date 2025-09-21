import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_action_card.dart';
import 'package:barpass_app/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:barpass_app/shared/providers/language_provider.dart';
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/base/dialogs/language_selection_dialog.dart';
import 'package:barpass_app/shared/widgets/base/dialogs/theme_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileActionSection extends ConsumerWidget {
  const ProfileActionSection({
    required this.isAuthenticated,
    super.key,
  });

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return Column(
      children: [
        // Seção de ações de autenticação (somente para não autenticados)
        if (!isAuthenticated) ...[
          ProfileActionCard(
            children: [
              ProfileActionTile(
                icon: Icons.login,
                title: 'Fazer login',
                subtitle: 'Acesse sua conta',
                iconColor: context.colorScheme.primary,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.navigate.auth.toLogin();
                },
              ),
              ProfileActionTile(
                icon: Icons.person_add,
                title: 'Cadastrar',
                subtitle: 'Crie sua conta agora',
                iconColor: Colors.green.shade600,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.navigate.auth.toRegister();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],

        // Seção de conta (somente para autenticados)
        if (isAuthenticated) ...[
          ProfileActionCard(
            children: [
              ProfileActionTile(
                icon: Icons.person_outline,
                title: 'Minha conta',
                subtitle: 'Dados pessoais e configurações',
                iconColor: context.colorScheme.primary,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push('/account');
                },
              ),
              ProfileActionTile(
                icon: Icons.credit_card,
                title: 'Pagamentos',
                subtitle: 'Métodos de pagamento',
                iconColor: Colors.blue.shade600,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push('/payments');
                },
              ),
              ProfileActionTile(
                icon: Icons.location_on_outlined,
                title: 'Endereços',
                subtitle: 'Gerenciar endereços salvos',
                iconColor: Colors.red.shade600,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push('/addresses');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],

        // Menu secundário
        ProfileActionCard(
          children: [
            ProfileActionTile(
              icon: Icons.favorite_outline,
              title: 'Favoritos',
              subtitle: isAuthenticated
                  ? 'Seus lugares favoritos'
                  : 'Faça login para salvar favoritos',
              iconColor: Colors.red.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                if (isAuthenticated) {
                  context.navigate.favorites.toList();
                } else {
                  context.navigate.auth.toLogin();
                }
              },
            ),
            ProfileActionTile(
              icon: Icons.history,
              title: 'Histórico',
              subtitle: isAuthenticated
                  ? 'Seus pedidos anteriores'
                  : 'Faça login para ver seu histórico',
              iconColor: Colors.blue.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                if (isAuthenticated) {
                  context.push('/history');
                } else {
                  context.navigate.auth.toLogin();
                }
              },
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
              subtitle: ref
                  .watch(languageProvider)
                  .maybeWhen(
                    data: (lang) => lang.label,
                    orElse: () => 'Português',
                  ),
              iconColor: Colors.teal.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                LanguageSelectionDialog.show(context);
              },
            ),
            ProfileActionTile(
              icon: themeState.when(
                data: (theme) => theme.icon,
                loading: () => Icons.auto_mode,
                error: (_, _) => Icons.auto_mode,
              ),
              title: 'Tema',
              subtitle: themeState.when(
                data: (theme) => theme.label,
                loading: () => 'Carregando...',
                error: (_, _) => 'Sistema',
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
              onTap: () {
                HapticFeedback.lightImpact();
                context.push('/privacy');
              },
            ),
            ProfileActionTile(
              icon: Icons.description_outlined,
              title: 'Termos de uso',
              subtitle: 'Termos e condições',
              iconColor: Colors.brown.shade600,
              onTap: () {
                HapticFeedback.lightImpact();
                context.push('/terms');
              },
            ),
          ],
        ),

        // Botão de logout (somente para autenticados)
        if (isAuthenticated) ...[
          const SizedBox(height: 24),
          ProfileActionCard(
            children: [
              ProfileActionTile(
                icon: Icons.logout,
                title: 'Sair',
                subtitle: 'Desconectar da conta',
                iconColor: Colors.red.shade600,
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showLogoutDialog(context, ref);
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.logout,
          color: Colors.red.shade600,
          size: 32,
        ),
        title: const Text('Sair da conta'),
        content: const Text(
          'Tem certeza que deseja sair da sua conta?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(authProvider.notifier).logout();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: const Text('Sair'),
          ),
        ],
      ),
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
}
