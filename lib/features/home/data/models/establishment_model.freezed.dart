// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstablishmentModel {

 String get id; String get name; String get address; double get rating;@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'logo_url') String get logoUrl; String get distance; String get discount;@JsonKey(name: 'review_count') int get reviewCount; List<String> get categories;// Campos extras da API que não vão para entity
@JsonKey(name: 'api_id') String? get apiId;@JsonKey(name: 'last_updated') DateTime? get lastUpdated;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of EstablishmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentModelCopyWith<EstablishmentModel> get copyWith => _$EstablishmentModelCopyWithImpl<EstablishmentModel>(this as EstablishmentModel, _$identity);

  /// Serializes this EstablishmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstablishmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.apiId, apiId) || other.apiId == apiId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(categories),apiId,lastUpdated,isActive);

@override
String toString() {
  return 'EstablishmentModel(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, apiId: $apiId, lastUpdated: $lastUpdated, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $EstablishmentModelCopyWith<$Res>  {
  factory $EstablishmentModelCopyWith(EstablishmentModel value, $Res Function(EstablishmentModel) _then) = _$EstablishmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double rating,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'logo_url') String logoUrl, String distance, String discount,@JsonKey(name: 'review_count') int reviewCount, List<String> categories,@JsonKey(name: 'api_id') String? apiId,@JsonKey(name: 'last_updated') DateTime? lastUpdated,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$EstablishmentModelCopyWithImpl<$Res>
    implements $EstablishmentModelCopyWith<$Res> {
  _$EstablishmentModelCopyWithImpl(this._self, this._then);

  final EstablishmentModel _self;
  final $Res Function(EstablishmentModel) _then;

/// Create a copy of EstablishmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,Object? apiId = freezed,Object? lastUpdated = freezed,Object? isActive = null,}) {
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
as List<String>,apiId: freezed == apiId ? _self.apiId : apiId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EstablishmentModel].
extension EstablishmentModelPatterns on EstablishmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstablishmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstablishmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstablishmentModel value)  $default,){
final _that = this;
switch (_that) {
case _EstablishmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstablishmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _EstablishmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories, @JsonKey(name: 'api_id')  String? apiId, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstablishmentModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.apiId,_that.lastUpdated,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories, @JsonKey(name: 'api_id')  String? apiId, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _EstablishmentModel():
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.apiId,_that.lastUpdated,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories, @JsonKey(name: 'api_id')  String? apiId, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _EstablishmentModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.apiId,_that.lastUpdated,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstablishmentModel extends EstablishmentModel {
  const _EstablishmentModel({required this.id, required this.name, required this.address, required this.rating, @JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'logo_url') required this.logoUrl, required this.distance, required this.discount, @JsonKey(name: 'review_count') this.reviewCount = 0, final  List<String> categories = const [], @JsonKey(name: 'api_id') this.apiId, @JsonKey(name: 'last_updated') this.lastUpdated, @JsonKey(name: 'is_active') this.isActive = true}): _categories = categories,super._();
  factory _EstablishmentModel.fromJson(Map<String, dynamic> json) => _$EstablishmentModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  double rating;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey(name: 'logo_url') final  String logoUrl;
@override final  String distance;
@override final  String discount;
@override@JsonKey(name: 'review_count') final  int reviewCount;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

// Campos extras da API que não vão para entity
@override@JsonKey(name: 'api_id') final  String? apiId;
@override@JsonKey(name: 'last_updated') final  DateTime? lastUpdated;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of EstablishmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentModelCopyWith<_EstablishmentModel> get copyWith => __$EstablishmentModelCopyWithImpl<_EstablishmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstablishmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstablishmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.apiId, apiId) || other.apiId == apiId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(_categories),apiId,lastUpdated,isActive);

@override
String toString() {
  return 'EstablishmentModel(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, apiId: $apiId, lastUpdated: $lastUpdated, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentModelCopyWith<$Res> implements $EstablishmentModelCopyWith<$Res> {
  factory _$EstablishmentModelCopyWith(_EstablishmentModel value, $Res Function(_EstablishmentModel) _then) = __$EstablishmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double rating,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'logo_url') String logoUrl, String distance, String discount,@JsonKey(name: 'review_count') int reviewCount, List<String> categories,@JsonKey(name: 'api_id') String? apiId,@JsonKey(name: 'last_updated') DateTime? lastUpdated,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$EstablishmentModelCopyWithImpl<$Res>
    implements _$EstablishmentModelCopyWith<$Res> {
  __$EstablishmentModelCopyWithImpl(this._self, this._then);

  final _EstablishmentModel _self;
  final $Res Function(_EstablishmentModel) _then;

/// Create a copy of EstablishmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,Object? apiId = freezed,Object? lastUpdated = freezed,Object? isActive = null,}) {
  return _then(_EstablishmentModel(
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
as List<String>,apiId: freezed == apiId ? _self.apiId : apiId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
