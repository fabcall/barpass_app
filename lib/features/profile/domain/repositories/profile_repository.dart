import 'package:barpass_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProfileRepository {
  /// Atualiza o perfil do usuário
  Future<Either<String, User>> updateProfile({
    required String userId,
    String? name,
    String? phoneNumber,
    String? avatarUrl,
    Gender? gender,
  });

  /// Faz upload de uma imagem de avatar
  Future<Either<String, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  });
}
