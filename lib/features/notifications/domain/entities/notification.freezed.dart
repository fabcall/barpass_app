// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Notification {

 String get id; String get title; String get body; NotificationType get type; DateTime get receivedAt; bool get isRead; Map<String, dynamic>? get data; String? get imageUrl; String? get actionUrl;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,receivedAt,isRead,const DeepCollectionEquality().hash(data),imageUrl,actionUrl);

@override
String toString() {
  return 'Notification(id: $id, title: $title, body: $body, type: $type, receivedAt: $receivedAt, isRead: $isRead, data: $data, imageUrl: $imageUrl, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, NotificationType type, DateTime receivedAt, bool isRead, Map<String, dynamic>? data, String? imageUrl, String? actionUrl
});




}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? receivedAt = null,Object? isRead = null,Object? data = freezed,Object? imageUrl = freezed,Object? actionUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notification value)  $default,){
final _that = this;
switch (_that) {
case _Notification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notification value)?  $default,){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  NotificationType type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  NotificationType type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)  $default,) {final _that = this;
switch (_that) {
case _Notification():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  NotificationType type,  DateTime receivedAt,  bool isRead,  Map<String, dynamic>? data,  String? imageUrl,  String? actionUrl)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.receivedAt,_that.isRead,_that.data,_that.imageUrl,_that.actionUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Notification extends Notification {
  const _Notification({required this.id, required this.title, required this.body, required this.type, required this.receivedAt, required this.isRead, final  Map<String, dynamic>? data, this.imageUrl, this.actionUrl}): _data = data,super._();
  

@override final  String id;
@override final  String title;
@override final  String body;
@override final  NotificationType type;
@override final  DateTime receivedAt;
@override final  bool isRead;
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

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCopyWith<_Notification> get copyWith => __$NotificationCopyWithImpl<_Notification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,receivedAt,isRead,const DeepCollectionEquality().hash(_data),imageUrl,actionUrl);

@override
String toString() {
  return 'Notification(id: $id, title: $title, body: $body, type: $type, receivedAt: $receivedAt, isRead: $isRead, data: $data, imageUrl: $imageUrl, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, NotificationType type, DateTime receivedAt, bool isRead, Map<String, dynamic>? data, String? imageUrl, String? actionUrl
});




}
/// @nodoc
class __$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(this._self, this._then);

  final _Notification _self;
  final $Res Function(_Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? receivedAt = null,Object? isRead = null,Object? data = freezed,Object? imageUrl = freezed,Object? actionUrl = freezed,}) {
  return _then(_Notification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$NotificationPreferences {

 bool get enablePromotions; bool get enableOrders; bool get enableFavorites; bool get enableGeneral; bool get enableSound; bool get enableVibration; bool get enableBadge;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&(identical(other.enablePromotions, enablePromotions) || other.enablePromotions == enablePromotions)&&(identical(other.enableOrders, enableOrders) || other.enableOrders == enableOrders)&&(identical(other.enableFavorites, enableFavorites) || other.enableFavorites == enableFavorites)&&(identical(other.enableGeneral, enableGeneral) || other.enableGeneral == enableGeneral)&&(identical(other.enableSound, enableSound) || other.enableSound == enableSound)&&(identical(other.enableVibration, enableVibration) || other.enableVibration == enableVibration)&&(identical(other.enableBadge, enableBadge) || other.enableBadge == enableBadge));
}


@override
int get hashCode => Object.hash(runtimeType,enablePromotions,enableOrders,enableFavorites,enableGeneral,enableSound,enableVibration,enableBadge);

@override
String toString() {
  return 'NotificationPreferences(enablePromotions: $enablePromotions, enableOrders: $enableOrders, enableFavorites: $enableFavorites, enableGeneral: $enableGeneral, enableSound: $enableSound, enableVibration: $enableVibration, enableBadge: $enableBadge)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 bool enablePromotions, bool enableOrders, bool enableFavorites, bool enableGeneral, bool enableSound, bool enableVibration, bool enableBadge
});




}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
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


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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
case _NotificationPreferences() when $default != null:
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
case _NotificationPreferences():
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
case _NotificationPreferences() when $default != null:
return $default(_that.enablePromotions,_that.enableOrders,_that.enableFavorites,_that.enableGeneral,_that.enableSound,_that.enableVibration,_that.enableBadge);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPreferences extends NotificationPreferences {
  const _NotificationPreferences({required this.enablePromotions, required this.enableOrders, required this.enableFavorites, required this.enableGeneral, required this.enableSound, required this.enableVibration, required this.enableBadge}): super._();
  

@override final  bool enablePromotions;
@override final  bool enableOrders;
@override final  bool enableFavorites;
@override final  bool enableGeneral;
@override final  bool enableSound;
@override final  bool enableVibration;
@override final  bool enableBadge;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&(identical(other.enablePromotions, enablePromotions) || other.enablePromotions == enablePromotions)&&(identical(other.enableOrders, enableOrders) || other.enableOrders == enableOrders)&&(identical(other.enableFavorites, enableFavorites) || other.enableFavorites == enableFavorites)&&(identical(other.enableGeneral, enableGeneral) || other.enableGeneral == enableGeneral)&&(identical(other.enableSound, enableSound) || other.enableSound == enableSound)&&(identical(other.enableVibration, enableVibration) || other.enableVibration == enableVibration)&&(identical(other.enableBadge, enableBadge) || other.enableBadge == enableBadge));
}


@override
int get hashCode => Object.hash(runtimeType,enablePromotions,enableOrders,enableFavorites,enableGeneral,enableSound,enableVibration,enableBadge);

@override
String toString() {
  return 'NotificationPreferences(enablePromotions: $enablePromotions, enableOrders: $enableOrders, enableFavorites: $enableFavorites, enableGeneral: $enableGeneral, enableSound: $enableSound, enableVibration: $enableVibration, enableBadge: $enableBadge)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool enablePromotions, bool enableOrders, bool enableFavorites, bool enableGeneral, bool enableSound, bool enableVibration, bool enableBadge
});




}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enablePromotions = null,Object? enableOrders = null,Object? enableFavorites = null,Object? enableGeneral = null,Object? enableSound = null,Object? enableVibration = null,Object? enableBadge = null,}) {
  return _then(_NotificationPreferences(
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
mixin _$NotificationStats {

 int get total; int get unread; int get promotions; int get orders; int get favorites;
/// Create a copy of NotificationStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatsCopyWith<NotificationStats> get copyWith => _$NotificationStatsCopyWithImpl<NotificationStats>(this as NotificationStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStats&&(identical(other.total, total) || other.total == total)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}


@override
int get hashCode => Object.hash(runtimeType,total,unread,promotions,orders,favorites);

@override
String toString() {
  return 'NotificationStats(total: $total, unread: $unread, promotions: $promotions, orders: $orders, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $NotificationStatsCopyWith<$Res>  {
  factory $NotificationStatsCopyWith(NotificationStats value, $Res Function(NotificationStats) _then) = _$NotificationStatsCopyWithImpl;
@useResult
$Res call({
 int total, int unread, int promotions, int orders, int favorites
});




}
/// @nodoc
class _$NotificationStatsCopyWithImpl<$Res>
    implements $NotificationStatsCopyWith<$Res> {
  _$NotificationStatsCopyWithImpl(this._self, this._then);

  final NotificationStats _self;
  final $Res Function(NotificationStats) _then;

/// Create a copy of NotificationStats
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


/// Adds pattern-matching-related methods to [NotificationStats].
extension NotificationStatsPatterns on NotificationStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationStats value)  $default,){
final _that = this;
switch (_that) {
case _NotificationStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationStats value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationStats() when $default != null:
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
case _NotificationStats() when $default != null:
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
case _NotificationStats():
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
case _NotificationStats() when $default != null:
return $default(_that.total,_that.unread,_that.promotions,_that.orders,_that.favorites);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationStats extends NotificationStats {
  const _NotificationStats({required this.total, required this.unread, required this.promotions, required this.orders, required this.favorites}): super._();
  

@override final  int total;
@override final  int unread;
@override final  int promotions;
@override final  int orders;
@override final  int favorites;

/// Create a copy of NotificationStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationStatsCopyWith<_NotificationStats> get copyWith => __$NotificationStatsCopyWithImpl<_NotificationStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationStats&&(identical(other.total, total) || other.total == total)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}


@override
int get hashCode => Object.hash(runtimeType,total,unread,promotions,orders,favorites);

@override
String toString() {
  return 'NotificationStats(total: $total, unread: $unread, promotions: $promotions, orders: $orders, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$NotificationStatsCopyWith<$Res> implements $NotificationStatsCopyWith<$Res> {
  factory _$NotificationStatsCopyWith(_NotificationStats value, $Res Function(_NotificationStats) _then) = __$NotificationStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, int unread, int promotions, int orders, int favorites
});




}
/// @nodoc
class __$NotificationStatsCopyWithImpl<$Res>
    implements _$NotificationStatsCopyWith<$Res> {
  __$NotificationStatsCopyWithImpl(this._self, this._then);

  final _NotificationStats _self;
  final $Res Function(_NotificationStats) _then;

/// Create a copy of NotificationStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? unread = null,Object? promotions = null,Object? orders = null,Object? favorites = null,}) {
  return _then(_NotificationStats(
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
