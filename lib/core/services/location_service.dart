import 'dart:async';

import 'package:geolocator/geolocator.dart';

/// Resultado de uma operação de localização
sealed class LocationResult {
  const LocationResult();
}

class LocationSuccess extends LocationResult {
  const LocationSuccess(this.position);
  final Position position;
}

class LocationError extends LocationResult {
  const LocationError(this.message, {this.type = LocationErrorType.unknown});
  final String message;
  final LocationErrorType type;
}

enum LocationErrorType {
  permissionDenied,
  permissionDeniedForever,
  serviceDisabled,
  timeout,
  unknown,
}

/// Serviço para gerenciamento de localização usando Geolocator
class LocationService {
  const LocationService();

  /// Verifica se o serviço de localização está habilitado no dispositivo
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Obtém o status atual da permissão de localização
  Future<LocationPermission> getPermissionStatus() async {
    return Geolocator.checkPermission();
  }

  /// Solicita permissão de localização ao usuário
  Future<LocationPermission> requestPermission() async {
    return Geolocator.requestPermission();
  }

  /// Verifica se tem permissão para acessar localização
  Future<bool> hasPermission() async {
    final permission = await getPermissionStatus();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Verifica se a permissão foi negada permanentemente
  Future<bool> isPermissionDeniedForever() async {
    final permission = await getPermissionStatus();
    return permission == LocationPermission.deniedForever;
  }

  /// Abre as configurações do app para o usuário alterar permissões
  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  /// Abre as configurações do app
  Future<bool> openAppSettings() async {
    return Geolocator.openAppSettings();
  }

  /// Obtém a localização atual do usuário
  ///
  /// [accuracy]: Nível de precisão desejado
  /// [timeout]: Tempo máximo de espera
  Future<LocationResult> getCurrentLocation({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      // Verifica se o serviço de localização está habilitado
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const LocationError(
          'Serviço de localização desabilitado',
          type: LocationErrorType.serviceDisabled,
        );
      }

      // Verifica permissão
      var permission = await getPermissionStatus();

      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          return const LocationError(
            'Permissão de localização negada',
            type: LocationErrorType.permissionDenied,
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const LocationError(
          'Permissão de localização negada permanentemente',
          type: LocationErrorType.permissionDeniedForever,
        );
      }

      // Obtém a posição
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: accuracy,
        ),
      ).timeout(timeout);

      return LocationSuccess(position);
    } on TimeoutException {
      return const LocationError(
        'Tempo limite excedido ao buscar localização',
        type: LocationErrorType.timeout,
      );
    } on Exception catch (e) {
      return LocationError(
        'Erro ao obter localização: $e',
        type: LocationErrorType.unknown,
      );
    }
  }

  /// Obtém stream de atualizações de localização em tempo real
  ///
  /// [accuracy]: Nível de precisão desejado
  /// [distanceFilter]: Distância mínima (em metros) para disparar atualização
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
    Duration? intervalDuration,
  }) {
    final settings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeLimit: intervalDuration,
    );

    return Geolocator.getPositionStream(locationSettings: settings);
  }

  /// Calcula a distância entre duas coordenadas em metros
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Calcula a distância entre duas posições em metros
  double calculateDistanceBetween(Position start, Position end) {
    return calculateDistance(
      startLatitude: start.latitude,
      startLongitude: start.longitude,
      endLatitude: end.latitude,
      endLongitude: end.longitude,
    );
  }

  /// Formata distância para exibição
  String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)}m';
    } else {
      final km = distanceInMeters / 1000;
      return '${km.toStringAsFixed(1)}km';
    }
  }
}
