import 'package:barpass_app/app/presentation/state/app_state.dart';
import 'package:barpass_app/shared/providers/language_provider.dart';
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    _initialize();
    return const AppState();
  }

  Future<void> _initialize() async {
    try {
      // Iniciar operações de inicialização em paralelo
      await Future.wait([
        // Aguardar carregamento dos providers essenciais
        _ensureProvidersLoaded(),
        // Garantir tempo mínimo para animação (2.5 segundos)
        Future<void>.delayed(const Duration(milliseconds: 2500)),
      ]);

      state = state.copyWith(
        initStatus: AppInitializationStatus.completed,
        error: null,
      );
    } on Exception catch (error) {
      // Mesmo em caso de erro, aguarda o tempo mínimo
      await Future<void>.delayed(const Duration(milliseconds: 2500));

      state = state.copyWith(
        initStatus: AppInitializationStatus.error,
        error: error.toString(),
      );
    }
  }

  Future<void> _ensureProvidersLoaded() async {
    // Simply ensure both providers have completed loading
    // We don't store their values - just wait for them to be ready
    await Future.wait([
      ref.read(languageProvider.future),
      ref.read(themeProvider.future),
    ]);
  }

  Future<void> retry() async {
    state = const AppState(); // Reset to loading
    await _initialize();
  }
}
