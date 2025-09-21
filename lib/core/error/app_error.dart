import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
abstract class AppError with _$AppError {
  const factory AppError.network({
    required String message,
    String? code,
    @Default(false) bool isRetryable,
  }) = NetworkError;

  const factory AppError.storage({
    required String message,
    String? code,
  }) = StorageError;

  const factory AppError.validation({
    required String message,
    required String field,
  }) = ValidationError;

  const factory AppError.auth({
    required String message,
    String? code,
  }) = AuthError;

  const factory AppError.unknown({
    required String message,
    Object? originalError,
    StackTrace? stackTrace,
  }) = UnknownError;

  const AppError._();

  String get userFriendlyMessage => when(
    network: (message, code, isRetryable) =>
        isRetryable ? 'Erro de conexão. Tente novamente.' : message,
    storage: (message, code) => 'Erro ao salvar dados',
    validation: (message, field) => message,
    auth: (message, code) => 'Erro de autenticação',
    unknown: (message, originalError, stackTrace) => 'Erro inesperado',
  );

  bool get canRetry => when(
    network: (message, code, isRetryable) => isRetryable,
    storage: (message, code) => true,
    validation: (message, field) => false,
    auth: (message, code) => false,
    unknown: (message, originalError, stackTrace) => false,
  );
}
