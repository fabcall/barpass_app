import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

/// Repository de usuário
///
/// Responsável por operações relacionadas aos dados do usuário:
/// - Obter perfil
/// - Atualizar dados
/// - Upload de avatar
/// - Gerenciar preferências
abstract class UserRepository {
  /// Obtém o usuário atual (usa a sessão ativa)
  Future<Either<String, User>> getCurrentUser();

  /// Obtém um usuário por ID (perfil público)
  Future<Either<String, User>> getUserById(String userId);

  /// Atualiza o perfil do usuário
  Future<Either<String, User>> updateProfile({
    String? name,
    String? avatarUrl,
    String? phoneNumber,
  });

  /// Faz upload de avatar e retorna a URL
  Future<Either<String, String>> uploadAvatar(String filePath);

  /// Deleta a conta do usuário
  Future<Either<String, void>> deleteAccount();

  /// Verifica o email do usuário
  Future<Either<String, void>> verifyEmail(String code);

  /// Verifica o telefone do usuário
  Future<Either<String, void>> verifyPhone(String code);

  /// Atualiza as preferências do usuário
  Future<Either<String, void>> updatePreferences(
    Map<String, dynamic> preferences,
  );

  /// Obtém o usuário em cache (sem fazer requisição)
  Future<User?> getCachedUser();

  /// Limpa o cache do usuário
  Future<void> clearCache();
}
