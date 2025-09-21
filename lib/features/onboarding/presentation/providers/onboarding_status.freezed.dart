// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingStatus {

 bool get isCompleted; bool get isLoading; bool get isInitialized; String? get error;
/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStatusCopyWith<OnboardingStatus> get copyWith => _$OnboardingStatusCopyWithImpl<OnboardingStatus>(this as OnboardingStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatus&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isCompleted,isLoading,isInitialized,error);

@override
String toString() {
  return 'OnboardingStatus(isCompleted: $isCompleted, isLoading: $isLoading, isInitialized: $isInitialized, error: $error)';
}


}

/// @nodoc
abstract mixin class $OnboardingStatusCopyWith<$Res>  {
  factory $OnboardingStatusCopyWith(OnboardingStatus value, $Res Function(OnboardingStatus) _then) = _$OnboardingStatusCopyWithImpl;
@useResult
$Res call({
 bool isCompleted, bool isLoading, bool isInitialized, String? error
});




}
/// @nodoc
class _$OnboardingStatusCopyWithImpl<$Res>
    implements $OnboardingStatusCopyWith<$Res> {
  _$OnboardingStatusCopyWithImpl(this._self, this._then);

  final OnboardingStatus _self;
  final $Res Function(OnboardingStatus) _then;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCompleted = null,Object? isLoading = null,Object? isInitialized = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingStatus].
extension OnboardingStatusPatterns on OnboardingStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingStatus() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingStatus value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingStatus():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingStatus value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingStatus() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isCompleted,  bool isLoading,  bool isInitialized,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingStatus() when $default != null:
return $default(_that.isCompleted,_that.isLoading,_that.isInitialized,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isCompleted,  bool isLoading,  bool isInitialized,  String? error)  $default,) {final _that = this;
switch (_that) {
case _OnboardingStatus():
return $default(_that.isCompleted,_that.isLoading,_that.isInitialized,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isCompleted,  bool isLoading,  bool isInitialized,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingStatus() when $default != null:
return $default(_that.isCompleted,_that.isLoading,_that.isInitialized,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingStatus extends OnboardingStatus {
  const _OnboardingStatus({required this.isCompleted, this.isLoading = false, this.isInitialized = false, this.error}): super._();
  

@override final  bool isCompleted;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isInitialized;
@override final  String? error;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStatusCopyWith<_OnboardingStatus> get copyWith => __$OnboardingStatusCopyWithImpl<_OnboardingStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingStatus&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isCompleted,isLoading,isInitialized,error);

@override
String toString() {
  return 'OnboardingStatus(isCompleted: $isCompleted, isLoading: $isLoading, isInitialized: $isInitialized, error: $error)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStatusCopyWith<$Res> implements $OnboardingStatusCopyWith<$Res> {
  factory _$OnboardingStatusCopyWith(_OnboardingStatus value, $Res Function(_OnboardingStatus) _then) = __$OnboardingStatusCopyWithImpl;
@override @useResult
$Res call({
 bool isCompleted, bool isLoading, bool isInitialized, String? error
});




}
/// @nodoc
class __$OnboardingStatusCopyWithImpl<$Res>
    implements _$OnboardingStatusCopyWith<$Res> {
  __$OnboardingStatusCopyWithImpl(this._self, this._then);

  final _OnboardingStatus _self;
  final $Res Function(_OnboardingStatus) _then;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCompleted = null,Object? isLoading = null,Object? isInitialized = null,Object? error = freezed,}) {
  return _then(_OnboardingStatus(
isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
