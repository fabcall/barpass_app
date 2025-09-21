import 'package:flutter/material.dart';

/// Modelo de dados para itens da navegação inferior
///
/// Representa um item individual na barra de navegação com
/// ícone, rótulo e índice para identificação.
@immutable
class BottomNavItem {
  /// Cria um item de navegação inferior
  const BottomNavItem({
    required this.iconData,
    required this.label,
    required this.index,
    this.semanticLabel,
    this.isEnabled = true,
  });

  /// Ícone a ser exibido
  final IconData iconData;

  /// Texto do rótulo exibido abaixo do ícone
  final String label;

  /// Índice único para identificar este item
  final int index;

  /// Rótulo semântico para acessibilidade
  /// Se não fornecido, usa [label]
  final String? semanticLabel;

  /// Se o item está habilitado para interação
  final bool isEnabled;

  /// Retorna o rótulo semântico efetivo
  String get effectiveSemanticLabel => semanticLabel ?? label;

  /// Cria uma cópia deste item com valores modificados
  BottomNavItem copyWith({
    IconData? iconData,
    String? label,
    int? index,
    String? semanticLabel,
    bool? isEnabled,
  }) {
    return BottomNavItem(
      iconData: iconData ?? this.iconData,
      label: label ?? this.label,
      index: index ?? this.index,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BottomNavItem &&
        other.iconData == iconData &&
        other.label == label &&
        other.index == index &&
        other.semanticLabel == semanticLabel &&
        other.isEnabled == isEnabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      iconData,
      label,
      index,
      semanticLabel,
      isEnabled,
    );
  }

  @override
  String toString() {
    return 'BottomNavItem('
        'iconData: $iconData, '
        'label: $label, '
        'index: $index, '
        'semanticLabel: $semanticLabel, '
        'isEnabled: $isEnabled'
        ')';
  }
}
