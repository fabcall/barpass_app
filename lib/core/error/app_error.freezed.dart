// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppError {

 String get message;
/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppErrorCopyWith<AppError> get copyWith => _$AppErrorCopyWithImpl<AppError>(this as AppError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppError(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppErrorCopyWith<$Res>  {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) _then) = _$AppErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AppErrorCopyWithImpl<$Res>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._self, this._then);

  final AppError _self;
  final $Res Function(AppError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppError].
extension AppErrorPatterns on AppError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkError value)?  network,TResult Function( StorageError value)?  storage,TResult Function( ValidationError value)?  validation,TResult Function( AuthError value)?  auth,TResult Function( UnknownError value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that);case StorageError() when storage != null:
return storage(_that);case ValidationError() when validation != null:
return validation(_that);case AuthError() when auth != null:
return auth(_that);case UnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkError value)  network,required TResult Function( StorageError value)  storage,required TResult Function( ValidationError value)  validation,required TResult Function( AuthError value)  auth,required TResult Function( UnknownError value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkError():
return network(_that);case StorageError():
return storage(_that);case ValidationError():
return validation(_that);case AuthError():
return auth(_that);case UnknownError():
return unknown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkError value)?  network,TResult? Function( StorageError value)?  storage,TResult? Function( ValidationError value)?  validation,TResult? Function( AuthError value)?  auth,TResult? Function( UnknownError value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that);case StorageError() when storage != null:
return storage(_that);case ValidationError() when validation != null:
return validation(_that);case AuthError() when auth != null:
return auth(_that);case UnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  String? code,  bool isRetryable)?  network,TResult Function( String message,  String? code)?  storage,TResult Function( String message,  String field)?  validation,TResult Function( String message,  String? code)?  auth,TResult Function( String message,  Object? originalError,  StackTrace? stackTrace)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that.message,_that.code,_that.isRetryable);case StorageError() when storage != null:
return storage(_that.message,_that.code);case ValidationError() when validation != null:
return validation(_that.message,_that.field);case AuthError() when auth != null:
return auth(_that.message,_that.code);case UnknownError() when unknown != null:
return unknown(_that.message,_that.originalError,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  String? code,  bool isRetryable)  network,required TResult Function( String message,  String? code)  storage,required TResult Function( String message,  String field)  validation,required TResult Function( String message,  String? code)  auth,required TResult Function( String message,  Object? originalError,  StackTrace? stackTrace)  unknown,}) {final _that = this;
switch (_that) {
case NetworkError():
return network(_that.message,_that.code,_that.isRetryable);case StorageError():
return storage(_that.message,_that.code);case ValidationError():
return validation(_that.message,_that.field);case AuthError():
return auth(_that.message,_that.code);case UnknownError():
return unknown(_that.message,_that.originalError,_that.stackTrace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  String? code,  bool isRetryable)?  network,TResult? Function( String message,  String? code)?  storage,TResult? Function( String message,  String field)?  validation,TResult? Function( String message,  String? code)?  auth,TResult? Function( String message,  Object? originalError,  StackTrace? stackTrace)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that.message,_that.code,_that.isRetryable);case StorageError() when storage != null:
return storage(_that.message,_that.code);case ValidationError() when validation != null:
return validation(_that.message,_that.field);case AuthError() when auth != null:
return auth(_that.message,_that.code);case UnknownError() when unknown != null:
return unknown(_that.message,_that.originalError,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class NetworkError extends AppError {
  const NetworkError({required this.message, this.code, this.isRetryable = false}): super._();
  

@override final  String message;
 final  String? code;
@JsonKey() final  bool isRetryable;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkErrorCopyWith<NetworkError> get copyWith => _$NetworkErrorCopyWithImpl<NetworkError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&(identical(other.isRetryable, isRetryable) || other.isRetryable == isRetryable));
}


@override
int get hashCode => Object.hash(runtimeType,message,code,isRetryable);

@override
String toString() {
  return 'AppError.network(message: $message, code: $code, isRetryable: $isRetryable)';
}


}

/// @nodoc
abstract mixin class $NetworkErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $NetworkErrorCopyWith(NetworkError value, $Res Function(NetworkError) _then) = _$NetworkErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String? code, bool isRetryable
});




}
/// @nodoc
class _$NetworkErrorCopyWithImpl<$Res>
    implements $NetworkErrorCopyWith<$Res> {
  _$NetworkErrorCopyWithImpl(this._self, this._then);

  final NetworkError _self;
  final $Res Function(NetworkError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,Object? isRetryable = null,}) {
  return _then(NetworkError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isRetryable: null == isRetryable ? _self.isRetryable : isRetryable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StorageError extends AppError {
  const StorageError({required this.message, this.code}): super._();
  

@override final  String message;
 final  String? code;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageErrorCopyWith<StorageError> get copyWith => _$StorageErrorCopyWithImpl<StorageError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'AppError.storage(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $StorageErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $StorageErrorCopyWith(StorageError value, $Res Function(StorageError) _then) = _$StorageErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String? code
});




}
/// @nodoc
class _$StorageErrorCopyWithImpl<$Res>
    implements $StorageErrorCopyWith<$Res> {
  _$StorageErrorCopyWithImpl(this._self, this._then);

  final StorageError _self;
  final $Res Function(StorageError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(StorageError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ValidationError extends AppError {
  const ValidationError({required this.message, required this.field}): super._();
  

@override final  String message;
 final  String field;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationErrorCopyWith<ValidationError> get copyWith => _$ValidationErrorCopyWithImpl<ValidationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationError&&(identical(other.message, message) || other.message == message)&&(identical(other.field, field) || other.field == field));
}


@override
int get hashCode => Object.hash(runtimeType,message,field);

@override
String toString() {
  return 'AppError.validation(message: $message, field: $field)';
}


}

/// @nodoc
abstract mixin class $ValidationErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $ValidationErrorCopyWith(ValidationError value, $Res Function(ValidationError) _then) = _$ValidationErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String field
});




}
/// @nodoc
class _$ValidationErrorCopyWithImpl<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  _$ValidationErrorCopyWithImpl(this._self, this._then);

  final ValidationError _self;
  final $Res Function(ValidationError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? field = null,}) {
  return _then(ValidationError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthError extends AppError {
  const AuthError({required this.message, this.code}): super._();
  

@override final  String message;
 final  String? code;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthErrorCopyWith<AuthError> get copyWith => _$AuthErrorCopyWithImpl<AuthError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'AppError.auth(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $AuthErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) _then) = _$AuthErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String? code
});




}
/// @nodoc
class _$AuthErrorCopyWithImpl<$Res>
    implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(this._self, this._then);

  final AuthError _self;
  final $Res Function(AuthError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(AuthError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnknownError extends AppError {
  const UnknownError({required this.message, this.originalError, this.stackTrace}): super._();
  

@override final  String message;
 final  Object? originalError;
 final  StackTrace? stackTrace;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownErrorCopyWith<UnknownError> get copyWith => _$UnknownErrorCopyWithImpl<UnknownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError),stackTrace);

@override
String toString() {
  return 'AppError.unknown(message: $message, originalError: $originalError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnknownErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $UnknownErrorCopyWith(UnknownError value, $Res Function(UnknownError) _then) = _$UnknownErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? originalError, StackTrace? stackTrace
});




}
/// @nodoc
class _$UnknownErrorCopyWithImpl<$Res>
    implements $UnknownErrorCopyWith<$Res> {
  _$UnknownErrorCopyWithImpl(this._self, this._then);

  final UnknownError _self;
  final $Res Function(UnknownError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,Object? stackTrace = freezed,}) {
  return _then(UnknownError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
