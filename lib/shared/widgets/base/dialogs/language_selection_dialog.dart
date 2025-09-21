// lib/shared/widgets/common/dialogs/language_selection_dialog.dart
import 'package:barpass_app/shared/providers/language_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog para seleção de idioma da aplicação
///
/// Permite que o usuário escolha entre os idiomas disponíveis:
/// - Português
/// - English
/// - Español
///
/// Features:
/// - Feedback visual do idioma atual
/// - Animações suaves
/// - Feedback háptico
/// - Bandeiras como ícones
/// - Persistência via SharedPreferences
class LanguageSelectionDialog extends ConsumerStatefulWidget {
  const LanguageSelectionDialog({super.key});

  @override
  ConsumerState<LanguageSelectionDialog> createState() =>
      _LanguageSelectionDialogState();

  /// Método estático para facilitar a abertura do dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }
}

class _LanguageSelectionDialogState
    extends ConsumerState<LanguageSelectionDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _isChangingLanguage = false;

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
    final languageState = ref.watch(languageProvider);

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
                    Icons.language,
                    color: context.colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Escolher idioma'),
              ],
            ),

            contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),

            content: SizedBox(
              width: double.maxFinite,
              child: languageState.when(
                data: (currentLanguage) =>
                    _buildLanguageOptions(context, currentLanguage),
                loading: _buildLoadingState,
                error: (error, _) => _buildErrorState(error),
              ),
            ),

            actions: [
              TextButton(
                onPressed: _isChangingLanguage ? null : _closeDialog,
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOptions(
    BuildContext context,
    AppLanguage currentLanguage,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Descrição
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Escolha o idioma que você prefere usar no aplicativo.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 16),

        // Lista de opções
        ...AppLanguage.values.map((language) {
          return _LanguageOptionTile(
            language: language,
            isSelected: language == currentLanguage,
            isEnabled: !_isChangingLanguage,
            onTap: () => _handleLanguageSelection(language),
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
              'Erro ao carregar idiomas',
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
              onPressed: () => ref.read(languageProvider.notifier).refresh(),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLanguageSelection(AppLanguage selectedLanguage) async {
    if (_isChangingLanguage) return;

    // Verificar se já está selecionado
    final currentLanguage = ref.read(languageProvider).value;
    if (currentLanguage == selectedLanguage) {
      _closeDialog();
      return;
    }

    setState(() {
      _isChangingLanguage = true;
    });

    try {
      // Feedback háptico
      await HapticFeedback.lightImpact();

      // Alterar o idioma
      await ref.read(languageProvider.notifier).setLanguage(selectedLanguage);

      // Aguardar um pouco para mostrar mudança visual
      await Future<void>.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        _closeDialog();

        // Mostrar feedback de sucesso
        Burnt().toast(
          context,
          title: 'Idioma alterado para ${selectedLanguage.label}',
          preset: BurntPreset.done,
        );
      }
    } on Exception catch (_) {
      setState(() {
        _isChangingLanguage = false;
      });

      if (mounted) {
        Burnt().toast(
          context,
          title: 'Erro ao alterar idioma',
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

/// Widget individual para cada opção de idioma
class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.language,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final AppLanguage language;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  String get _flag {
    switch (language) {
      case AppLanguage.portuguese:
        return '🇧🇷';
      case AppLanguage.english:
        return '🇺🇸';
      case AppLanguage.spanish:
        return '🇪🇸';
    }
  }

  String get _nativeName {
    switch (language) {
      case AppLanguage.portuguese:
        return 'Portuguese';
      case AppLanguage.english:
        return 'English';
      case AppLanguage.spanish:
        return 'Español';
    }
  }

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
        // Bandeira como leading
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
            child: Center(
              child: Text(
                _flag,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),

        // Título e descrição
        title: Text(
          language.label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          _nativeName,
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
}
