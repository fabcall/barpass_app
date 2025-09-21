// lib/shared/widgets/common/theme_selection_dialog.dart
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog para seleção de tema da aplicação
///
/// Permite que o usuário escolha entre os temas disponíveis:
/// - Claro
/// - Escuro
/// - Sistema (segue configuração do dispositivo)
///
/// Features:
/// - Feedback visual do tema atual
/// - Animações suaves
/// - Feedback háptico
/// - Tratamento de erros
/// - SnackBar de confirmação
class ThemeSelectionDialog extends ConsumerStatefulWidget {
  const ThemeSelectionDialog({super.key});

  @override
  ConsumerState<ThemeSelectionDialog> createState() =>
      _ThemeSelectionDialogState();

  /// Método estático para facilitar a abertura do dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const ThemeSelectionDialog(),
    );
  }
}

class _ThemeSelectionDialogState extends ConsumerState<ThemeSelectionDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _isChangingTheme = false;

  @override
  void initState() {
    super.initState();

    // Configurar animação de entrada do dialog
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutCubic,
    );

    // Iniciar animação
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AlertDialog(
            // Título com ícone
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.palette_outlined,
                    color: context.colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Escolher tema'),
              ],
            ),

            contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),

            content: SizedBox(
              width: double.maxFinite,
              child: themeState.when(
                data: (currentTheme) =>
                    _buildThemeOptions(context, currentTheme),
                loading: _buildLoadingState,
                error: (error, _) => _buildErrorState(error),
              ),
            ),

            actions: [
              TextButton(
                onPressed: _isChangingTheme ? null : _closeDialog,
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOptions(BuildContext context, AppThemeMode currentTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Descrição
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Escolha como você quer que o app apareça. O tema Sistema seguirá a configuração do seu dispositivo.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 16),

        // Lista de opções
        ...AppThemeMode.values.map((themeMode) {
          return _ThemeOptionTile(
            themeMode: themeMode,
            isSelected: themeMode == currentTheme,
            isEnabled: !_isChangingTheme,
            onTap: () => _handleThemeSelection(themeMode),
          );
        }),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando configurações...'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: context.colorScheme.error,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'Erro ao carregar temas',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tente novamente',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => ref.read(themeProvider.notifier).refresh(),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleThemeSelection(AppThemeMode selectedTheme) async {
    if (_isChangingTheme) return;

    // Verificar se já está selecionado
    final currentTheme = ref.read(themeProvider).value;
    if (currentTheme == selectedTheme) {
      _closeDialog();
      return;
    }

    setState(() {
      _isChangingTheme = true;
    });

    try {
      // Feedback háptico
      await HapticFeedback.lightImpact();

      // Alterar o tema
      await ref.read(themeProvider.notifier).setTheme(selectedTheme);

      // Aguardar um pouco para mostrar mudança visual
      await Future<void>.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        _closeDialog();

        // Mostrar feedback de sucesso
        Burnt().toast(
          context,
          title: 'Tema alterado para ${selectedTheme.label}',
          preset: BurntPreset.done,
        );
      }
    } on Exception catch (_) {
      setState(() {
        _isChangingTheme = false;
      });

      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao alterar tema',
          preset: BurntPreset.error,
        );
      }
    }
  }

  void _closeDialog() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

/// Widget individual para cada opção de tema
class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.themeMode,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final AppThemeMode themeMode;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        enabled: isEnabled,
        // Ícone com background colorido
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primaryContainer
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  )
                : null,
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isSelected ? 1.1 : 1.0,
            child: Icon(
              themeMode.icon,
              color: isSelected
                  ? context.colorScheme.onPrimaryContainer
                  : context.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
        ),

        // Título e descrição
        title: Text(
          themeMode.label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          _getThemeDescription(themeMode),
          style: TextStyle(
            fontSize: 12,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),

        // Indicador de seleção
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: context.colorScheme.primary,
                  key: const ValueKey('selected'),
                )
              : Icon(
                  Icons.radio_button_unchecked,
                  color: context.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                  key: const ValueKey('unselected'),
                ),
        ),

        onTap: isEnabled ? onTap : null,

        // Configurações visuais
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  String _getThemeDescription(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return 'Sempre usar cores claras';
      case AppThemeMode.dark:
        return 'Sempre usar cores escuras';
      case AppThemeMode.system:
        return 'Segue a configuração do dispositivo';
    }
  }
}
