import 'dart:io';

import 'package:barpass_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadAvatarUseCase {
  UploadAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<String, String>> call({
    required String userId,
    required String imagePath,
  }) async {
    // Validações
    if (imagePath.isEmpty) {
      return left('Caminho da imagem não pode estar vazio');
    }

    final file = File(imagePath);
    if (!file.existsSync()) {
      return left('Arquivo não encontrado');
    }

    // Verifica o tamanho do arquivo (máximo 5MB)
    final fileSize = await file.length();
    const maxSize = 5 * 1024 * 1024; // 5MB em bytes

    if (fileSize > maxSize) {
      return left('Imagem muito grande. Tamanho máximo: 5MB');
    }

    return _repository.uploadAvatar(
      userId: userId,
      imagePath: imagePath,
    );
  }
}
