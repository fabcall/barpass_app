import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:barpass_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:barpass_app/features/profile/domain/use_cases/update_avatar_use_case.dart';
import 'package:barpass_app/features/profile/domain/use_cases/update_user_profile_use_case.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_dependencies.g.dart';

/// Dependências do módulo profile
class ProfileDependencies {
  ProfileDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Repository
    profileRepositoryProvider,

    // Use Cases
    updateProfileUseCaseProvider,
    uploadAvatarUseCaseProvider,
  ];
}

// === REPOSITORY ===
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  // Pega a referência do repositório de auth para compartilhar o storage
  final authRepo = ref.read(authRepositoryProvider);

  // Em uma implementação real, você teria acesso ao storage compartilhado
  // Por ora, vamos criar uma nova instância
  // NOTA: Em produção, isso seria injetado de forma adequada
  final repo = ProfileRepositoryImpl({});
  return repo;
}

// === USE CASES ===
@Riverpod(keepAlive: true)
UpdateProfileUseCase updateProfileUseCase(Ref ref) {
  final repository = ref.read(profileRepositoryProvider);
  return UpdateProfileUseCase(repository);
}

@Riverpod(keepAlive: true)
UploadAvatarUseCase uploadAvatarUseCase(Ref ref) {
  final repository = ref.read(profileRepositoryProvider);
  return UploadAvatarUseCase(repository);
}
