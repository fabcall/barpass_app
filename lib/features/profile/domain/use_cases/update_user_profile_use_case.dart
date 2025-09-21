import 'package:barpass_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:barpass_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<String, User>> call({
    required String userId,
    String? name,
    String? phoneNumber,
    String? avatarUrl,
    Gender? gender,
  }) async {
    // Validações de negócio
    if (name != null && name.trim().isEmpty) {
      return left('Nome não pode estar vazio');
    }

    if (name != null && name.trim().length < 3) {
      return left('Nome deve ter pelo menos 3 caracteres');
    }

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
      if (digitsOnly.length < 10) {
        return left('Telefone deve ter pelo menos 10 dígitos');
      }
    }

    return _repository.updateProfile(
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      gender: gender,
    );
  }
}
