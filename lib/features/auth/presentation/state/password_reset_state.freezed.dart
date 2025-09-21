// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_reset_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordResetState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PasswordResetState()';
}


}

/// @nodoc
class $PasswordResetStateCopyWith<$Res>  {
$PasswordResetStateCopyWith(PasswordResetState _, $Res Function(PasswordResetState) __);
}


/// Adds pattern-matching-related methods to [PasswordResetState].
extension PasswordResetStatePatterns on PasswordResetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _SendingResetCode value)?  sendingResetCode,TResult Function( _CodeSent value)?  codeSent,TResult Function( _ResendingCode value)?  resendingCode,TResult Function( _VerifyingCode value)?  verifyingCode,TResult Function( _CodeVerified value)?  codeVerified,TResult Function( _ChangingPassword value)?  changingPassword,TResult Function( _PasswordChanged value)?  passwordChanged,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SendingResetCode() when sendingResetCode != null:
return sendingResetCode(_that);case _CodeSent() when codeSent != null:
return codeSent(_that);case _ResendingCode() when resendingCode != null:
return resendingCode(_that);case _VerifyingCode() when verifyingCode != null:
return verifyingCode(_that);case _CodeVerified() when codeVerified != null:
return codeVerified(_that);case _ChangingPassword() when changingPassword != null:
return changingPassword(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _SendingResetCode value)  sendingResetCode,required TResult Function( _CodeSent value)  codeSent,required TResult Function( _ResendingCode value)  resendingCode,required TResult Function( _VerifyingCode value)  verifyingCode,required TResult Function( _CodeVerified value)  codeVerified,required TResult Function( _ChangingPassword value)  changingPassword,required TResult Function( _PasswordChanged value)  passwordChanged,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _SendingResetCode():
return sendingResetCode(_that);case _CodeSent():
return codeSent(_that);case _ResendingCode():
return resendingCode(_that);case _VerifyingCode():
return verifyingCode(_that);case _CodeVerified():
return codeVerified(_that);case _ChangingPassword():
return changingPassword(_that);case _PasswordChanged():
return passwordChanged(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _SendingResetCode value)?  sendingResetCode,TResult? Function( _CodeSent value)?  codeSent,TResult? Function( _ResendingCode value)?  resendingCode,TResult? Function( _VerifyingCode value)?  verifyingCode,TResult? Function( _CodeVerified value)?  codeVerified,TResult? Function( _ChangingPassword value)?  changingPassword,TResult? Function( _PasswordChanged value)?  passwordChanged,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SendingResetCode() when sendingResetCode != null:
return sendingResetCode(_that);case _CodeSent() when codeSent != null:
return codeSent(_that);case _ResendingCode() when resendingCode != null:
return resendingCode(_that);case _VerifyingCode() when verifyingCode != null:
return verifyingCode(_that);case _CodeVerified() when codeVerified != null:
return codeVerified(_that);case _ChangingPassword() when changingPassword != null:
return changingPassword(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  sendingResetCode,TResult Function( String email)?  codeSent,TResult Function( String email)?  resendingCode,TResult Function( String email)?  verifyingCode,TResult Function( String email,  String token)?  codeVerified,TResult Function()?  changingPassword,TResult Function()?  passwordChanged,TResult Function( String message,  PasswordResetErrorType type,  String? email)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _SendingResetCode() when sendingResetCode != null:
return sendingResetCode();case _CodeSent() when codeSent != null:
return codeSent(_that.email);case _ResendingCode() when resendingCode != null:
return resendingCode(_that.email);case _VerifyingCode() when verifyingCode != null:
return verifyingCode(_that.email);case _CodeVerified() when codeVerified != null:
return codeVerified(_that.email,_that.token);case _ChangingPassword() when changingPassword != null:
return changingPassword();case _PasswordChanged() when passwordChanged != null:
return passwordChanged();case _Error() when error != null:
return error(_that.message,_that.type,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  sendingResetCode,required TResult Function( String email)  codeSent,required TResult Function( String email)  resendingCode,required TResult Function( String email)  verifyingCode,required TResult Function( String email,  String token)  codeVerified,required TResult Function()  changingPassword,required TResult Function()  passwordChanged,required TResult Function( String message,  PasswordResetErrorType type,  String? email)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _SendingResetCode():
return sendingResetCode();case _CodeSent():
return codeSent(_that.email);case _ResendingCode():
return resendingCode(_that.email);case _VerifyingCode():
return verifyingCode(_that.email);case _CodeVerified():
return codeVerified(_that.email,_that.token);case _ChangingPassword():
return changingPassword();case _PasswordChanged():
return passwordChanged();case _Error():
return error(_that.message,_that.type,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  sendingResetCode,TResult? Function( String email)?  codeSent,TResult? Function( String email)?  resendingCode,TResult? Function( String email)?  verifyingCode,TResult? Function( String email,  String token)?  codeVerified,TResult? Function()?  changingPassword,TResult? Function()?  passwordChanged,TResult? Function( String message,  PasswordResetErrorType type,  String? email)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _SendingResetCode() when sendingResetCode != null:
return sendingResetCode();case _CodeSent() when codeSent != null:
return codeSent(_that.email);case _ResendingCode() when resendingCode != null:
return resendingCode(_that.email);case _VerifyingCode() when verifyingCode != null:
return verifyingCode(_that.email);case _CodeVerified() when codeVerified != null:
return codeVerified(_that.email,_that.token);case _ChangingPassword() when changingPassword != null:
return changingPassword();case _PasswordChanged() when passwordChanged != null:
return passwordChanged();case _Error() when error != null:
return error(_that.message,_that.type,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PasswordResetState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PasswordResetState.initial()';
}


}




/// @nodoc


class _SendingResetCode implements PasswordResetState {
  const _SendingResetCode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendingResetCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PasswordResetState.sendingResetCode()';
}


}




/// @nodoc


class _CodeSent implements PasswordResetState {
  const _CodeSent(this.email);
  

 final  String email;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeSentCopyWith<_CodeSent> get copyWith => __$CodeSentCopyWithImpl<_CodeSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeSent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'PasswordResetState.codeSent(email: $email)';
}


}

/// @nodoc
abstract mixin class _$CodeSentCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$CodeSentCopyWith(_CodeSent value, $Res Function(_CodeSent) _then) = __$CodeSentCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$CodeSentCopyWithImpl<$Res>
    implements _$CodeSentCopyWith<$Res> {
  __$CodeSentCopyWithImpl(this._self, this._then);

  final _CodeSent _self;
  final $Res Function(_CodeSent) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_CodeSent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendingCode implements PasswordResetState {
  const _ResendingCode(this.email);
  

 final  String email;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendingCodeCopyWith<_ResendingCode> get copyWith => __$ResendingCodeCopyWithImpl<_ResendingCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendingCode&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'PasswordResetState.resendingCode(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResendingCodeCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$ResendingCodeCopyWith(_ResendingCode value, $Res Function(_ResendingCode) _then) = __$ResendingCodeCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResendingCodeCopyWithImpl<$Res>
    implements _$ResendingCodeCopyWith<$Res> {
  __$ResendingCodeCopyWithImpl(this._self, this._then);

  final _ResendingCode _self;
  final $Res Function(_ResendingCode) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResendingCode(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyingCode implements PasswordResetState {
  const _VerifyingCode(this.email);
  

 final  String email;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyingCodeCopyWith<_VerifyingCode> get copyWith => __$VerifyingCodeCopyWithImpl<_VerifyingCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyingCode&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'PasswordResetState.verifyingCode(email: $email)';
}


}

/// @nodoc
abstract mixin class _$VerifyingCodeCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$VerifyingCodeCopyWith(_VerifyingCode value, $Res Function(_VerifyingCode) _then) = __$VerifyingCodeCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$VerifyingCodeCopyWithImpl<$Res>
    implements _$VerifyingCodeCopyWith<$Res> {
  __$VerifyingCodeCopyWithImpl(this._self, this._then);

  final _VerifyingCode _self;
  final $Res Function(_VerifyingCode) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_VerifyingCode(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CodeVerified implements PasswordResetState {
  const _CodeVerified({required this.email, required this.token});
  

 final  String email;
 final  String token;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeVerifiedCopyWith<_CodeVerified> get copyWith => __$CodeVerifiedCopyWithImpl<_CodeVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeVerified&&(identical(other.email, email) || other.email == email)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,email,token);

@override
String toString() {
  return 'PasswordResetState.codeVerified(email: $email, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CodeVerifiedCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$CodeVerifiedCopyWith(_CodeVerified value, $Res Function(_CodeVerified) _then) = __$CodeVerifiedCopyWithImpl;
@useResult
$Res call({
 String email, String token
});




}
/// @nodoc
class __$CodeVerifiedCopyWithImpl<$Res>
    implements _$CodeVerifiedCopyWith<$Res> {
  __$CodeVerifiedCopyWithImpl(this._self, this._then);

  final _CodeVerified _self;
  final $Res Function(_CodeVerified) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? token = null,}) {
  return _then(_CodeVerified(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ChangingPassword implements PasswordResetState {
  const _ChangingPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangingPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PasswordResetState.changingPassword()';
}


}




/// @nodoc


class _PasswordChanged implements PasswordResetState {
  const _PasswordChanged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordChanged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PasswordResetState.passwordChanged()';
}


}




/// @nodoc


class _Error implements PasswordResetState {
  const _Error({required this.message, required this.type, this.email});
  

 final  String message;
 final  PasswordResetErrorType type;
 final  String? email;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,message,type,email);

@override
String toString() {
  return 'PasswordResetState.error(message: $message, type: $type, email: $email)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, PasswordResetErrorType type, String? email
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? type = null,Object? email = freezed,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PasswordResetErrorType,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
