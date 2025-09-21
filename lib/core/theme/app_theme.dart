import 'package:barpass_app/core/theme/app_typography.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Tema principal do BarPass - versão simplificada
///
/// Mantém o FlexColorScheme mas com configuração mais limpa
abstract final class AppTheme {
  // === LIGHT THEME ===
  static ThemeData get light {
    final baseTheme = FlexThemeData.light(
      // Using FlexColorScheme built-in FlexScheme enum based colors
      scheme: FlexScheme.shark,
      // Input color modifiers.
      swapColors: true,
      // Surface color adjustments.
      lightIsWhite: true,
      // Convenience direct styling properties.
      bottomAppBarElevation: 0.5,
      // Component theme configurations for light mode.
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        blendOnLevel: 10,
        useM2StyleDividerInM3: true,
        splashType: FlexSplashType.inkSparkle,
        splashTypeAdaptive: FlexSplashType.instantSplash,
        adaptiveElevationShadowsBack: FlexAdaptive.all(),
        adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
        defaultRadius: 6,
        textButtonRadius: 40,
        filledButtonRadius: 40,
        elevatedButtonRadius: 40,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: 40,
        outlinedButtonOutlineSchemeColor: SchemeColor.outlineVariant,
        toggleButtonsBorderSchemeColor: SchemeColor.outlineVariant,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.outlineVariant,
        switchThumbSchemeColor: SchemeColor.onPrimaryContainer,
        switchAdaptiveCupertinoLike: FlexAdaptive.all(),
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        sliderTrackHeight: 8,
        inputDecoratorIsDense: true,
        inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
          12,
          12,
          12,
          12,
        ),
        inputDecoratorBorderSchemeColor: SchemeColor.primary,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 2,
        fabUseShape: true,
        fabAlwaysCircular: true,
        chipSchemeColor: SchemeColor.secondaryContainer,
        chipSelectedSchemeColor: SchemeColor.primaryContainer,
        chipFontSize: 12,
        chipIconSize: 16,
        chipPadding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        cardRadius: 12,
        popupMenuRadius: 6,
        popupMenuElevation: 4,
        alignedDropdown: true,
        tooltipRadius: 6,
        tooltipSchemeColor: SchemeColor.surfaceContainerHigh,
        tooltipOpacity: 0.96,
        dialogBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        dialogRadius: 20,
        snackBarRadius: 6,
        snackBarElevation: 6,
        snackBarBackgroundSchemeColor: SchemeColor.surfaceContainerLow,
        appBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
        appBarScrolledUnderElevation: 4,
        bottomAppBarHeight: 60,
        tabBarIndicatorWeight: 4,
        tabBarIndicatorTopRadius: 4,
        tabBarDividerColor: Color(0x00000000),
        drawerRadius: 0,
        drawerElevation: 2,
        drawerIndicatorOpacity: 0.5,
        bottomSheetBackgroundColor: SchemeColor.surfaceContainerHigh,
        bottomSheetModalBackgroundColor: SchemeColor.surfaceContainer,
        bottomSheetRadius: 12,
        bottomSheetElevation: 4,
        bottomSheetModalElevation: 6,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: true,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedIcon: true,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        bottomNavigationBarElevation: 0,
        menuRadius: 6,
        menuElevation: 4,
        menuSchemeColor: SchemeColor.surfaceContainerLowest,
        menuPadding: EdgeInsetsDirectional.fromSTEB(6, 10, 5, 10),
        menuBarRadius: 0,
        menuBarElevation: 0,
        menuBarShadowColor: Color(0x00000000),
        menuIndicatorBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        menuIndicatorRadius: 6,
        searchBarElevation: 0,
        searchViewElevation: 0,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        navigationBarElevation: 0,
        navigationBarHeight: 72,
        navigationRailUseIndicator: true,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1,
        navigationRailBackgroundSchemeColor: SchemeColor.surfaceContainer,
      ),
      // ColorScheme seed generation configuration for light mode.
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
      // Direct ThemeData properties.
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
      textTheme: baseTheme.textTheme.merge(
        AppTypography.createTextTheme(),
      ),

      // AppBar com fonte Comfortaa
      appBarTheme: baseTheme.appBarTheme.copyWith(
        shadowColor: Colors.black.withValues(alpha: 0.4),
        titleTextStyle: AppTypography.appBarTitle
            .copyWith(
              color: Colors.black,
            )
            .merge(baseTheme.appBarTheme.titleTextStyle),
      ),
    );
  }

  // === DARK THEME ===
  static ThemeData get dark {
    final baseTheme = FlexThemeData.dark(
      // Using FlexColorScheme built-in FlexScheme enum based colors.
      scheme: FlexScheme.shark,
      // Input color modifiers.
      swapColors: true,
      // Convenience direct styling properties.
      bottomAppBarElevation: 0.5,
      // Component theme configurations for dark mode.
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        blendOnLevel: 20,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        splashType: FlexSplashType.inkSparkle,
        splashTypeAdaptive: FlexSplashType.instantSplash,
        adaptiveElevationShadowsBack: FlexAdaptive.all(),
        adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
        defaultRadius: 6,
        textButtonRadius: 40,
        filledButtonRadius: 40,
        elevatedButtonRadius: 40,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: 40,
        outlinedButtonOutlineSchemeColor: SchemeColor.outlineVariant,
        toggleButtonsBorderSchemeColor: SchemeColor.outlineVariant,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.outlineVariant,
        switchThumbSchemeColor: SchemeColor.onPrimaryContainer,
        switchAdaptiveCupertinoLike: FlexAdaptive.all(),
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        sliderTrackHeight: 8,
        inputDecoratorIsDense: true,
        inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
          12,
          12,
          12,
          12,
        ),
        inputDecoratorBorderSchemeColor: SchemeColor.primary,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 2,
        fabUseShape: true,
        fabAlwaysCircular: true,
        chipSchemeColor: SchemeColor.secondaryContainer,
        chipSelectedSchemeColor: SchemeColor.primaryContainer,
        chipFontSize: 12,
        chipIconSize: 16,
        chipPadding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        cardRadius: 12,
        popupMenuRadius: 6,
        popupMenuElevation: 4,
        alignedDropdown: true,
        tooltipRadius: 6,
        tooltipSchemeColor: SchemeColor.surfaceContainerHigh,
        tooltipOpacity: 0.96,
        dialogBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        dialogRadius: 20,
        snackBarRadius: 6,
        snackBarElevation: 6,
        snackBarBackgroundSchemeColor: SchemeColor.surfaceContainerLow,
        appBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
        appBarScrolledUnderElevation: 4,
        bottomAppBarHeight: 60,
        tabBarIndicatorWeight: 4,
        tabBarIndicatorTopRadius: 4,
        tabBarDividerColor: Color(0x00000000),
        drawerRadius: 0,
        drawerElevation: 2,
        drawerIndicatorOpacity: 0.5,
        bottomSheetBackgroundColor: SchemeColor.surfaceContainerHigh,
        bottomSheetModalBackgroundColor: SchemeColor.surfaceContainer,
        bottomSheetRadius: 12,
        bottomSheetElevation: 4,
        bottomSheetModalElevation: 6,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: true,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedIcon: true,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        bottomNavigationBarElevation: 0,
        menuRadius: 6,
        menuElevation: 4,
        menuSchemeColor: SchemeColor.surfaceContainerLowest,
        menuPadding: EdgeInsetsDirectional.fromSTEB(6, 10, 5, 10),
        menuBarRadius: 0,
        menuBarElevation: 0,
        menuBarShadowColor: Color(0x00000000),
        menuIndicatorBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        menuIndicatorRadius: 6,
        searchBarElevation: 0,
        searchViewElevation: 0,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        navigationBarElevation: 0,
        navigationBarHeight: 72,
        navigationRailUseIndicator: true,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1,
        navigationRailBackgroundSchemeColor: SchemeColor.surfaceContainer,
      ),
      // ColorScheme seed configuration setup for dark mode.
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
      // Direct ThemeData properties.
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
      textTheme: baseTheme.textTheme.merge(
        AppTypography.createTextTheme(),
      ),

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
