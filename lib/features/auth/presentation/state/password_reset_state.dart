import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_state.freezed.dart';

enum PasswordResetErrorType {
  sendCode,
  resendCode,
  verifyCode,
  changePassword,
}

@freezed
class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState.initial() = _Initial;
  const factory PasswordResetState.sendingResetCode() = _SendingResetCode;
  const factory PasswordResetState.codeSent(String email) = _CodeSent;
  const factory PasswordResetState.resendingCode(String email) = _ResendingCode;
  const factory PasswordResetState.verifyingCode(String email) = _VerifyingCode;
  const factory PasswordResetState.codeVerified({
    required String email,
    required String token,
  }) = _CodeVerified;
  const factory PasswordResetState.changingPassword() = _ChangingPassword;
  const factory PasswordResetState.passwordChanged() = _PasswordChanged;
  const factory PasswordResetState.error({
    required String message,
    required PasswordResetErrorType type,
    String? email,
  }) = _Error;
}
