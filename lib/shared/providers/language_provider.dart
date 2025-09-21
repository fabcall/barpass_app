import 'package:barpass_app/shared/di/shared_dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

/// Estados possíveis para o idioma da aplicação
enum AppLanguage {
  portuguese('pt', 'Português'),
  english('en', 'English'),
  spanish('es', 'Español');

  const AppLanguage(this.code, this.label);

  final String code;
  final String label;

  /// Converte de string salva no storage
  static AppLanguage fromCode(String? code) {
    switch (code) {
      case 'en':
        return AppLanguage.english;
      case 'es':
        return AppLanguage.spanish;
      case 'pt':
      default:
        return AppLanguage.portuguese;
    }
  }

  /// Converte para string para salvar no storage
  String toStorageString() => code;
}

/// Provider para gerenciar o idioma da aplicação
@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  @override
  Future<AppLanguage> build() async {
    final languageLocalDataSource = ref.read(languageLocalDataSourceProvider);

    try {
      final savedLanguage = await languageLocalDataSource.getLanguage();
      return AppLanguage.fromCode(savedLanguage);
    } on Exception {
      // Em caso de erro, usar português como fallback
      return AppLanguage.portuguese;
    }
  }

  /// Altera o idioma da aplicação
  Future<void> setLanguage(AppLanguage newLanguage) async {
    // Atualização otimista
    state = AsyncValue.data(newLanguage);

    final languageLocalDataSource = ref.read(languageLocalDataSourceProvider);

    try {
      await languageLocalDataSource.saveLanguage(newLanguage.toStorageString());
    } on Exception catch (error, stackTrace) {
      // Reverter em caso de erro
      state = AsyncValue.error(error, stackTrace);

      // Tentar recarregar o idioma salvo
      final savedLanguage = await languageLocalDataSource.getLanguage();
      state = AsyncValue.data(AppLanguage.fromCode(savedLanguage));

      rethrow;
    }
  }

  /// Força o reload do idioma do storage
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final languageLocalDataSource = ref.read(languageLocalDataSourceProvider);
      final savedLanguage = await languageLocalDataSource.getLanguage();
      return AppLanguage.fromCode(savedLanguage);
    });
  }
}

/// Provider derivado que retorna o código do idioma atual
@riverpod
String currentLanguageCode(Ref ref) {
  final languageState = ref.watch(languageProvider);

  return languageState.when(
    data: (appLanguage) => appLanguage.code,
    loading: () => 'pt', // Fallback durante loading
    error: (_, _) => 'pt', // Fallback em caso de erro
  );
}
