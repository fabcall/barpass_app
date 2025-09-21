// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEditState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState()';
}


}

/// @nodoc
class $ProfileEditStateCopyWith<$Res>  {
$ProfileEditStateCopyWith(ProfileEditState _, $Res Function(ProfileEditState) __);
}


/// Adds pattern-matching-related methods to [ProfileEditState].
extension ProfileEditStatePatterns on ProfileEditState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileEditInitial value)?  initial,TResult Function( ProfileEditLoading value)?  loading,TResult Function( ProfileEditSuccess value)?  success,TResult Function( ProfileEditError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial(_that);case ProfileEditLoading() when loading != null:
return loading(_that);case ProfileEditSuccess() when success != null:
return success(_that);case ProfileEditError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileEditInitial value)  initial,required TResult Function( ProfileEditLoading value)  loading,required TResult Function( ProfileEditSuccess value)  success,required TResult Function( ProfileEditError value)  error,}){
final _that = this;
switch (_that) {
case ProfileEditInitial():
return initial(_that);case ProfileEditLoading():
return loading(_that);case ProfileEditSuccess():
return success(_that);case ProfileEditError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileEditInitial value)?  initial,TResult? Function( ProfileEditLoading value)?  loading,TResult? Function( ProfileEditSuccess value)?  success,TResult? Function( ProfileEditError value)?  error,}){
final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial(_that);case ProfileEditLoading() when loading != null:
return loading(_that);case ProfileEditSuccess() when success != null:
return success(_that);case ProfileEditError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( User user)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial();case ProfileEditLoading() when loading != null:
return loading();case ProfileEditSuccess() when success != null:
return success(_that.user);case ProfileEditError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( User user)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ProfileEditInitial():
return initial();case ProfileEditLoading():
return loading();case ProfileEditSuccess():
return success(_that.user);case ProfileEditError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( User user)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial();case ProfileEditLoading() when loading != null:
return loading();case ProfileEditSuccess() when success != null:
return success(_that.user);case ProfileEditError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ProfileEditInitial implements ProfileEditState {
  const ProfileEditInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState.initial()';
}


}




/// @nodoc


class ProfileEditLoading implements ProfileEditState {
  const ProfileEditLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState.loading()';
}


}




/// @nodoc


class ProfileEditSuccess implements ProfileEditState {
  const ProfileEditSuccess(this.user);
  

 final  User user;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditSuccessCopyWith<ProfileEditSuccess> get copyWith => _$ProfileEditSuccessCopyWithImpl<ProfileEditSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'ProfileEditState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $ProfileEditSuccessCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditSuccessCopyWith(ProfileEditSuccess value, $Res Function(ProfileEditSuccess) _then) = _$ProfileEditSuccessCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$ProfileEditSuccessCopyWithImpl<$Res>
    implements $ProfileEditSuccessCopyWith<$Res> {
  _$ProfileEditSuccessCopyWithImpl(this._self, this._then);

  final ProfileEditSuccess _self;
  final $Res Function(ProfileEditSuccess) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(ProfileEditSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class ProfileEditError implements ProfileEditState {
  const ProfileEditError(this.message);
  

 final  String message;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditErrorCopyWith<ProfileEditError> get copyWith => _$ProfileEditErrorCopyWithImpl<ProfileEditError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProfileEditState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileEditErrorCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditErrorCopyWith(ProfileEditError value, $Res Function(ProfileEditError) _then) = _$ProfileEditErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProfileEditErrorCopyWithImpl<$Res>
    implements $ProfileEditErrorCopyWith<$Res> {
  _$ProfileEditErrorCopyWithImpl(this._self, this._then);

  final ProfileEditError _self;
  final $Res Function(ProfileEditError) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProfileEditError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
