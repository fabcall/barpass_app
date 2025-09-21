import 'package:barpass_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  /// Login com email e senha
  Future<Either<String, User>> login({
    required String email,
    required String password,
  });

  /// Registro de novo usuário
  Future<Either<String, User>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Envia código de recuperação de senha
  Future<Either<String, void>> sendPasswordResetCode({
    required String email,
  });

  /// Verifica código OTP
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String code,
  });

  /// Altera a senha com token
  Future<Either<String, void>> changePassword({
    required String token,
    required String newPassword,
  });

  /// Logout
  Future<Either<String, void>> logout();

  /// Obtém usuário atual
  Future<Either<String, User?>> getCurrentUser();
}
