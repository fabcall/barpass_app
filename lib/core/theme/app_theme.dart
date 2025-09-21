import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_typography.dart';

/// Tema principal do BarPass - versão simplificada
///
/// Mantém o FlexColorScheme mas com configuração mais limpa
abstract final class AppTheme {
  // === LIGHT THEME ===
  static ThemeData get light {
    final baseTheme = FlexThemeData.light(
      scheme: FlexScheme.shark,
      swapColors: true,
      lightIsWhite: true,
      bottomAppBarElevation: 0.5,

      // Configurações simplificadas
      subThemesData: const FlexSubThemesData(
        // Interações
        interactionEffects: true,
        blendOnLevel: 10,
        splashType: FlexSplashType.inkSparkle,
        splashTypeAdaptive: FlexSplashType.instantSplash,

        // Bordas padrão
        defaultRadius: 8,

        // Botões
        textButtonRadius: 40,
        filledButtonRadius: 40,
        elevatedButtonRadius: 40,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: 40,

        // Inputs
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 2,

        // FAB
        fabUseShape: true,
        fabAlwaysCircular: true,

        // Cards
        cardRadius: 12,

        // Navegação inferior
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: true,
        bottomNavigationBarMutedUnselectedIcon: true,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        bottomNavigationBarElevation: 0,

        // AppBar
        appBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
        appBarScrolledUnderElevation: 0.5,
      ),

      // Configuração de cores
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        useError: true,
        keepPrimary: true,
        keepSecondary: true,
        keepError: true,
        keepTertiaryContainer: true,
      ),

      tones: FlexSchemeVariant.chroma
          .tones(Brightness.light)
          .higherContrastFixed()
          .monochromeSurfaces(),

      // Densidade e configurações básicas
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

      // Fonte padrão
      fontFamily: AppTypography.poppins,
    );

    // Aplicar customizações
    return baseTheme.copyWith(
      // Ícone de voltar customizado
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(Icons.chevron_left),
      ),

      // TextTheme customizado
      textTheme: AppTypography.createTextTheme(),

      // AppBar com fonte Comfortaa
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle: AppTypography.appBarTitle
            .copyWith(
              color: Colors
                  .black, // Será substituído automaticamente no tema escuro
            )
            .merge(baseTheme.appBarTheme.titleTextStyle),
      ),
    );
  }

  // === DARK THEME ===
  static ThemeData get dark {
    final baseTheme = FlexThemeData.dark(
      scheme: FlexScheme.shark,
      swapColors: true,
      bottomAppBarElevation: 0.5,

      // Mesmas configurações do light theme
      subThemesData: const FlexSubThemesData(
        // Interações (com blend maior para dark)
        interactionEffects: true,
        blendOnLevel: 20,
        blendOnColors: true,
        splashType: FlexSplashType.inkSparkle,
        splashTypeAdaptive: FlexSplashType.instantSplash,

        // Bordas padrão
        defaultRadius: 8,

        // Botões
        textButtonRadius: 40,
        filledButtonRadius: 40,
        elevatedButtonRadius: 40,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: 40,

        // Inputs
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 2,

        // FAB
        fabUseShape: true,
        fabAlwaysCircular: true,

        // Cards
        cardRadius: 12,

        // Navegação inferior
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: true,
        bottomNavigationBarMutedUnselectedIcon: true,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        bottomNavigationBarElevation: 0,

        // AppBar (elevação maior no dark)
        appBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
        appBarScrolledUnderElevation: 2.5,
      ),

      // Configuração de cores (igual ao light)
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        useError: true,
        keepPrimary: true,
        keepSecondary: true,
        keepError: true,
        keepTertiaryContainer: true,
      ),

      tones: FlexSchemeVariant.chroma
          .tones(Brightness.dark)
          .higherContrastFixed()
          .monochromeSurfaces(),

      // Densidade e configurações básicas
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

      // Fonte padrão
      fontFamily: AppTypography.poppins,
    );

    // Aplicar customizações
    return baseTheme.copyWith(
      // Ícone de voltar customizado
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(Icons.chevron_left),
      ),

      // TextTheme customizado
      textTheme: AppTypography.createTextTheme(),

      // AppBar com fonte Comfortaa
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle: AppTypography.appBarTitle
            .copyWith(
              color: Colors.white, // Cor específica para dark theme
            )
            .merge(baseTheme.appBarTheme.titleTextStyle),
      ),
    );
  }
}
