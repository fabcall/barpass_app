import 'package:barpass_app/features/auth/domain/entities/auth_session.dart';
import 'package:fpdart/fpdart.dart';

/// Repository de autenticação
///
/// Responsável APENAS por operações de autenticação:
/// - Login/Register (retorna sessão)
/// - Gerenciamento de tokens
/// - Validação de sessão
/// - Logout
abstract class AuthRepository {
  /// Faz login e retorna a sessão de autenticação
  Future<Either<String, AuthSession>> login({
    required String email,
    required String password,
  });

  /// Registra novo usuário e retorna a sessão
  Future<Either<String, AuthSession>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Renova o access token usando o refresh token
  Future<Either<String, AuthSession>> refreshToken({
    required String refreshToken,
  });

  /// Valida se a sessão atual é válida
  Future<Either<String, bool>> validateSession();

  /// Obtém a sessão atual armazenada
  Future<Either<String, AuthSession?>> getCurrentSession();

  /// Faz logout e limpa a sessão
  Future<Either<String, void>> logout();

  /// Verifica se há uma sessão ativa
  Future<bool> hasActiveSession();

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
}
