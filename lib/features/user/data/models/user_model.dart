import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'is_email_verified') @Default(false) bool isEmailVerified,
    @JsonKey(name: 'is_phone_verified') @Default(false) bool isPhoneVerified,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
    String? token, // Apenas no model para dados de API
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _UserModel;

  // Conversão de entity
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    name: user.name,
    avatarUrl: user.avatarUrl,
    phoneNumber: user.phoneNumber,
    isEmailVerified: user.isEmailVerified,
    isPhoneVerified: user.isPhoneVerified,
    createdAt: user.createdAt,
    lastLoginAt: user.lastLoginAt,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  // Conversão para entity
  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    avatarUrl: avatarUrl,
    phoneNumber: phoneNumber,
    isEmailVerified: isEmailVerified,
    isPhoneVerified: isPhoneVerified,
    createdAt: createdAt,
    lastLoginAt: lastLoginAt,
  );
}
