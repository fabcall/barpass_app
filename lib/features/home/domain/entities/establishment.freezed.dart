// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Establishment {

 String get id; String get name; String get address; double get rating; String get imageUrl; String get logoUrl; String get distance; String get discount; int get reviewCount; List<String> get categories;
/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentCopyWith<Establishment> get copyWith => _$EstablishmentCopyWithImpl<Establishment>(this as Establishment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Establishment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categories, categories));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'Establishment(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $EstablishmentCopyWith<$Res>  {
  factory $EstablishmentCopyWith(Establishment value, $Res Function(Establishment) _then) = _$EstablishmentCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double rating, String imageUrl, String logoUrl, String distance, String discount, int reviewCount, List<String> categories
});




}
/// @nodoc
class _$EstablishmentCopyWithImpl<$Res>
    implements $EstablishmentCopyWith<$Res> {
  _$EstablishmentCopyWithImpl(this._self, this._then);

  final Establishment _self;
  final $Res Function(Establishment) _then;

/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,logoUrl: null == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as String,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Establishment].
extension EstablishmentPatterns on Establishment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Establishment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Establishment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Establishment value)  $default,){
final _that = this;
switch (_that) {
case _Establishment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Establishment value)?  $default,){
final _that = this;
switch (_that) {
case _Establishment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Establishment() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories)  $default,) {final _that = this;
switch (_that) {
case _Establishment():
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories)?  $default,) {final _that = this;
switch (_that) {
case _Establishment() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories);case _:
  return null;

}
}

}

/// @nodoc


class _Establishment extends Establishment {
  const _Establishment({required this.id, required this.name, required this.address, required this.rating, required this.imageUrl, required this.logoUrl, required this.distance, required this.discount, this.reviewCount = 0, final  List<String> categories = const []}): _categories = categories,super._();
  

@override final  String id;
@override final  String name;
@override final  String address;
@override final  double rating;
@override final  String imageUrl;
@override final  String logoUrl;
@override final  String distance;
@override final  String discount;
@override@JsonKey() final  int reviewCount;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentCopyWith<_Establishment> get copyWith => __$EstablishmentCopyWithImpl<_Establishment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Establishment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'Establishment(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentCopyWith<$Res> implements $EstablishmentCopyWith<$Res> {
  factory _$EstablishmentCopyWith(_Establishment value, $Res Function(_Establishment) _then) = __$EstablishmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double rating, String imageUrl, String logoUrl, String distance, String discount, int reviewCount, List<String> categories
});




}
/// @nodoc
class __$EstablishmentCopyWithImpl<$Res>
    implements _$EstablishmentCopyWith<$Res> {
  __$EstablishmentCopyWithImpl(this._self, this._then);

  final _Establishment _self;
  final $Res Function(_Establishment) _then;

/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,}) {
  return _then(_Establishment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,logoUrl: null == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as String,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
