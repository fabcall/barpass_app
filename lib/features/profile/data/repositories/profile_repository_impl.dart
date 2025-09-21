import 'package:barpass_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:barpass_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // Simulando armazenamento em memória (compartilhado com auth)
  final Map<String, Map<String, dynamic>> _users;

  ProfileRepositoryImpl(this._users);

  @override
  Future<Either<String, User>> updateProfile({
    required String userId,
    String? name,
    String? phoneNumber,
    String? avatarUrl,
    Gender? gender,
  }) async {
    // Simula delay de rede
    await Future<void>.delayed(const Duration(seconds: 1));

    // Busca o usuário pelo ID
    String? userEmail;
    for (final entry in _users.entries) {
      if (entry.value['id'] == userId) {
        userEmail = entry.key;
        break;
      }
    }

    if (userEmail == null) {
      return left('Usuário não encontrado');
    }

    final userData = _users[userEmail]!;

    // Atualiza apenas os campos fornecidos
    if (name != null) {
      if (name.trim().isEmpty) {
        return left('Nome não pode estar vazio');
      }
      if (name.trim().length < 3) {
        return left('Nome deve ter pelo menos 3 caracteres');
      }
      userData['name'] = name.trim();
    }

    if (phoneNumber != null) {
      if (phoneNumber.isNotEmpty) {
        final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
        if (digitsOnly.length < 10) {
          return left('Telefone inválido');
        }
      }
      userData['phoneNumber'] = phoneNumber.isEmpty ? null : phoneNumber.trim();
    }

    if (avatarUrl != null) {
      userData['avatarUrl'] = avatarUrl;
    }

    if (gender != null) {
      userData['gender'] = gender;
    }

    // Retorna o usuário atualizado
    final updatedUser = User(
      id: userData['id'] as String,
      email: userEmail,
      name: userData['name'] as String,
      avatarUrl: userData['avatarUrl'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      isEmailVerified: userData['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: userData['isPhoneVerified'] as bool? ?? false,
      createdAt: userData['createdAt'] as DateTime?,
      lastLoginAt: userData['lastLoginAt'] as DateTime?,
      gender: userData['gender'] as Gender?,
    );

    return right(updatedUser);
  }

  @override
  Future<Either<String, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  }) async {
    // Simula delay de upload
    await Future<void>.delayed(const Duration(seconds: 2));

    // Simula URL de uma imagem hospedada
    // Em produção, você faria o upload real para um serviço de storage
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fakeUrl =
        'https://api.example.com/uploads/avatars/$userId-$timestamp.jpg';

    // Simula possível erro de upload (5% de chance)
    if (DateTime.now().millisecond % 20 == 0) {
      return left('Erro ao fazer upload da imagem. Tente novamente.');
    }

    return right(fakeUrl);
  }
}
