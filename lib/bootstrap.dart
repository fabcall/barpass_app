import 'dart:async';

import 'package:barpass_app/core/initialization/app_initializer.dart';
import 'package:barpass_app/core/initialization/error_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Configurar tratamento de erros
  AppErrorHandler.initialize();

  // Inicialização robusta da aplicação
  final initResult = await AppInitializer.initialize();

  // Executar a aplicação com providers configurados
  runApp(
    ProviderScope(
      overrides: initResult.providerOverrides,
      child: await builder(),
    ),
  );
}
