// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstablishmentDetailModel {

 String get id; String get name; String get address; double get rating;@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'logo_url') String get logoUrl; String get distance; String get discount;@JsonKey(name: 'review_count') int get reviewCount; List<String> get categories;// Campos adicionais
 String? get description; String? get phone; String? get email; String? get website;@JsonKey(name: 'opening_hours') String? get openingHours;@JsonKey(name: 'is_open') bool? get isOpen;@JsonKey(name: 'payment_methods') List<String> get paymentMethods; List<String> get facilities; List<String> get photos;@JsonKey(name: 'menu_categories') List<MenuCategoryModel> get menuCategories; List<ReviewModel> get reviews;
/// Create a copy of EstablishmentDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentDetailModelCopyWith<EstablishmentDetailModel> get copyWith => _$EstablishmentDetailModelCopyWithImpl<EstablishmentDetailModel>(this as EstablishmentDetailModel, _$identity);

  /// Serializes this EstablishmentDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstablishmentDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.paymentMethods, paymentMethods)&&const DeepCollectionEquality().equals(other.facilities, facilities)&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.menuCategories, menuCategories)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(categories),description,phone,email,website,openingHours,isOpen,const DeepCollectionEquality().hash(paymentMethods),const DeepCollectionEquality().hash(facilities),const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(menuCategories),const DeepCollectionEquality().hash(reviews)]);

@override
String toString() {
  return 'EstablishmentDetailModel(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, description: $description, phone: $phone, email: $email, website: $website, openingHours: $openingHours, isOpen: $isOpen, paymentMethods: $paymentMethods, facilities: $facilities, photos: $photos, menuCategories: $menuCategories, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $EstablishmentDetailModelCopyWith<$Res>  {
  factory $EstablishmentDetailModelCopyWith(EstablishmentDetailModel value, $Res Function(EstablishmentDetailModel) _then) = _$EstablishmentDetailModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double rating,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'logo_url') String logoUrl, String distance, String discount,@JsonKey(name: 'review_count') int reviewCount, List<String> categories, String? description, String? phone, String? email, String? website,@JsonKey(name: 'opening_hours') String? openingHours,@JsonKey(name: 'is_open') bool? isOpen,@JsonKey(name: 'payment_methods') List<String> paymentMethods, List<String> facilities, List<String> photos,@JsonKey(name: 'menu_categories') List<MenuCategoryModel> menuCategories, List<ReviewModel> reviews
});




}
/// @nodoc
class _$EstablishmentDetailModelCopyWithImpl<$Res>
    implements $EstablishmentDetailModelCopyWith<$Res> {
  _$EstablishmentDetailModelCopyWithImpl(this._self, this._then);

  final EstablishmentDetailModel _self;
  final $Res Function(EstablishmentDetailModel) _then;

/// Create a copy of EstablishmentDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,Object? description = freezed,Object? phone = freezed,Object? email = freezed,Object? website = freezed,Object? openingHours = freezed,Object? isOpen = freezed,Object? paymentMethods = null,Object? facilities = null,Object? photos = null,Object? menuCategories = null,Object? reviews = null,}) {
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
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,paymentMethods: null == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<String>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,menuCategories: null == menuCategories ? _self.menuCategories : menuCategories // ignore: cast_nullable_to_non_nullable
as List<MenuCategoryModel>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [EstablishmentDetailModel].
extension EstablishmentDetailModelPatterns on EstablishmentDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstablishmentDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstablishmentDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstablishmentDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstablishmentDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website, @JsonKey(name: 'opening_hours')  String? openingHours, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'payment_methods')  List<String> paymentMethods,  List<String> facilities,  List<String> photos, @JsonKey(name: 'menu_categories')  List<MenuCategoryModel> menuCategories,  List<ReviewModel> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstablishmentDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.description,_that.phone,_that.email,_that.website,_that.openingHours,_that.isOpen,_that.paymentMethods,_that.facilities,_that.photos,_that.menuCategories,_that.reviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website, @JsonKey(name: 'opening_hours')  String? openingHours, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'payment_methods')  List<String> paymentMethods,  List<String> facilities,  List<String> photos, @JsonKey(name: 'menu_categories')  List<MenuCategoryModel> menuCategories,  List<ReviewModel> reviews)  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetailModel():
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.description,_that.phone,_that.email,_that.website,_that.openingHours,_that.isOpen,_that.paymentMethods,_that.facilities,_that.photos,_that.menuCategories,_that.reviews);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double rating, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'logo_url')  String logoUrl,  String distance,  String discount, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website, @JsonKey(name: 'opening_hours')  String? openingHours, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'payment_methods')  List<String> paymentMethods,  List<String> facilities,  List<String> photos, @JsonKey(name: 'menu_categories')  List<MenuCategoryModel> menuCategories,  List<ReviewModel> reviews)?  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.description,_that.phone,_that.email,_that.website,_that.openingHours,_that.isOpen,_that.paymentMethods,_that.facilities,_that.photos,_that.menuCategories,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstablishmentDetailModel extends EstablishmentDetailModel {
  const _EstablishmentDetailModel({required this.id, required this.name, required this.address, required this.rating, @JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'logo_url') required this.logoUrl, required this.distance, required this.discount, @JsonKey(name: 'review_count') this.reviewCount = 0, final  List<String> categories = const [], this.description, this.phone, this.email, this.website, @JsonKey(name: 'opening_hours') this.openingHours, @JsonKey(name: 'is_open') this.isOpen, @JsonKey(name: 'payment_methods') final  List<String> paymentMethods = const [], final  List<String> facilities = const [], final  List<String> photos = const [], @JsonKey(name: 'menu_categories') final  List<MenuCategoryModel> menuCategories = const [], final  List<ReviewModel> reviews = const []}): _categories = categories,_paymentMethods = paymentMethods,_facilities = facilities,_photos = photos,_menuCategories = menuCategories,_reviews = reviews,super._();
  factory _EstablishmentDetailModel.fromJson(Map<String, dynamic> json) => _$EstablishmentDetailModelFromJson(json);

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

// Campos adicionais
@override final  String? description;
@override final  String? phone;
@override final  String? email;
@override final  String? website;
@override@JsonKey(name: 'opening_hours') final  String? openingHours;
@override@JsonKey(name: 'is_open') final  bool? isOpen;
 final  List<String> _paymentMethods;
@override@JsonKey(name: 'payment_methods') List<String> get paymentMethods {
  if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentMethods);
}

 final  List<String> _facilities;
@override@JsonKey() List<String> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}

 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

 final  List<MenuCategoryModel> _menuCategories;
@override@JsonKey(name: 'menu_categories') List<MenuCategoryModel> get menuCategories {
  if (_menuCategories is EqualUnmodifiableListView) return _menuCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuCategories);
}

 final  List<ReviewModel> _reviews;
@override@JsonKey() List<ReviewModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of EstablishmentDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentDetailModelCopyWith<_EstablishmentDetailModel> get copyWith => __$EstablishmentDetailModelCopyWithImpl<_EstablishmentDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstablishmentDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstablishmentDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._paymentMethods, _paymentMethods)&&const DeepCollectionEquality().equals(other._facilities, _facilities)&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._menuCategories, _menuCategories)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(_categories),description,phone,email,website,openingHours,isOpen,const DeepCollectionEquality().hash(_paymentMethods),const DeepCollectionEquality().hash(_facilities),const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_menuCategories),const DeepCollectionEquality().hash(_reviews)]);

@override
String toString() {
  return 'EstablishmentDetailModel(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, description: $description, phone: $phone, email: $email, website: $website, openingHours: $openingHours, isOpen: $isOpen, paymentMethods: $paymentMethods, facilities: $facilities, photos: $photos, menuCategories: $menuCategories, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentDetailModelCopyWith<$Res> implements $EstablishmentDetailModelCopyWith<$Res> {
  factory _$EstablishmentDetailModelCopyWith(_EstablishmentDetailModel value, $Res Function(_EstablishmentDetailModel) _then) = __$EstablishmentDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double rating,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'logo_url') String logoUrl, String distance, String discount,@JsonKey(name: 'review_count') int reviewCount, List<String> categories, String? description, String? phone, String? email, String? website,@JsonKey(name: 'opening_hours') String? openingHours,@JsonKey(name: 'is_open') bool? isOpen,@JsonKey(name: 'payment_methods') List<String> paymentMethods, List<String> facilities, List<String> photos,@JsonKey(name: 'menu_categories') List<MenuCategoryModel> menuCategories, List<ReviewModel> reviews
});




}
/// @nodoc
class __$EstablishmentDetailModelCopyWithImpl<$Res>
    implements _$EstablishmentDetailModelCopyWith<$Res> {
  __$EstablishmentDetailModelCopyWithImpl(this._self, this._then);

  final _EstablishmentDetailModel _self;
  final $Res Function(_EstablishmentDetailModel) _then;

/// Create a copy of EstablishmentDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,Object? description = freezed,Object? phone = freezed,Object? email = freezed,Object? website = freezed,Object? openingHours = freezed,Object? isOpen = freezed,Object? paymentMethods = null,Object? facilities = null,Object? photos = null,Object? menuCategories = null,Object? reviews = null,}) {
  return _then(_EstablishmentDetailModel(
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
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,paymentMethods: null == paymentMethods ? _self._paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<String>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,menuCategories: null == menuCategories ? _self._menuCategories : menuCategories // ignore: cast_nullable_to_non_nullable
as List<MenuCategoryModel>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,
  ));
}


}


/// @nodoc
mixin _$MenuCategoryModel {

 String get id; String get name; String? get description; List<MenuItemModel> get items;
/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuCategoryModelCopyWith<MenuCategoryModel> get copyWith => _$MenuCategoryModelCopyWithImpl<MenuCategoryModel>(this as MenuCategoryModel, _$identity);

  /// Serializes this MenuCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MenuCategoryModel(id: $id, name: $name, description: $description, items: $items)';
}


}

/// @nodoc
abstract mixin class $MenuCategoryModelCopyWith<$Res>  {
  factory $MenuCategoryModelCopyWith(MenuCategoryModel value, $Res Function(MenuCategoryModel) _then) = _$MenuCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, List<MenuItemModel> items
});




}
/// @nodoc
class _$MenuCategoryModelCopyWithImpl<$Res>
    implements $MenuCategoryModelCopyWith<$Res> {
  _$MenuCategoryModelCopyWithImpl(this._self, this._then);

  final MenuCategoryModel _self;
  final $Res Function(MenuCategoryModel) _then;

/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuCategoryModel].
extension MenuCategoryModelPatterns on MenuCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  List<MenuItemModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  List<MenuItemModel> items)  $default,) {final _that = this;
switch (_that) {
case _MenuCategoryModel():
return $default(_that.id,_that.name,_that.description,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  List<MenuItemModel> items)?  $default,) {final _that = this;
switch (_that) {
case _MenuCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuCategoryModel extends MenuCategoryModel {
  const _MenuCategoryModel({required this.id, required this.name, this.description, final  List<MenuItemModel> items = const []}): _items = items,super._();
  factory _MenuCategoryModel.fromJson(Map<String, dynamic> json) => _$MenuCategoryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
 final  List<MenuItemModel> _items;
@override@JsonKey() List<MenuItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuCategoryModelCopyWith<_MenuCategoryModel> get copyWith => __$MenuCategoryModelCopyWithImpl<_MenuCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MenuCategoryModel(id: $id, name: $name, description: $description, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MenuCategoryModelCopyWith<$Res> implements $MenuCategoryModelCopyWith<$Res> {
  factory _$MenuCategoryModelCopyWith(_MenuCategoryModel value, $Res Function(_MenuCategoryModel) _then) = __$MenuCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, List<MenuItemModel> items
});




}
/// @nodoc
class __$MenuCategoryModelCopyWithImpl<$Res>
    implements _$MenuCategoryModelCopyWith<$Res> {
  __$MenuCategoryModelCopyWithImpl(this._self, this._then);

  final _MenuCategoryModel _self;
  final $Res Function(_MenuCategoryModel) _then;

/// Create a copy of MenuCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? items = null,}) {
  return _then(_MenuCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>,
  ));
}


}


/// @nodoc
mixin _$MenuItemModel {

 String get id; String get name; String get description; String get price;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'is_available') bool get isAvailable;
/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemModelCopyWith<MenuItemModel> get copyWith => _$MenuItemModelCopyWithImpl<MenuItemModel>(this as MenuItemModel, _$identity);

  /// Serializes this MenuItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'MenuItemModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $MenuItemModelCopyWith<$Res>  {
  factory $MenuItemModelCopyWith(MenuItemModel value, $Res Function(MenuItemModel) _then) = _$MenuItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_available') bool isAvailable
});




}
/// @nodoc
class _$MenuItemModelCopyWithImpl<$Res>
    implements $MenuItemModelCopyWith<$Res> {
  _$MenuItemModelCopyWithImpl(this._self, this._then);

  final MenuItemModel _self;
  final $Res Function(MenuItemModel) _then;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuItemModel].
extension MenuItemModelPatterns on MenuItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuItemModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_available')  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_available')  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _MenuItemModel():
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_available')  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuItemModel extends MenuItemModel {
  const _MenuItemModel({required this.id, required this.name, required this.description, required this.price, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'is_available') this.isAvailable = true}): super._();
  factory _MenuItemModel.fromJson(Map<String, dynamic> json) => _$MenuItemModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String price;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'is_available') final  bool isAvailable;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemModelCopyWith<_MenuItemModel> get copyWith => __$MenuItemModelCopyWithImpl<_MenuItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'MenuItemModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$MenuItemModelCopyWith<$Res> implements $MenuItemModelCopyWith<$Res> {
  factory _$MenuItemModelCopyWith(_MenuItemModel value, $Res Function(_MenuItemModel) _then) = __$MenuItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_available') bool isAvailable
});




}
/// @nodoc
class __$MenuItemModelCopyWithImpl<$Res>
    implements _$MenuItemModelCopyWith<$Res> {
  __$MenuItemModelCopyWithImpl(this._self, this._then);

  final _MenuItemModel _self;
  final $Res Function(_MenuItemModel) _then;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_MenuItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReviewModel {

 String get id;@JsonKey(name: 'user_name') String get userName; int get rating; String get comment;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'user_avatar_url') String? get userAvatarUrl;
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewModelCopyWith<ReviewModel> get copyWith => _$ReviewModelCopyWithImpl<ReviewModel>(this as ReviewModel, _$identity);

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userName,rating,comment,createdAt,userAvatarUrl);

@override
String toString() {
  return 'ReviewModel(id: $id, userName: $userName, rating: $rating, comment: $comment, createdAt: $createdAt, userAvatarUrl: $userAvatarUrl)';
}


}

/// @nodoc
abstract mixin class $ReviewModelCopyWith<$Res>  {
  factory $ReviewModelCopyWith(ReviewModel value, $Res Function(ReviewModel) _then) = _$ReviewModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_name') String userName, int rating, String comment,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'user_avatar_url') String? userAvatarUrl
});




}
/// @nodoc
class _$ReviewModelCopyWithImpl<$Res>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._self, this._then);

  final ReviewModel _self;
  final $Res Function(ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? userAvatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewModel].
extension ReviewModelPatterns on ReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_name')  String userName,  int rating,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'user_avatar_url')  String? userAvatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.userName,_that.rating,_that.comment,_that.createdAt,_that.userAvatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_name')  String userName,  int rating,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'user_avatar_url')  String? userAvatarUrl)  $default,) {final _that = this;
switch (_that) {
case _ReviewModel():
return $default(_that.id,_that.userName,_that.rating,_that.comment,_that.createdAt,_that.userAvatarUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_name')  String userName,  int rating,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'user_avatar_url')  String? userAvatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.userName,_that.rating,_that.comment,_that.createdAt,_that.userAvatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewModel extends ReviewModel {
  const _ReviewModel({required this.id, @JsonKey(name: 'user_name') required this.userName, required this.rating, required this.comment, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'user_avatar_url') this.userAvatarUrl}): super._();
  factory _ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_name') final  String userName;
@override final  int rating;
@override final  String comment;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'user_avatar_url') final  String? userAvatarUrl;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewModelCopyWith<_ReviewModel> get copyWith => __$ReviewModelCopyWithImpl<_ReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userName,rating,comment,createdAt,userAvatarUrl);

@override
String toString() {
  return 'ReviewModel(id: $id, userName: $userName, rating: $rating, comment: $comment, createdAt: $createdAt, userAvatarUrl: $userAvatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ReviewModelCopyWith<$Res> implements $ReviewModelCopyWith<$Res> {
  factory _$ReviewModelCopyWith(_ReviewModel value, $Res Function(_ReviewModel) _then) = __$ReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_name') String userName, int rating, String comment,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'user_avatar_url') String? userAvatarUrl
});




}
/// @nodoc
class __$ReviewModelCopyWithImpl<$Res>
    implements _$ReviewModelCopyWith<$Res> {
  __$ReviewModelCopyWithImpl(this._self, this._then);

  final _ReviewModel _self;
  final $Res Function(_ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? userAvatarUrl = freezed,}) {
  return _then(_ReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
