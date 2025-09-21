import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_edit_state.freezed.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = ProfileEditInitial;
  const factory ProfileEditState.loading() = ProfileEditLoading;
  const factory ProfileEditState.success(User user) = ProfileEditSuccess;
  const factory ProfileEditState.error(String message) = ProfileEditError;
}
