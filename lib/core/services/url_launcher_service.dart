import 'dart:io';
import 'package:barpass_app/core/services/url_launcher_types.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncherService {
  const UrlLauncherService();

  Future<LaunchResult> launchUrl(
    String url, {
    LaunchConfig config = const LaunchConfig(),
  }) async {
    try {
      final uri = Uri.parse(url);

      // Verifica se pode abrir a URL
      final canLaunch = await launcher.canLaunchUrl(uri);
      if (!canLaunch) {
        debugPrint('UrlLauncherService: Cannot launch URL: $url');
        return LaunchResult.notSupported;
      }

      final launchMode = _mapLaunchMode(config.mode);

      final result = await launcher.launchUrl(
        uri,
        mode: launchMode,
        webOnlyWindowName: config.webOnlyWindowName,
        webViewConfiguration: launcher.WebViewConfiguration(
          enableJavaScript: config.enableJavaScript,
          enableDomStorage: config.enableDomStorage,
          headers: config.headers,
        ),
      );

      debugPrint('UrlLauncherService: Launch result for $url: $result');
      return result ? LaunchResult.success : LaunchResult.failed;
    } on Exception catch (error) {
      debugPrint('UrlLauncherService: Error launching URL $url: $error');
      return LaunchResult.error;
    }
  }

  Future<bool> canLaunchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launcher.canLaunchUrl(uri);
    } on Exception catch (error) {
      debugPrint('UrlLauncherService: Error checking URL $url: $error');
      return false;
    }
  }

  Future<LaunchResult> openWebUrl(String url, {bool inApp = false}) {
    final config = inApp ? LaunchConfig.webView : LaunchConfig.web;
    return launchUrl(url, config: config);
  }

  Future<LaunchResult> makePhoneCall(String phoneNumber) {
    final cleanNumber = _cleanPhoneNumber(phoneNumber);
    return launchUrl('tel:$cleanNumber');
  }

  Future<LaunchResult> sendSms(String phoneNumber, {String? message}) {
    final cleanNumber = _cleanPhoneNumber(phoneNumber);
    var url = 'sms:$cleanNumber';

    if (message != null && message.isNotEmpty) {
      final encodedMessage = Uri.encodeComponent(message);
      url += Platform.isIOS ? '&body=$encodedMessage' : '?body=$encodedMessage';
    }

    return launchUrl(url);
  }

  Future<LaunchResult> sendEmail({
    required String email,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: _buildEmailQuery(
        subject: subject,
        body: body,
        cc: cc,
        bcc: bcc,
      ),
    );

    return launchUrl(uri.toString());
  }

  Future<LaunchResult> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) {
    final cleanNumber = _cleanPhoneNumber(phoneNumber);
    var url = 'https://wa.me/$cleanNumber';

    if (message != null && message.isNotEmpty) {
      final encodedMessage = Uri.encodeComponent(message);
      url += '?text=$encodedMessage';
    }

    return launchUrl(url, config: LaunchConfig.external);
  }

  Future<LaunchResult> openMaps({
    double? latitude,
    double? longitude,
    String? address,
    String? query,
  }) {
    String url;

    if (latitude != null && longitude != null) {
      // Coordenadas específicas
      if (Platform.isIOS) {
        url = 'maps://?ll=$latitude,$longitude';
      } else {
        url = 'geo:$latitude,$longitude';
      }
    } else if (address != null) {
      // Endereço específico
      final encodedAddress = Uri.encodeComponent(address);
      if (Platform.isIOS) {
        url = 'maps://?address=$encodedAddress';
      } else {
        url = 'geo:0,0?q=$encodedAddress';
      }
    } else if (query != null) {
      // Busca geral
      final encodedQuery = Uri.encodeComponent(query);
      if (Platform.isIOS) {
        url = 'maps://?q=$encodedQuery';
      } else {
        url = 'geo:0,0?q=$encodedQuery';
      }
    } else {
      // Abre o app de mapas
      url = Platform.isIOS ? 'maps://' : 'geo:';
    }

    return launchUrl(url, config: LaunchConfig.external);
  }

  Future<LaunchResult> openAppStore({
    required String appId,
    bool isIOS = false,
  }) {
    final url = isIOS || Platform.isIOS
        ? 'https://apps.apple.com/app/id$appId'
        : 'https://play.google.com/store/apps/details?id=$appId';

    return launchUrl(url, config: LaunchConfig.external);
  }

  // Métodos auxiliares privados

  launcher.LaunchMode _mapLaunchMode(LaunchMode mode) {
    switch (mode) {
      case LaunchMode.externalApplication:
        return launcher.LaunchMode.externalApplication;
      case LaunchMode.inAppWebView:
        return launcher.LaunchMode.inAppWebView;
      case LaunchMode.externalNonBrowserApplication:
        return launcher.LaunchMode.externalNonBrowserApplication;
      case LaunchMode.platformDefault:
        return launcher.LaunchMode.platformDefault;
    }
  }

  String _cleanPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  String? _buildEmailQuery({
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) {
    final params = <String>[];

    if (subject != null) {
      params.add('subject=${Uri.encodeComponent(subject)}');
    }

    if (body != null) {
      params.add('body=${Uri.encodeComponent(body)}');
    }

    if (cc != null && cc.isNotEmpty) {
      params.add('cc=${cc.map(Uri.encodeComponent).join(',')}');
    }

    if (bcc != null && bcc.isNotEmpty) {
      params.add('bcc=${bcc.map(Uri.encodeComponent).join(',')}');
    }

    return params.isNotEmpty ? params.join('&') : null;
  }
}
