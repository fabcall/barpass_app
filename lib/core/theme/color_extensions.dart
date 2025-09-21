import 'package:flutter/material.dart';

/// Extensão para adicionar cores personalizadas ao ColorScheme
extension CustomColorScheme on ColorScheme {
  /// Cor de sucesso (verde)
  Color get success {
    if (brightness == Brightness.light) {
      return const Color(0xFF10B981); // green-500
    } else {
      return const Color(0xFF34D399); // green-400
    }
  }

  /// Cor de aviso/alerta (amarelo/laranja)
  Color get warning {
    if (brightness == Brightness.light) {
      return const Color(0xFFF59E0B); // amber-500
    } else {
      return const Color(0xFFFBBF24); // amber-400
    }
  }

  /// Cor de informação (azul)
  Color get info {
    if (brightness == Brightness.light) {
      return const Color(0xFF3B82F6); // blue-500
    } else {
      return const Color(0xFF60A5FA); // blue-400
    }
  }
}
