// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EstablishmentDetail {

 String get id; String get name; String get address; double get rating; String get imageUrl; String get logoUrl; String get distance; String get discount; int get reviewCount; List<String> get categories;// Informações adicionais para detalhes
 String? get description; String? get phone; String? get email; String? get website;// Horário de funcionamento
 String? get openingHours; bool? get isOpen;// Formas de pagamento
 List<String> get paymentMethods;// Facilidades
 List<String> get facilities;// Fotos
 List<String> get photos;// Menu
 List<MenuCategory> get menuCategories;// Avaliações
 List<Review> get reviews;
/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentDetailCopyWith<EstablishmentDetail> get copyWith => _$EstablishmentDetailCopyWithImpl<EstablishmentDetail>(this as EstablishmentDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstablishmentDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.paymentMethods, paymentMethods)&&const DeepCollectionEquality().equals(other.facilities, facilities)&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.menuCategories, menuCategories)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(categories),description,phone,email,website,openingHours,isOpen,const DeepCollectionEquality().hash(paymentMethods),const DeepCollectionEquality().hash(facilities),const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(menuCategories),const DeepCollectionEquality().hash(reviews)]);

@override
String toString() {
  return 'EstablishmentDetail(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, description: $description, phone: $phone, email: $email, website: $website, openingHours: $openingHours, isOpen: $isOpen, paymentMethods: $paymentMethods, facilities: $facilities, photos: $photos, menuCategories: $menuCategories, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $EstablishmentDetailCopyWith<$Res>  {
  factory $EstablishmentDetailCopyWith(EstablishmentDetail value, $Res Function(EstablishmentDetail) _then) = _$EstablishmentDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double rating, String imageUrl, String logoUrl, String distance, String discount, int reviewCount, List<String> categories, String? description, String? phone, String? email, String? website, String? openingHours, bool? isOpen, List<String> paymentMethods, List<String> facilities, List<String> photos, List<MenuCategory> menuCategories, List<Review> reviews
});




}
/// @nodoc
class _$EstablishmentDetailCopyWithImpl<$Res>
    implements $EstablishmentDetailCopyWith<$Res> {
  _$EstablishmentDetailCopyWithImpl(this._self, this._then);

  final EstablishmentDetail _self;
  final $Res Function(EstablishmentDetail) _then;

/// Create a copy of EstablishmentDetail
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
as List<MenuCategory>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}

}


/// Adds pattern-matching-related methods to [EstablishmentDetail].
extension EstablishmentDetailPatterns on EstablishmentDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstablishmentDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstablishmentDetail value)  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstablishmentDetail value)?  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website,  String? openingHours,  bool? isOpen,  List<String> paymentMethods,  List<String> facilities,  List<String> photos,  List<MenuCategory> menuCategories,  List<Review> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website,  String? openingHours,  bool? isOpen,  List<String> paymentMethods,  List<String> facilities,  List<String> photos,  List<MenuCategory> menuCategories,  List<Review> reviews)  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetail():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double rating,  String imageUrl,  String logoUrl,  String distance,  String discount,  int reviewCount,  List<String> categories,  String? description,  String? phone,  String? email,  String? website,  String? openingHours,  bool? isOpen,  List<String> paymentMethods,  List<String> facilities,  List<String> photos,  List<MenuCategory> menuCategories,  List<Review> reviews)?  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.rating,_that.imageUrl,_that.logoUrl,_that.distance,_that.discount,_that.reviewCount,_that.categories,_that.description,_that.phone,_that.email,_that.website,_that.openingHours,_that.isOpen,_that.paymentMethods,_that.facilities,_that.photos,_that.menuCategories,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc


class _EstablishmentDetail extends EstablishmentDetail {
  const _EstablishmentDetail({required this.id, required this.name, required this.address, required this.rating, required this.imageUrl, required this.logoUrl, required this.distance, required this.discount, this.reviewCount = 0, final  List<String> categories = const [], this.description, this.phone, this.email, this.website, this.openingHours, this.isOpen, final  List<String> paymentMethods = const [], final  List<String> facilities = const [], final  List<String> photos = const [], final  List<MenuCategory> menuCategories = const [], final  List<Review> reviews = const []}): _categories = categories,_paymentMethods = paymentMethods,_facilities = facilities,_photos = photos,_menuCategories = menuCategories,_reviews = reviews,super._();
  

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

// Informações adicionais para detalhes
@override final  String? description;
@override final  String? phone;
@override final  String? email;
@override final  String? website;
// Horário de funcionamento
@override final  String? openingHours;
@override final  bool? isOpen;
// Formas de pagamento
 final  List<String> _paymentMethods;
// Formas de pagamento
@override@JsonKey() List<String> get paymentMethods {
  if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentMethods);
}

// Facilidades
 final  List<String> _facilities;
// Facilidades
@override@JsonKey() List<String> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}

// Fotos
 final  List<String> _photos;
// Fotos
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

// Menu
 final  List<MenuCategory> _menuCategories;
// Menu
@override@JsonKey() List<MenuCategory> get menuCategories {
  if (_menuCategories is EqualUnmodifiableListView) return _menuCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuCategories);
}

// Avaliações
 final  List<Review> _reviews;
// Avaliações
@override@JsonKey() List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentDetailCopyWith<_EstablishmentDetail> get copyWith => __$EstablishmentDetailCopyWithImpl<_EstablishmentDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstablishmentDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._paymentMethods, _paymentMethods)&&const DeepCollectionEquality().equals(other._facilities, _facilities)&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._menuCategories, _menuCategories)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,address,rating,imageUrl,logoUrl,distance,discount,reviewCount,const DeepCollectionEquality().hash(_categories),description,phone,email,website,openingHours,isOpen,const DeepCollectionEquality().hash(_paymentMethods),const DeepCollectionEquality().hash(_facilities),const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_menuCategories),const DeepCollectionEquality().hash(_reviews)]);

@override
String toString() {
  return 'EstablishmentDetail(id: $id, name: $name, address: $address, rating: $rating, imageUrl: $imageUrl, logoUrl: $logoUrl, distance: $distance, discount: $discount, reviewCount: $reviewCount, categories: $categories, description: $description, phone: $phone, email: $email, website: $website, openingHours: $openingHours, isOpen: $isOpen, paymentMethods: $paymentMethods, facilities: $facilities, photos: $photos, menuCategories: $menuCategories, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentDetailCopyWith<$Res> implements $EstablishmentDetailCopyWith<$Res> {
  factory _$EstablishmentDetailCopyWith(_EstablishmentDetail value, $Res Function(_EstablishmentDetail) _then) = __$EstablishmentDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double rating, String imageUrl, String logoUrl, String distance, String discount, int reviewCount, List<String> categories, String? description, String? phone, String? email, String? website, String? openingHours, bool? isOpen, List<String> paymentMethods, List<String> facilities, List<String> photos, List<MenuCategory> menuCategories, List<Review> reviews
});




}
/// @nodoc
class __$EstablishmentDetailCopyWithImpl<$Res>
    implements _$EstablishmentDetailCopyWith<$Res> {
  __$EstablishmentDetailCopyWithImpl(this._self, this._then);

  final _EstablishmentDetail _self;
  final $Res Function(_EstablishmentDetail) _then;

/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? rating = null,Object? imageUrl = null,Object? logoUrl = null,Object? distance = null,Object? discount = null,Object? reviewCount = null,Object? categories = null,Object? description = freezed,Object? phone = freezed,Object? email = freezed,Object? website = freezed,Object? openingHours = freezed,Object? isOpen = freezed,Object? paymentMethods = null,Object? facilities = null,Object? photos = null,Object? menuCategories = null,Object? reviews = null,}) {
  return _then(_EstablishmentDetail(
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
as List<MenuCategory>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}


}

/// @nodoc
mixin _$MenuCategory {

 String get id; String get name; String? get description; List<MenuItem> get items;
/// Create a copy of MenuCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuCategoryCopyWith<MenuCategory> get copyWith => _$MenuCategoryCopyWithImpl<MenuCategory>(this as MenuCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MenuCategory(id: $id, name: $name, description: $description, items: $items)';
}


}

/// @nodoc
abstract mixin class $MenuCategoryCopyWith<$Res>  {
  factory $MenuCategoryCopyWith(MenuCategory value, $Res Function(MenuCategory) _then) = _$MenuCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, List<MenuItem> items
});




}
/// @nodoc
class _$MenuCategoryCopyWithImpl<$Res>
    implements $MenuCategoryCopyWith<$Res> {
  _$MenuCategoryCopyWithImpl(this._self, this._then);

  final MenuCategory _self;
  final $Res Function(MenuCategory) _then;

/// Create a copy of MenuCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuCategory].
extension MenuCategoryPatterns on MenuCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuCategory value)  $default,){
final _that = this;
switch (_that) {
case _MenuCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuCategory value)?  $default,){
final _that = this;
switch (_that) {
case _MenuCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  List<MenuItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuCategory() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  List<MenuItem> items)  $default,) {final _that = this;
switch (_that) {
case _MenuCategory():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  List<MenuItem> items)?  $default,) {final _that = this;
switch (_that) {
case _MenuCategory() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _MenuCategory extends MenuCategory {
  const _MenuCategory({required this.id, required this.name, this.description, final  List<MenuItem> items = const []}): _items = items,super._();
  

@override final  String id;
@override final  String name;
@override final  String? description;
 final  List<MenuItem> _items;
@override@JsonKey() List<MenuItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MenuCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuCategoryCopyWith<_MenuCategory> get copyWith => __$MenuCategoryCopyWithImpl<_MenuCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MenuCategory(id: $id, name: $name, description: $description, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MenuCategoryCopyWith<$Res> implements $MenuCategoryCopyWith<$Res> {
  factory _$MenuCategoryCopyWith(_MenuCategory value, $Res Function(_MenuCategory) _then) = __$MenuCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, List<MenuItem> items
});




}
/// @nodoc
class __$MenuCategoryCopyWithImpl<$Res>
    implements _$MenuCategoryCopyWith<$Res> {
  __$MenuCategoryCopyWithImpl(this._self, this._then);

  final _MenuCategory _self;
  final $Res Function(_MenuCategory) _then;

/// Create a copy of MenuCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? items = null,}) {
  return _then(_MenuCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItem>,
  ));
}


}

/// @nodoc
mixin _$MenuItem {

 String get id; String get name; String get description; String get price; String? get imageUrl; bool get isAvailable;
/// Create a copy of MenuItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemCopyWith<MenuItem> get copyWith => _$MenuItemCopyWithImpl<MenuItem>(this as MenuItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'MenuItem(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $MenuItemCopyWith<$Res>  {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) _then) = _$MenuItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class _$MenuItemCopyWithImpl<$Res>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._self, this._then);

  final MenuItem _self;
  final $Res Function(MenuItem) _then;

/// Create a copy of MenuItem
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


/// Adds pattern-matching-related methods to [MenuItem].
extension MenuItemPatterns on MenuItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuItem value)  $default,){
final _that = this;
switch (_that) {
case _MenuItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuItem value)?  $default,){
final _that = this;
switch (_that) {
case _MenuItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String price,  String? imageUrl,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String price,  String? imageUrl,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _MenuItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String price,  String? imageUrl,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _MenuItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc


class _MenuItem extends MenuItem {
  const _MenuItem({required this.id, required this.name, required this.description, required this.price, this.imageUrl, this.isAvailable = false}): super._();
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String price;
@override final  String? imageUrl;
@override@JsonKey() final  bool isAvailable;

/// Create a copy of MenuItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemCopyWith<_MenuItem> get copyWith => __$MenuItemCopyWithImpl<_MenuItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'MenuItem(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$MenuItemCopyWith<$Res> implements $MenuItemCopyWith<$Res> {
  factory _$MenuItemCopyWith(_MenuItem value, $Res Function(_MenuItem) _then) = __$MenuItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class __$MenuItemCopyWithImpl<$Res>
    implements _$MenuItemCopyWith<$Res> {
  __$MenuItemCopyWithImpl(this._self, this._then);

  final _MenuItem _self;
  final $Res Function(_MenuItem) _then;

/// Create a copy of MenuItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_MenuItem(
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
mixin _$Review {

 String get id; String get userName; int get rating; String get comment; DateTime get createdAt; String? get userAvatarUrl;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,userName,rating,comment,createdAt,userAvatarUrl);

@override
String toString() {
  return 'Review(id: $id, userName: $userName, rating: $rating, comment: $comment, createdAt: $createdAt, userAvatarUrl: $userAvatarUrl)';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 String id, String userName, int rating, String comment, DateTime createdAt, String? userAvatarUrl
});




}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
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


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userName,  int rating,  String comment,  DateTime createdAt,  String? userAvatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userName,  int rating,  String comment,  DateTime createdAt,  String? userAvatarUrl)  $default,) {final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userName,  int rating,  String comment,  DateTime createdAt,  String? userAvatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.userName,_that.rating,_that.comment,_that.createdAt,_that.userAvatarUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Review extends Review {
  const _Review({required this.id, required this.userName, required this.rating, required this.comment, required this.createdAt, this.userAvatarUrl}): super._();
  

@override final  String id;
@override final  String userName;
@override final  int rating;
@override final  String comment;
@override final  DateTime createdAt;
@override final  String? userAvatarUrl;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,userName,rating,comment,createdAt,userAvatarUrl);

@override
String toString() {
  return 'Review(id: $id, userName: $userName, rating: $rating, comment: $comment, createdAt: $createdAt, userAvatarUrl: $userAvatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String userName, int rating, String comment, DateTime createdAt, String? userAvatarUrl
});




}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? userAvatarUrl = freezed,}) {
  return _then(_Review(
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
