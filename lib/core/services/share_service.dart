import 'dart:io';

import 'package:barpass_app/core/services/share_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  const ShareService();

  /// Compartilha texto simples
  Future<ShareStatus> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      if (text.isEmpty) {
        debugPrint('ShareService: Cannot share empty text');
        return ShareStatus.error;
      }

      final result = await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );

      debugPrint('ShareService: Text shared successfully');
      return _mapShareResult(result);
    } on Exception catch (error) {
      debugPrint('ShareService: Error sharing text: $error');
      return ShareStatus.error;
    }
  }

  /// Compartilha arquivos
  Future<ShareStatus> shareFiles(
    List<XFile> files, {
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      if (files.isEmpty) {
        debugPrint('ShareService: Cannot share empty file list');
        return ShareStatus.error;
      }

      final result = await SharePlus.instance.share(
        ShareParams(
          files: files,
          text: text,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );

      debugPrint('ShareService: Files shared successfully');
      return _mapShareResult(result);
    } on Exception catch (error) {
      debugPrint('ShareService: Error sharing files: $error');
      return ShareStatus.error;
    }
  }

  /// Compartilha uma única imagem
  Future<ShareStatus> shareImage(
    XFile image, {
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    return shareFiles(
      [image],
      text: text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Compartilha estabelecimento (método de conveniência específico do domínio)
  Future<ShareStatus> shareEstablishment({
    required String name,
    required String address,
    String? discount,
    String? rating,
    Rect? sharePositionOrigin,
  }) async {
    final text = _buildEstablishmentShareText(
      name: name,
      address: address,
      discount: discount,
      rating: rating,
    );

    return shareText(
      text,
      subject: 'Recomendação do barpass',
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Compartilha link de convite para o app
  Future<ShareStatus> shareAppInvite({
    String? personalMessage,
    Rect? sharePositionOrigin,
  }) async {
    final text = _buildAppInviteText(personalMessage);

    return shareText(
      text,
      subject: 'Convite para o barpass',
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Compartilha promoção/desconto específico
  Future<ShareStatus> sharePromotion({
    required String establishmentName,
    required String discount,
    String? validUntil,
    Rect? sharePositionOrigin,
  }) async {
    final text = _buildPromotionShareText(
      establishmentName: establishmentName,
      discount: discount,
      validUntil: validUntil,
    );

    return shareText(
      text,
      subject: 'Promoção especial do barpass',
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Verifica se o compartilhamento está disponível na plataforma
  Future<bool> isShareAvailable() async {
    try {
      if (kIsWeb) {
        // No web, verifica se há suporte a Web Share API
        return true; // share_plus lida com fallbacks
      }

      // No mobile, sempre disponível
      return Platform.isAndroid || Platform.isIOS;
    } on Exception catch (error) {
      debugPrint('ShareService: Error checking share availability: $error');
      return false;
    }
  }

  // Métodos privados para construção de mensagens

  /// Mapeia resultado do share_plus para nosso enum
  ShareStatus _mapShareResult(ShareResult result) {
    switch (result.status) {
      case ShareResultStatus.success:
        return ShareStatus.success;
      case ShareResultStatus.dismissed:
        return ShareStatus.cancelled;
      case ShareResultStatus.unavailable:
        return ShareStatus.error;
    }
  }

  String _buildEstablishmentShareText({
    required String name,
    required String address,
    String? discount,
    String? rating,
  }) {
    final buffer = StringBuffer()
      ..writeln('🍽️ Confira $name no barpass!')
      ..writeln()
      ..writeln('📍 $address');

    if (rating != null) {
      buffer.writeln('⭐ $rating');
    }

    if (discount != null && discount.isNotEmpty) {
      buffer.writeln('💰 $discount de desconto');
    }

    buffer
      ..writeln()
      ..writeln('📱 Baixe o barpass e economize em restaurantes e bares!')
      ..writeln('#barpass #desconto #economia');

    return buffer.toString().trim();
  }

  String _buildAppInviteText(String? personalMessage) {
    final buffer = StringBuffer();

    if (personalMessage != null && personalMessage.isNotEmpty) {
      buffer
        ..writeln(personalMessage)
        ..writeln();
    }

    buffer
      ..writeln('🍽️ Conheça o barpass!')
      ..writeln()
      ..writeln(
        '📱 O melhor app para encontrar descontos em restaurantes e bares da sua cidade.',
      )
      ..writeln()
      ..writeln('💰 Economize de verdade quando sair para comer e beber!')
      ..writeln()
      ..writeln('🔗 Baixe agora e comece a economizar:')
      // TODO: Adicionar links da loja quando disponível
      ..writeln('- iOS: [Link da App Store]')
      ..writeln('- Android: [Link da Play Store]');

    return buffer.toString().trim();
  }

  String _buildPromotionShareText({
    required String establishmentName,
    required String discount,
    String? validUntil,
  }) {
    final buffer = StringBuffer()
      ..writeln('🎉 Promoção especial!')
      ..writeln()
      ..writeln('🍽️ $establishmentName')
      ..writeln('💰 $discount de desconto');

    if (validUntil != null && validUntil.isNotEmpty) {
      buffer.writeln('⏰ Válido até: $validUntil');
    }

    buffer
      ..writeln()
      ..writeln('📱 Use o barpass e aproveite!')
      ..writeln('#barpass #promocao #desconto');

    return buffer.toString().trim();
  }
}
