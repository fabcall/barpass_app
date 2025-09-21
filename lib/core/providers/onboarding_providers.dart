import 'package:barpass_app/core/providers/providers.dart';
import 'package:barpass_app/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Estado do onboarding
class OnboardingState {
  final bool isCompleted;
  final bool isLoading;
  final bool isInitialized; // Nova propriedade para controlar inicialização

  const OnboardingState({
    required this.isCompleted,
    this.isLoading = false,
    this.isInitialized = false, // Por padrão não está inicializado
  });

  OnboardingState copyWith({
    bool? isCompleted,
    bool? isLoading,
    bool? isInitialized,
  }) {
    return OnboardingState(
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OnboardingState &&
        other.isCompleted == isCompleted &&
        other.isLoading == isLoading &&
        other.isInitialized == isInitialized;
  }

  @override
  int get hashCode => Object.hash(isCompleted, isLoading, isInitialized);
}

/// Notifier para o onboarding usando SharedPreferencesAsync
class OnboardingNotifier extends Notifier<OnboardingState> {
  StorageService get _storageService => ref.read(storageServiceProvider);

  @override
  OnboardingState build() {
    // Carregar estado inicial de forma assíncrona
    _loadInitialState();

    return const OnboardingState(
      isCompleted: false,
      isLoading: true,
      isInitialized: false,
    );
  }

  Future<void> _loadInitialState() async {
    try {
      final isCompleted = await _storageService.isOnboardingCompleted();

      state = OnboardingState(
        isCompleted: isCompleted,
        isLoading: false,
        isInitialized: true, // Marca como inicializado
      );
    } catch (e) {
      // Em caso de erro, assume que não foi completado
      state = const OnboardingState(
        isCompleted: false,
        isLoading: false,
        isInitialized: true, // Mesmo com erro, marca como inicializado
      );
    }
  }

  /// Versão otimista do completeOnboarding - atualiza o estado imediatamente
  Future<void> completeOnboarding() async {
    // MUDANÇA CHAVE: Atualiza o estado imediatamente de forma otimista
    state = state.copyWith(
      isCompleted: true,
      isLoading: false, // Não mostra loading durante a transição
    );

    // Salva no storage em background
    try {
      await _storageService.setOnboardingCompleted(true);
    } catch (e) {
      // Se der erro, o estado já está correto (otimista)
      // Opcionalmente poderia reverter aqui se necessário
    }
  }

  Future<void> resetOnboarding() async {
    state = state.copyWith(isLoading: true);

    try {
      await _storageService.setOnboardingCompleted(false);
      state = state.copyWith(
        isCompleted: false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isCompleted: false,
        isLoading: false,
      );
    }
  }
}

/// Provider para o onboarding
final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(() {
      return OnboardingNotifier();
    });
