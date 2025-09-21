import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    String? avatarUrl,
    String? phoneNumber,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _User;

  const User._();

  // APENAS business logic e computed properties
  String get displayName => name.isNotEmpty ? name : email;

  String get initials {
    if (name.isNotEmpty) {
      final parts = name.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return name[0].toUpperCase();
    }
    return email[0].toUpperCase();
  }

  bool get isFullyVerified => isEmailVerified && isPhoneVerified;

  bool get isProfileComplete =>
      name.isNotEmpty && email.isNotEmpty && avatarUrl != null;
}
