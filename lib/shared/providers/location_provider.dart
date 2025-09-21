import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

/// Estado da permissão de localização
class LocationPermissionState {
  const LocationPermissionState({
    required this.permission,
    required this.isServiceEnabled,
    this.lastKnownPosition,
    this.error,
  });

  final LocationPermission permission;
  final bool isServiceEnabled;
  final Position? lastKnownPosition;
  final String? error;

  bool get hasPermission =>
      permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;

  bool get isPermissionDeniedForever =>
      permission == LocationPermission.deniedForever;

  bool get canUseLocation => hasPermission && isServiceEnabled;

  LocationPermissionState copyWith({
    LocationPermission? permission,
    bool? isServiceEnabled,
    Position? lastKnownPosition,
    String? error,
  }) {
    return LocationPermissionState(
      permission: permission ?? this.permission,
      isServiceEnabled: isServiceEnabled ?? this.isServiceEnabled,
      lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
      error: error,
    );
  }
}

/// Provider para gerenciar o estado de permissão de localização
@Riverpod(keepAlive: true)
class LocationPermissionNotifier extends _$LocationPermissionNotifier {
  @override
  Future<LocationPermissionState> build() async {
    final locationService = ref.read(locationServiceProvider);

    final permission = await locationService.getPermissionStatus();
    final isServiceEnabled = await locationService.isLocationServiceEnabled();

    return LocationPermissionState(
      permission: permission,
      isServiceEnabled: isServiceEnabled,
    );
  }

  /// Atualiza o estado da permissão
  Future<void> checkPermission() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final locationService = ref.read(locationServiceProvider);

      final permission = await locationService.getPermissionStatus();
      final isServiceEnabled = await locationService.isLocationServiceEnabled();

      return LocationPermissionState(
        permission: permission,
        isServiceEnabled: isServiceEnabled,
        lastKnownPosition: state.value?.lastKnownPosition,
      );
    });
  }

  /// Solicita permissão de localização
  Future<bool> requestPermission() async {
    final locationService = ref.read(locationServiceProvider);

    // Verifica se o serviço está habilitado
    final isServiceEnabled = await locationService.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      state = AsyncValue.data(
        LocationPermissionState(
          permission: state.value?.permission ?? LocationPermission.denied,
          isServiceEnabled: false,
          error: 'Serviço de localização desabilitado',
        ),
      );
      return false;
    }

    // Solicita permissão
    final permission = await locationService.requestPermission();

    state = AsyncValue.data(
      LocationPermissionState(
        permission: permission,
        isServiceEnabled: isServiceEnabled,
        lastKnownPosition: state.value?.lastKnownPosition,
      ),
    );

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Abre as configurações de localização
  Future<void> openLocationSettings() async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.openLocationSettings();
    // Aguarda um pouco antes de verificar novamente
    await Future<void>.delayed(const Duration(seconds: 1));
    await checkPermission();
  }

  /// Abre as configurações do app
  Future<void> openAppSettings() async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.openAppSettings();
    // Aguarda um pouco antes de verificar novamente
    await Future<void>.delayed(const Duration(seconds: 1));
    await checkPermission();
  }

  /// Obtém a localização atual
  Future<Position?> getCurrentLocation() async {
    final locationService = ref.read(locationServiceProvider);

    final result = await locationService.getCurrentLocation();

    switch (result) {
      case LocationSuccess(:final position):
        state = AsyncValue.data(
          state.value!.copyWith(
            lastKnownPosition: position,
          ),
        );
        return position;

      case LocationError(:final message, :final type):
        state = AsyncValue.data(
          state.value!.copyWith(
            error: message,
          ),
        );

        // Se a permissão foi negada, atualiza o estado
        if (type == LocationErrorType.permissionDenied ||
            type == LocationErrorType.permissionDeniedForever) {
          await checkPermission();
        }

        return null;
    }
  }
}

/// Provider para obter a localização atual (one-shot)
@riverpod
Future<Position?> currentLocation(Ref ref) async {
  final notifier = ref.read(locationPermissionProvider.notifier);
  return notifier.getCurrentLocation();
}

/// Provider para verificar se tem permissão
@riverpod
bool hasLocationPermission(Ref ref) {
  final permissionState = ref.watch(locationPermissionProvider);

  return permissionState.when(
    data: (state) => state.hasPermission,
    loading: () => false,
    error: (_, __) => false,
  );
}
