// lib/app/presentation/state/app_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
sealed class AppState with _$AppState {
  const factory AppState({
    @Default(AppInitializationStatus.loading)
    AppInitializationStatus initStatus,
    String? error,
  }) = _AppState;

  const AppState._();

  // Helpers necessários para o router e UI
  bool get isReady => initStatus == AppInitializationStatus.completed;
  bool get hasError => initStatus == AppInitializationStatus.error;
  bool get isLoading => initStatus == AppInitializationStatus.loading;
}

enum AppInitializationStatus {
  loading,
  completed,
  error,
}
