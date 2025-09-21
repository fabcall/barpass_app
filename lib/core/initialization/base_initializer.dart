import 'package:flutter_riverpod/misc.dart';

/// Resultado de um inicializador
class InitializerResult {
  final List<Override> providerOverrides;
  final Map<String, dynamic> metadata;

  const InitializerResult({
    this.providerOverrides = const [],
    this.metadata = const {},
  });
}

/// Base para todos os inicializadores
abstract class BaseInitializer {
  /// Nome do inicializador para logs
  String get name;

  /// Se é crítico - falha interrompe a inicialização
  bool get isCritical => false;

  /// Método principal de inicialização
  Future<InitializerResult> initialize();
}
