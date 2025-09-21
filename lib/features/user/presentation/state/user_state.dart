import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded(User user) = UserLoaded;
  const factory UserState.unauthenticated() = UserUnauthenticated;
  const factory UserState.error(String message) = UserError;
}
