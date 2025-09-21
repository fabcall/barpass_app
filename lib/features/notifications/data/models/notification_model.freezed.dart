// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationModel {

 String get id; String get title; String get body; String get type; DateTime get receivedAt; bool get isRead; Map<String, dynamic>? get data; String? get imageUrl; String? get actionUrl;
/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationModelCopyWith<NotificationModel> get copyWith => _$NotificationModelCopyWithImpl<NotificationModel>(this as NotificationModel, _$identity);

  /// Serializes this NotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,receivedAt,isRead,const DeepCollectionEquality().hash(data),imageUrl,actionUrl);

@override
String toString() {
  return 'NotificationModel(id: $id, title: $title, body: $body, type: $type, receivedAt: $receivedAt, isRead: $isRead, data: $data, imageUrl: $imageUrl, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class $NotificationModelCopyWith<$Res>  {
  factory $NotificationModelCopyWith(NotificationModel value, $Res Function(NotificationModel) _then) = _$NotificationModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, String type, DateTime receivedAt, bool isRead, Map<String, dynamic>? data, String? imageUrl, String? actionUrl
});




}
/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._self, this._then);

  final NotificationModel _self;
  final $Res Function(NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? receivedAt = null,Object? isRead = null,Object? data = freezed,Object? imageUrl = freezed,Object? actionUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationModel].
extension NotificationModelPatterns on NotificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.receivedAt,_that.isRead,_that.data,_that.imageUrl,_that.actionUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)  $default,) {final _that = this;
switch (_that) {
case _NotificationModel():
return $default(_that.id,_that.title,_that.body,_that.type,_that.receivedAt,_that.isRead,_that.data,_that.imageUrl,_that.actionUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  String type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)?  $default,) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.receivedAt,_that.isRead,_that.data,_that.imageUrl,_that.actionUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationModel extends NotificationModel {
  const _NotificationModel({required this.id, required this.title, required this.body, required this.type, required this.receivedAt, this.isRead = false, final  Map<String, dynamic>? data, this.imageUrl, this.actionUrl}): _data = data,super._();
  factory _NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  String type;
@override final  DateTime receivedAt;
@override@JsonKey() final  bool isRead;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? imageUrl;
@override final  String? actionUrl;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationModelCopyWith<_NotificationModel> get copyWith => __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,receivedAt,isRead,const DeepCollectionEquality().hash(_data),imageUrl,actionUrl);

@override
String toString() {
  return 'NotificationModel(id: $id, title: $title, body: $body, type: $type, receivedAt: $receivedAt, isRead: $isRead, data: $data, imageUrl: $imageUrl, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class _$NotificationModelCopyWith<$Res> implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(_NotificationModel value, $Res Function(_NotificationModel) _then) = __$NotificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, String type, DateTime receivedAt, bool isRead, Map<String, dynamic>? data, String? imageUrl, String? actionUrl
});




}
/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(this._self, this._then);

  final _NotificationModel _self;
  final $Res Function(_NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? receivedAt = null,Object? isRead = null,Object? data = freezed,Object? imageUrl = freezed,Object? actionUrl = freezed,}) {
  return _then(_NotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationPreferencesModel {

 bool get enablePromotions; bool get enableOrders; bool get enableFavorites; bool get enableGeneral; bool get enableSound; bool get enableVibration; bool get enableBadge;
/// Create a copy of NotificationPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesModelCopyWith<NotificationPreferencesModel> get copyWith => _$NotificationPreferencesModelCopyWithImpl<NotificationPreferencesModel>(this as NotificationPreferencesModel, _$identity);

  /// Serializes this NotificationPreferencesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesModel&&(identical(other.enablePromotions, enablePromotions) || other.enablePromotions == enablePromotions)&&(identical(other.enableOrders, enableOrders) || other.enableOrders == enableOrders)&&(identical(other.enableFavorites, enableFavorites) || other.enableFavorites == enableFavorites)&&(identical(other.enableGeneral, enableGeneral) || other.enableGeneral == enableGeneral)&&(identical(other.enableSound, enableSound) || other.enableSound == enableSound)&&(identical(other.enableVibration, enableVibration) || other.enableVibration == enableVibration)&&(identical(other.enableBadge, enableBadge) || other.enableBadge == enableBadge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enablePromotions,enableOrders,enableFavorites,enableGeneral,enableSound,enableVibration,enableBadge);

@override
String toString() {
  return 'NotificationPreferencesModel(enablePromotions: $enablePromotions, enableOrders: $enableOrders, enableFavorites: $enableFavorites, enableGeneral: $enableGeneral, enableSound: $enableSound, enableVibration: $enableVibration, enableBadge: $enableBadge)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesModelCopyWith<$Res>  {
  factory $NotificationPreferencesModelCopyWith(NotificationPreferencesModel value, $Res Function(NotificationPreferencesModel) _then) = _$NotificationPreferencesModelCopyWithImpl;
@useResult
$Res call({
 bool enablePromotions, bool enableOrders, bool enableFavorites, bool enableGeneral, bool enableSound, bool enableVibration, bool enableBadge
});




}
/// @nodoc
class _$NotificationPreferencesModelCopyWithImpl<$Res>
    implements $NotificationPreferencesModelCopyWith<$Res> {
  _$NotificationPreferencesModelCopyWithImpl(this._self, this._then);

  final NotificationPreferencesModel _self;
  final $Res Function(NotificationPreferencesModel) _then;

/// Create a copy of NotificationPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enablePromotions = null,Object? enableOrders = null,Object? enableFavorites = null,Object? enableGeneral = null,Object? enableSound = null,Object? enableVibration = null,Object? enableBadge = null,}) {
  return _then(_self.copyWith(
enablePromotions: null == enablePromotions ? _self.enablePromotions : enablePromotions // ignore: cast_nullable_to_non_nullable
as bool,enableOrders: null == enableOrders ? _self.enableOrders : enableOrders // ignore: cast_nullable_to_non_nullable
as bool,enableFavorites: null == enableFavorites ? _self.enableFavorites : enableFavorites // ignore: cast_nullable_to_non_nullable
as bool,enableGeneral: null == enableGeneral ? _self.enableGeneral : enableGeneral // ignore: cast_nullable_to_non_nullable
as bool,enableSound: null == enableSound ? _self.enableSound : enableSound // ignore: cast_nullable_to_non_nullable
as bool,enableVibration: null == enableVibration ? _self.enableVibration : enableVibration // ignore: cast_nullable_to_non_nullable
as bool,enableBadge: null == enableBadge ? _self.enableBadge : enableBadge // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferencesModel].
extension NotificationPreferencesModelPatterns on NotificationPreferencesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferencesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferencesModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferencesModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enablePromotions,  bool enableOrders,  bool enableFavorites,  bool enableGeneral,  bool enableSound,  bool enableVibration,  bool enableBadge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferencesModel() when $default != null:
return $default(_that.enablePromotions,_that.enableOrders,_that.enableFavorites,_that.enableGeneral,_that.enableSound,_that.enableVibration,_that.enableBadge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enablePromotions,  bool enableOrders,  bool enableFavorites,  bool enableGeneral,  bool enableSound,  bool enableVibration,  bool enableBadge)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesModel():
return $default(_that.enablePromotions,_that.enableOrders,_that.enableFavorites,_that.enableGeneral,_that.enableSound,_that.enableVibration,_that.enableBadge);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enablePromotions,  bool enableOrders,  bool enableFavorites,  bool enableGeneral,  bool enableSound,  bool enableVibration,  bool enableBadge)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesModel() when $default != null:
return $default(_that.enablePromotions,_that.enableOrders,_that.enableFavorites,_that.enableGeneral,_that.enableSound,_that.enableVibration,_that.enableBadge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferencesModel extends NotificationPreferencesModel {
  const _NotificationPreferencesModel({this.enablePromotions = true, this.enableOrders = true, this.enableFavorites = true, this.enableGeneral = true, this.enableSound = false, this.enableVibration = true, this.enableBadge = true}): super._();
  factory _NotificationPreferencesModel.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesModelFromJson(json);

@override@JsonKey() final  bool enablePromotions;
@override@JsonKey() final  bool enableOrders;
@override@JsonKey() final  bool enableFavorites;
@override@JsonKey() final  bool enableGeneral;
@override@JsonKey() final  bool enableSound;
@override@JsonKey() final  bool enableVibration;
@override@JsonKey() final  bool enableBadge;

/// Create a copy of NotificationPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesModelCopyWith<_NotificationPreferencesModel> get copyWith => __$NotificationPreferencesModelCopyWithImpl<_NotificationPreferencesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferencesModel&&(identical(other.enablePromotions, enablePromotions) || other.enablePromotions == enablePromotions)&&(identical(other.enableOrders, enableOrders) || other.enableOrders == enableOrders)&&(identical(other.enableFavorites, enableFavorites) || other.enableFavorites == enableFavorites)&&(identical(other.enableGeneral, enableGeneral) || other.enableGeneral == enableGeneral)&&(identical(other.enableSound, enableSound) || other.enableSound == enableSound)&&(identical(other.enableVibration, enableVibration) || other.enableVibration == enableVibration)&&(identical(other.enableBadge, enableBadge) || other.enableBadge == enableBadge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enablePromotions,enableOrders,enableFavorites,enableGeneral,enableSound,enableVibration,enableBadge);

@override
String toString() {
  return 'NotificationPreferencesModel(enablePromotions: $enablePromotions, enableOrders: $enableOrders, enableFavorites: $enableFavorites, enableGeneral: $enableGeneral, enableSound: $enableSound, enableVibration: $enableVibration, enableBadge: $enableBadge)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesModelCopyWith<$Res> implements $NotificationPreferencesModelCopyWith<$Res> {
  factory _$NotificationPreferencesModelCopyWith(_NotificationPreferencesModel value, $Res Function(_NotificationPreferencesModel) _then) = __$NotificationPreferencesModelCopyWithImpl;
@override @useResult
$Res call({
 bool enablePromotions, bool enableOrders, bool enableFavorites, bool enableGeneral, bool enableSound, bool enableVibration, bool enableBadge
});




}
/// @nodoc
class __$NotificationPreferencesModelCopyWithImpl<$Res>
    implements _$NotificationPreferencesModelCopyWith<$Res> {
  __$NotificationPreferencesModelCopyWithImpl(this._self, this._then);

  final _NotificationPreferencesModel _self;
  final $Res Function(_NotificationPreferencesModel) _then;

/// Create a copy of NotificationPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enablePromotions = null,Object? enableOrders = null,Object? enableFavorites = null,Object? enableGeneral = null,Object? enableSound = null,Object? enableVibration = null,Object? enableBadge = null,}) {
  return _then(_NotificationPreferencesModel(
enablePromotions: null == enablePromotions ? _self.enablePromotions : enablePromotions // ignore: cast_nullable_to_non_nullable
as bool,enableOrders: null == enableOrders ? _self.enableOrders : enableOrders // ignore: cast_nullable_to_non_nullable
as bool,enableFavorites: null == enableFavorites ? _self.enableFavorites : enableFavorites // ignore: cast_nullable_to_non_nullable
as bool,enableGeneral: null == enableGeneral ? _self.enableGeneral : enableGeneral // ignore: cast_nullable_to_non_nullable
as bool,enableSound: null == enableSound ? _self.enableSound : enableSound // ignore: cast_nullable_to_non_nullable
as bool,enableVibration: null == enableVibration ? _self.enableVibration : enableVibration // ignore: cast_nullable_to_non_nullable
as bool,enableBadge: null == enableBadge ? _self.enableBadge : enableBadge // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationStatsModel {

 int get total; int get unread; int get promotions; int get orders; int get favorites;
/// Create a copy of NotificationStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatsModelCopyWith<NotificationStatsModel> get copyWith => _$NotificationStatsModelCopyWithImpl<NotificationStatsModel>(this as NotificationStatsModel, _$identity);

  /// Serializes this NotificationStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatsModel&&(identical(other.total, total) || other.total == total)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,unread,promotions,orders,favorites);

@override
String toString() {
  return 'NotificationStatsModel(total: $total, unread: $unread, promotions: $promotions, orders: $orders, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $NotificationStatsModelCopyWith<$Res>  {
  factory $NotificationStatsModelCopyWith(NotificationStatsModel value, $Res Function(NotificationStatsModel) _then) = _$NotificationStatsModelCopyWithImpl;
@useResult
$Res call({
 int total, int unread, int promotions, int orders, int favorites
});




}
/// @nodoc
class _$NotificationStatsModelCopyWithImpl<$Res>
    implements $NotificationStatsModelCopyWith<$Res> {
  _$NotificationStatsModelCopyWithImpl(this._self, this._then);

  final NotificationStatsModel _self;
  final $Res Function(NotificationStatsModel) _then;

/// Create a copy of NotificationStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? unread = null,Object? promotions = null,Object? orders = null,Object? favorites = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as int,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as int,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationStatsModel].
extension NotificationStatsModelPatterns on NotificationStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int unread,  int promotions,  int orders,  int favorites)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationStatsModel() when $default != null:
return $default(_that.total,_that.unread,_that.promotions,_that.orders,_that.favorites);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int unread,  int promotions,  int orders,  int favorites)  $default,) {final _that = this;
switch (_that) {
case _NotificationStatsModel():
return $default(_that.total,_that.unread,_that.promotions,_that.orders,_that.favorites);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int unread,  int promotions,  int orders,  int favorites)?  $default,) {final _that = this;
switch (_that) {
case _NotificationStatsModel() when $default != null:
return $default(_that.total,_that.unread,_that.promotions,_that.orders,_that.favorites);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationStatsModel extends NotificationStatsModel {
  const _NotificationStatsModel({this.total = 0, this.unread = 0, this.promotions = 0, this.orders = 0, this.favorites = 0}): super._();
  factory _NotificationStatsModel.fromJson(Map<String, dynamic> json) => _$NotificationStatsModelFromJson(json);

@override@JsonKey() final  int total;
@override@JsonKey() final  int unread;
@override@JsonKey() final  int promotions;
@override@JsonKey() final  int orders;
@override@JsonKey() final  int favorites;

/// Create a copy of NotificationStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationStatsModelCopyWith<_NotificationStatsModel> get copyWith => __$NotificationStatsModelCopyWithImpl<_NotificationStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationStatsModel&&(identical(other.total, total) || other.total == total)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,unread,promotions,orders,favorites);

@override
String toString() {
  return 'NotificationStatsModel(total: $total, unread: $unread, promotions: $promotions, orders: $orders, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$NotificationStatsModelCopyWith<$Res> implements $NotificationStatsModelCopyWith<$Res> {
  factory _$NotificationStatsModelCopyWith(_NotificationStatsModel value, $Res Function(_NotificationStatsModel) _then) = __$NotificationStatsModelCopyWithImpl;
@override @useResult
$Res call({
 int total, int unread, int promotions, int orders, int favorites
});




}
/// @nodoc
class __$NotificationStatsModelCopyWithImpl<$Res>
    implements _$NotificationStatsModelCopyWith<$Res> {
  __$NotificationStatsModelCopyWithImpl(this._self, this._then);

  final _NotificationStatsModel _self;
  final $Res Function(_NotificationStatsModel) _then;

/// Create a copy of NotificationStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? unread = null,Object? promotions = null,Object? orders = null,Object? favorites = null,}) {
  return _then(_NotificationStatsModel(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as int,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as int,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
