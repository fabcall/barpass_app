import 'package:barpass_app/features/auth/domain/entities/auth_session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

@freezed
sealed class AuthSessionModel with _$AuthSessionModel {
  const factory AuthSessionModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    @JsonKey(name: 'token_type') @Default('Bearer') String tokenType,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  const AuthSessionModel._();

  /// Converte para entity
  AuthSession toEntity() => AuthSession(
    userId: userId,
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresAt: expiresAt,
    tokenType: tokenType,
    createdAt: createdAt,
  );

  /// Cria model a partir de entity
  factory AuthSessionModel.fromEntity(AuthSession session) => AuthSessionModel(
    userId: session.userId,
    accessToken: session.accessToken,
    refreshToken: session.refreshToken,
    expiresAt: session.expiresAt,
    tokenType: session.tokenType,
    createdAt: session.createdAt,
  );
}
