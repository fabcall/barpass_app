// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para carregar detalhes de um estabelecimento específico
///
/// Usa o padrão Family do Riverpod para criar um provider único
/// para cada establishmentId diferente

@ProviderFor(EstablishmentDetailNotifier)
const establishmentDetailProvider = EstablishmentDetailNotifierFamily._();

/// Provider para carregar detalhes de um estabelecimento específico
///
/// Usa o padrão Family do Riverpod para criar um provider único
/// para cada establishmentId diferente
final class EstablishmentDetailNotifierProvider
    extends
        $AsyncNotifierProvider<
          EstablishmentDetailNotifier,
          EstablishmentDetail?
        > {
  /// Provider para carregar detalhes de um estabelecimento específico
  ///
  /// Usa o padrão Family do Riverpod para criar um provider único
  /// para cada establishmentId diferente
  const EstablishmentDetailNotifierProvider._({
    required EstablishmentDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'establishmentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$establishmentDetailNotifierHash();

  @override
  String toString() {
    return r'establishmentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EstablishmentDetailNotifier create() => EstablishmentDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is EstablishmentDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$establishmentDetailNotifierHash() =>
    r'3ed9b1b1fe2990f1d33ced41e6b7065f5a5d3a19';

/// Provider para carregar detalhes de um estabelecimento específico
///
/// Usa o padrão Family do Riverpod para criar um provider único
/// para cada establishmentId diferente

final class EstablishmentDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EstablishmentDetailNotifier,
          AsyncValue<EstablishmentDetail?>,
          EstablishmentDetail?,
          FutureOr<EstablishmentDetail?>,
          String
        > {
  const EstablishmentDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'establishmentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider para carregar detalhes de um estabelecimento específico
  ///
  /// Usa o padrão Family do Riverpod para criar um provider único
  /// para cada establishmentId diferente

  EstablishmentDetailNotifierProvider call(String establishmentId) =>
      EstablishmentDetailNotifierProvider._(
        argument: establishmentId,
        from: this,
      );

  @override
  String toString() => r'establishmentDetailProvider';
}

/// Provider para carregar detalhes de um estabelecimento específico
///
/// Usa o padrão Family do Riverpod para criar um provider único
/// para cada establishmentId diferente

abstract class _$EstablishmentDetailNotifier
    extends $AsyncNotifier<EstablishmentDetail?> {
  late final _$args = ref.$arg as String;
  String get establishmentId => _$args;

  FutureOr<EstablishmentDetail?> build(String establishmentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<EstablishmentDetail?>, EstablishmentDetail?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EstablishmentDetail?>,
                EstablishmentDetail?
              >,
              AsyncValue<EstablishmentDetail?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider auxiliar para verificar se um estabelecimento existe

@ProviderFor(establishmentExists)
const establishmentExistsProvider = EstablishmentExistsFamily._();

/// Provider auxiliar para verificar se um estabelecimento existe

final class EstablishmentExistsProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider auxiliar para verificar se um estabelecimento existe
  const EstablishmentExistsProvider._({
    required EstablishmentExistsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'establishmentExistsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$establishmentExistsHash();

  @override
  String toString() {
    return r'establishmentExistsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return establishmentExists(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EstablishmentExistsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$establishmentExistsHash() =>
    r'8d0f69f0a5e3bd28fea1ed6fe46a6d7775c97c6b';

/// Provider auxiliar para verificar se um estabelecimento existe

final class EstablishmentExistsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const EstablishmentExistsFamily._()
    : super(
        retry: null,
        name: r'establishmentExistsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider auxiliar para verificar se um estabelecimento existe

  EstablishmentExistsProvider call(String establishmentId) =>
      EstablishmentExistsProvider._(argument: establishmentId, from: this);

  @override
  String toString() => r'establishmentExistsProvider';
}
