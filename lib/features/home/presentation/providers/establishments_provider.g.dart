// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EstablishmentsNotifier)
const establishmentsProvider = EstablishmentsNotifierProvider._();

final class EstablishmentsNotifierProvider
    extends
        $AsyncNotifierProvider<EstablishmentsNotifier, List<Establishment>> {
  const EstablishmentsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'establishmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$establishmentsNotifierHash();

  @$internal
  @override
  EstablishmentsNotifier create() => EstablishmentsNotifier();
}

String _$establishmentsNotifierHash() =>
    r'1583f57cd9b73e28233afa5b1bad9389eef13490';

abstract class _$EstablishmentsNotifier
    extends $AsyncNotifier<List<Establishment>> {
  FutureOr<List<Establishment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Establishment>>, List<Establishment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Establishment>>, List<Establishment>>,
              AsyncValue<List<Establishment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FeaturedEstablishmentsNotifier)
const featuredEstablishmentsProvider =
    FeaturedEstablishmentsNotifierProvider._();

final class FeaturedEstablishmentsNotifierProvider
    extends
        $AsyncNotifierProvider<
          FeaturedEstablishmentsNotifier,
          List<Establishment>
        > {
  const FeaturedEstablishmentsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredEstablishmentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredEstablishmentsNotifierHash();

  @$internal
  @override
  FeaturedEstablishmentsNotifier create() => FeaturedEstablishmentsNotifier();
}

String _$featuredEstablishmentsNotifierHash() =>
    r'58dcf0074666a912bc87e98dc0edabb3217db3bb';

abstract class _$FeaturedEstablishmentsNotifier
    extends $AsyncNotifier<List<Establishment>> {
  FutureOr<List<Establishment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Establishment>>, List<Establishment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Establishment>>, List<Establishment>>,
              AsyncValue<List<Establishment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CarouselEstablishmentsNotifier)
const carouselEstablishmentsProvider =
    CarouselEstablishmentsNotifierProvider._();

final class CarouselEstablishmentsNotifierProvider
    extends
        $AsyncNotifierProvider<
          CarouselEstablishmentsNotifier,
          List<Establishment>
        > {
  const CarouselEstablishmentsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'carouselEstablishmentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$carouselEstablishmentsNotifierHash();

  @$internal
  @override
  CarouselEstablishmentsNotifier create() => CarouselEstablishmentsNotifier();
}

String _$carouselEstablishmentsNotifierHash() =>
    r'89e087246d16ee99a0c5c51a7e01a50f87bbf2d0';

abstract class _$CarouselEstablishmentsNotifier
    extends $AsyncNotifier<List<Establishment>> {
  FutureOr<List<Establishment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Establishment>>, List<Establishment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Establishment>>, List<Establishment>>,
              AsyncValue<List<Establishment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SearchEstablishments)
const searchEstablishmentsProvider = SearchEstablishmentsFamily._();

final class SearchEstablishmentsProvider
    extends $AsyncNotifierProvider<SearchEstablishments, List<Establishment>> {
  const SearchEstablishmentsProvider._({
    required SearchEstablishmentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchEstablishmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchEstablishmentsHash();

  @override
  String toString() {
    return r'searchEstablishmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SearchEstablishments create() => SearchEstablishments();

  @override
  bool operator ==(Object other) {
    return other is SearchEstablishmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchEstablishmentsHash() =>
    r'4f27324d87920a63a263e8ca698f269d7da0bd18';

final class SearchEstablishmentsFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchEstablishments,
          AsyncValue<List<Establishment>>,
          List<Establishment>,
          FutureOr<List<Establishment>>,
          String
        > {
  const SearchEstablishmentsFamily._()
    : super(
        retry: null,
        name: r'searchEstablishmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchEstablishmentsProvider call(String query) =>
      SearchEstablishmentsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchEstablishmentsProvider';
}

abstract class _$SearchEstablishments
    extends $AsyncNotifier<List<Establishment>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<List<Establishment>> build(String query);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<Establishment>>, List<Establishment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Establishment>>, List<Establishment>>,
              AsyncValue<List<Establishment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
