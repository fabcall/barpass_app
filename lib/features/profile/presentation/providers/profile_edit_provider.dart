import 'package:barpass_app/features/profile/presentation/state/profile_edit_state.dart';
import 'package:barpass_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:barpass_app/features/user/presentation/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_edit_provider.g.dart';

/// Notifier para edição de perfil
///
/// Coordena a atualização de dados do usuário e avatar
@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  ProfileEditState build() {
    return const ProfileEditState.initial();
  }

  /// Atualiza o perfil do usuário
  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? avatarUrl,
    Gender? gender,
  }) async {
    state = const ProfileEditState.loading();

    try {
      // Usa o UserNotifier para atualizar o perfil
      await ref
          .read(userProvider.notifier)
          .updateProfile(
            name: name,
            phoneNumber: phoneNumber,
          );

      // Obtém o usuário atualizado
      final user = ref.read(currentUserProvider);

      if (user != null) {
        state = ProfileEditState.success(user);
      } else {
        state = const ProfileEditState.error('Erro ao atualizar perfil');
      }
    } on Exception catch (e) {
      state = ProfileEditState.error(e.toString());
    }
  }

  /// Faz upload de avatar
  Future<void> uploadAvatar(String filePath) async {
    state = const ProfileEditState.loading();

    try {
      // Usa o UserNotifier para fazer upload
      await ref.read(userProvider.notifier).uploadAvatar(filePath);

      // Obtém o usuário atualizado
      final user = ref.read(currentUserProvider);

      if (user != null) {
        state = ProfileEditState.success(user);
      } else {
        state = const ProfileEditState.error('Erro ao atualizar avatar');
      }
    } catch (e) {
      state = ProfileEditState.error(e.toString());
    }
  }

  /// Remove avatar (atualiza com null)
  Future<void> removeAvatar() async {
    state = const ProfileEditState.loading();

    try {
      await ref
          .read(userProvider.notifier)
          .updateProfile(
            avatarUrl: null,
          );

      final user = ref.read(currentUserProvider);

      if (user != null) {
        state = ProfileEditState.success(user);
      } else {
        state = const ProfileEditState.error('Erro ao remover avatar');
      }
    } on Exception catch (e) {
      state = ProfileEditState.error(e.toString());
    }
  }

  /// Reseta o state para inicial
  void reset() {
    state = const ProfileEditState.initial();
  }
}
