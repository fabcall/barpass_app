// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  phoneNumber: json['phone_number'] as String?,
  isEmailVerified: json['is_email_verified'] as bool? ?? false,
  isPhoneVerified: json['is_phone_verified'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  lastLoginAt: json['last_login_at'] == null
      ? null
      : DateTime.parse(json['last_login_at'] as String),
  token: json['token'] as String?,
  refreshToken: json['refresh_token'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'phone_number': instance.phoneNumber,
      'is_email_verified': instance.isEmailVerified,
      'is_phone_verified': instance.isPhoneVerified,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
