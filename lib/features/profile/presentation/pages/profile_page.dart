import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    // A AppBar colapsa quando o scroll é maior que (expandedHeight - toolbar height)
    // expandedHeight = 200, toolbar height ≈ 56
    const expandedHeight = 200.0;
    const toolbarHeight = 56.0;
    const collapsePoint = expandedHeight - toolbarHeight;

    final shouldCollapse = _scrollController.offset > collapsePoint;

    if (shouldCollapse != _isCollapsed) {
      setState(() {
        _isCollapsed = shouldCollapse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverAppBar com perfil do usuário
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            title: Row(
              children: [
                // Avatar que aparece/desaparece suavemente
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isCollapsed ? 32 : 0,
                  height: _isCollapsed ? 32 : 0,
                  margin: _isCollapsed
                      ? const EdgeInsets.only(right: 12)
                      : EdgeInsets.zero,
                  child: _isCollapsed
                      ? ClipRect(
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            tween: Tween<double>(begin: 1.0, end: 0.0),
                            builder: (context, value, child) {
                              final opacity = (1 - value).clamp(0.0, 1.0);

                              return Transform.translate(
                                offset: Offset(0, 20 * value),
                                child: Opacity(
                                  opacity: opacity,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorScheme.primary
                                          .withOpacity(0.1),
                                      border: Border.all(
                                        color: context.colorScheme.primary
                                            .withOpacity(0.2),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 16,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : null,
                ),

                // Título (sempre presente, posição se ajusta automaticamente)
                const Text('perfil'),
              ],
            ),
            actions: [
              // Ícone de configurações sempre visível
              IconButton(
                onPressed: () => context.push('/perfil/configuracoes'),
                icon: Icon(
                  Icons.settings_outlined,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Configurações',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                    child: Row(
                      children: [
                        // Avatar do usuário (visível quando expandido)
                        Hero(
                          tag: 'profile_avatar',
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colorScheme.primary.withOpacity(
                                0.1,
                              ),
                              border: Border.all(
                                color: context.colorScheme.primary.withOpacity(
                                  0.2,
                                ),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Informações do usuário
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, seja bem vindo',
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.onSurface,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Cadastre-se agora e aproveite todos os benefícios do barpass',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Seção de ações principais
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileActionTile(
                    icon: Icons.login,
                    title: 'Fazer login',
                    subtitle: 'Acesse sua conta',
                    iconColor: context.colorScheme.primary,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.go('/login');
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
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
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Seção de menu secundário
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileActionTile(
                    icon: Icons.favorite_outline,
                    title: 'Favoritos',
                    subtitle: 'Seus lugares favoritos',
                    iconColor: Colors.red.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.go('/favoritos');
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.history,
                    title: 'Histórico',
                    subtitle: 'Seus pedidos anteriores',
                    iconColor: Colors.blue.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Implementar navegação para histórico
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.help_outline,
                    title: 'Ajuda',
                    subtitle: 'Central de ajuda e suporte',
                    iconColor: Colors.orange.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/help');
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.info_outline,
                    title: 'Sobre',
                    subtitle: 'Informações do app',
                    iconColor: Colors.purple.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Seção de configurações
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileActionTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notificações',
                    subtitle: 'Gerenciar notificações',
                    iconColor: Colors.indigo.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/notifications');
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.language_outlined,
                    title: 'Idioma',
                    subtitle: 'Português (Brasil)',
                    iconColor: Colors.teal.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _showLanguageDialog(context);
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Tema',
                    subtitle: 'Claro/Escuro/Sistema',
                    iconColor: Colors.grey.shade700,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _showThemeDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Seção de informações legais
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileActionTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacidade',
                    subtitle: 'Política de privacidade',
                    iconColor: Colors.green.shade700,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Implementar navegação para política de privacidade
                    },
                  ),

                  _buildDivider(context),

                  _ProfileActionTile(
                    icon: Icons.description_outlined,
                    title: 'Termos de uso',
                    subtitle: 'Termos e condições',
                    iconColor: Colors.brown.shade600,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Implementar navegação para termos de uso
                    },
                  ),
                ],
              ),
            ),
          ),

          // Espaçamento final
          // Espaçamento final
          SliverToBoxAdapter(
            child: Gap(
              MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: context.colorScheme.outlineVariant.withOpacity(0.5),
      indent: 60,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.restaurant,
          color: context.colorScheme.primary,
          size: 32,
        ),
        title: const Text('BarPass'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Versão 1.0.0'),
            SizedBox(height: 8),
            Text(
              'O melhor app para encontrar descontos em restaurantes e bares da sua cidade.',
              textAlign: TextAlign.center,
            ),
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
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

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolher tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Claro'),
              onTap: () {
                // TODO: Implementar mudança de tema
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Escuro'),
              onTap: () {
                // TODO: Implementar mudança de tema
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_mode),
              title: const Text('Sistema'),
              trailing: Icon(
                Icons.check,
                color: context.colorScheme.primary,
              ),
              onTap: () => Navigator.of(context).pop(),
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

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Ícone com fundo colorido
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 16),

              // Textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Seta
              Icon(
                Icons.chevron_right,
                color: context.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
