import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:barpass_app/features/auth/presentation/state/password_reset_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_reset_provider.g.dart';

@riverpod
class PasswordReset extends _$PasswordReset {
  @override
  PasswordResetState build() {
    return const PasswordResetState.initial();
  }

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<void> sendResetCode(String email) async {
    state = const PasswordResetState.sendingResetCode();

    // Validação
    if (email.isEmpty) {
      state = const PasswordResetState.error(
        message: 'Email é obrigatório',
        type: PasswordResetErrorType.sendCode,
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      state = const PasswordResetState.error(
        message: 'Email inválido',
        type: PasswordResetErrorType.sendCode,
      );
      return;
    }

    final result = await _repository.sendPasswordResetCode(email: email);

    result.fold(
      (error) => state = PasswordResetState.error(
        message: error,
        type: PasswordResetErrorType.sendCode,
      ),
      (_) => state = PasswordResetState.codeSent(email),
    );
  }

  Future<void> resendCode(String email) async {
    state = PasswordResetState.resendingCode(email);

    final result = await _repository.sendPasswordResetCode(email: email);

    result.fold(
      (error) => state = PasswordResetState.error(
        message: error,
        type: PasswordResetErrorType.resendCode,
        email: email,
      ),
      (_) => state = PasswordResetState.codeSent(email),
    );
  }

  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    state = PasswordResetState.verifyingCode(email);

    if (code.length != 6) {
      state = PasswordResetState.error(
        message: 'Código deve ter 6 dígitos',
        type: PasswordResetErrorType.verifyCode,
        email: email,
      );
      return;
    }

    final result = await _repository.verifyOtp(
      email: email,
      code: code,
    );

    result.fold(
      (error) => state = PasswordResetState.error(
        message: error,
        type: PasswordResetErrorType.verifyCode,
        email: email,
      ),
      (token) => state = PasswordResetState.codeVerified(
        email: email,
        token: token,
      ),
    );
  }

  Future<void> changePassword({
    required String token,
    required String newPassword,
  }) async {
    state = const PasswordResetState.changingPassword();

    // Validação
    if (newPassword.length < 8) {
      state = const PasswordResetState.error(
        message: 'Senha deve ter pelo menos 8 caracteres',
        type: PasswordResetErrorType.changePassword,
      );
      return;
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(newPassword)) {
      state = const PasswordResetState.error(
        message: 'Senha deve conter: 1 maiúscula, 1 minúscula e 1 número',
        type: PasswordResetErrorType.changePassword,
      );
      return;
    }

    final result = await _repository.changePassword(
      token: token,
      newPassword: newPassword,
    );

    result.fold(
      (error) => state = PasswordResetState.error(
        message: error,
        type: PasswordResetErrorType.changePassword,
      ),
      (_) => state = const PasswordResetState.passwordChanged(),
    );
  }

  void reset() {
    state = const PasswordResetState.initial();
  }
}
