// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gerenciar o estado de permissão de localização

@ProviderFor(LocationPermissionNotifier)
const locationPermissionProvider = LocationPermissionNotifierProvider._();

/// Provider para gerenciar o estado de permissão de localização
final class LocationPermissionNotifierProvider
    extends
        $AsyncNotifierProvider<
          LocationPermissionNotifier,
          LocationPermissionState
        > {
  /// Provider para gerenciar o estado de permissão de localização
  const LocationPermissionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionNotifierHash();

  @$internal
  @override
  LocationPermissionNotifier create() => LocationPermissionNotifier();
}

String _$locationPermissionNotifierHash() =>
    r'6f91157df8b25623fcc23015f83fb51f89c828c2';

/// Provider para gerenciar o estado de permissão de localização

abstract class _$LocationPermissionNotifier
    extends $AsyncNotifier<LocationPermissionState> {
  FutureOr<LocationPermissionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<LocationPermissionState>,
              LocationPermissionState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LocationPermissionState>,
                LocationPermissionState
              >,
              AsyncValue<LocationPermissionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider para obter a localização atual (one-shot)

@ProviderFor(currentLocation)
const currentLocationProvider = CurrentLocationProvider._();

/// Provider para obter a localização atual (one-shot)

final class CurrentLocationProvider
    extends
        $FunctionalProvider<
          AsyncValue<Position?>,
          Position?,
          FutureOr<Position?>
        >
    with $FutureModifier<Position?>, $FutureProvider<Position?> {
  /// Provider para obter a localização atual (one-shot)
  const CurrentLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLocationHash();

  @$internal
  @override
  $FutureProviderElement<Position?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Position?> create(Ref ref) {
    return currentLocation(ref);
  }
}

String _$currentLocationHash() => r'd17a71ce4ba0f258b14502db70e3c15182ad0302';

/// Provider para verificar se tem permissão

@ProviderFor(hasLocationPermission)
const hasLocationPermissionProvider = HasLocationPermissionProvider._();

/// Provider para verificar se tem permissão

final class HasLocationPermissionProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider para verificar se tem permissão
  const HasLocationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasLocationPermissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasLocationPermissionHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasLocationPermission(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasLocationPermissionHash() =>
    r'6d3b4fac2cfd518815aed8aeb13859ad666ce048';
