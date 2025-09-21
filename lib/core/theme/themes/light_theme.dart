import 'package:barpass_app/core/theme/extensions/theme_extensions.dart';
import 'package:barpass_app/core/theme/tokens/tokens.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Tema light do BarPass
class LightTheme {
  const LightTheme._();

  static ThemeData get theme {
    // Tema base do FlexColorScheme
    final baseTheme = FlexThemeData.light(
      scheme: FlexScheme.shark,
      swapColors: true,
      lightIsWhite: true,
      bottomAppBarElevation: 0.5,

      // Configurações de componentes
      subThemesData: const FlexSubThemesData(
        // Interações
        interactionEffects: true,
        blendOnLevel: 10,
        useM2StyleDividerInM3: true,
        splashType: FlexSplashType.inkSparkle,
        splashTypeAdaptive: FlexSplashType.instantSplash,

        // Adaptações
        adaptiveElevationShadowsBack: FlexAdaptive.all(),
        adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),

        // Bordas padrão
        defaultRadius: AppRadius.sm,

        // Botões
        textButtonRadius: AppRadius.pill,
        filledButtonRadius: AppRadius.pill,
        elevatedButtonRadius: AppRadius.pill,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: AppRadius.pill,
        outlinedButtonOutlineSchemeColor: SchemeColor.outlineVariant,

        // Toggle buttons
        toggleButtonsBorderSchemeColor: SchemeColor.outlineVariant,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.outlineVariant,

        // Switch
        switchThumbSchemeColor: SchemeColor.onPrimaryContainer,
        switchAdaptiveCupertinoLike: FlexAdaptive.all(),
        unselectedToggleIsColored: true,

        // Slider
        sliderValueTinted: true,
        sliderTrackHeight: AppSizes.sliderTrackHeight,

        // Input
        inputDecoratorIsDense: true,
        inputDecoratorContentPadding: EdgeInsets.all(AppSpacing.md),
        inputDecoratorBorderSchemeColor: SchemeColor.primary,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: AppRadius.md,
        inputDecoratorBorderWidth: AppSizes.borderWidth,
        inputDecoratorFocusedBorderWidth: AppSizes.focusedBorderWidth,

        // FAB
        fabUseShape: true,
        fabAlwaysCircular: true,

        // Chips
        chipSchemeColor: SchemeColor.secondaryContainer,
        chipSelectedSchemeColor: SchemeColor.primaryContainer,
        chipFontSize: AppSizes.chipFontSize,
        chipIconSize: AppSizes.chipIconSize,
        chipPadding: EdgeInsets.all(AppSpacing.xs),

        // Cards
        cardRadius: AppRadius.lg,

        // Menus
        popupMenuRadius: AppRadius.sm,
        popupMenuElevation: AppElevation.sm,
        alignedDropdown: true,
        menuRadius: AppRadius.sm,
        menuElevation: AppElevation.sm,
        menuSchemeColor: SchemeColor.surfaceContainerLowest,
        menuPadding: EdgeInsetsDirectional.fromSTEB(6, 10, 5, 10),
        menuBarRadius: AppElevation.none,
        menuBarElevation: AppElevation.none,
        menuBarShadowColor: Color(0x00000000),
        menuIndicatorBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        menuIndicatorRadius: AppRadius.sm,

        // Tooltips
        tooltipRadius: AppRadius.sm,
        tooltipSchemeColor: SchemeColor.surfaceContainerHigh,
        tooltipOpacity: 0.96,

        // Dialogs
        dialogBackgroundSchemeColor: SchemeColor.surfaceContainerHigh,
        dialogRadius: AppRadius.xl,

        // Snackbar
        snackBarRadius: AppRadius.sm,
        snackBarElevation: AppElevation.md,
        snackBarBackgroundSchemeColor: SchemeColor.surfaceContainerLow,

        // AppBar
        appBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
        appBarScrolledUnderElevation: AppElevation.sm,

        // Bottom AppBar
        bottomAppBarHeight: AppSizes.bottomAppBarHeight,

        // Tabs
        tabBarIndicatorWeight: AppSizes.tabBarIndicatorWeight,
        tabBarIndicatorTopRadius: AppSpacing.xs,
        tabBarDividerColor: Color(0x00000000),

        // Drawer
        drawerRadius: AppElevation.none,
        drawerElevation: AppElevation.xs,
        drawerIndicatorOpacity: 0.5,

        // Bottom Sheet
        bottomSheetBackgroundColor: SchemeColor.surfaceContainerHigh,
        bottomSheetModalBackgroundColor: SchemeColor.surfaceContainer,
        bottomSheetRadius: AppRadius.lg,
        bottomSheetElevation: AppElevation.sm,
        bottomSheetModalElevation: AppElevation.md,

        // Bottom Navigation
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: true,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedIcon: true,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        bottomNavigationBarElevation: AppElevation.none,

        // Search
        searchBarElevation: AppElevation.none,
        searchViewElevation: AppElevation.none,

        // Navigation Bar
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
        navigationBarElevation: AppElevation.none,
        navigationBarHeight: AppSizes.navigationBarHeight,

        // Navigation Rail
        navigationRailUseIndicator: true,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1,
        navigationRailBackgroundSchemeColor: SchemeColor.surfaceContainer,
      ),

      // Seed colors
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        useError: true,
        keepPrimary: true,
        keepSecondary: true,
        keepError: true,
        keepTertiaryContainer: true,
      ),

      // Tonal palette
      tones: FlexSchemeVariant.chroma
          .tones(Brightness.light)
          .higherContrastFixed()
          .monochromeSurfaces(),

      // Densidade e comportamento
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

      // Fonte padrão
      fontFamily: AppTypography.poppins,
    );

    // Cor de estado para labels de inputs
    final stateColor = WidgetStateColor.resolveWith((states) {
      final colorScheme = baseTheme.colorScheme;
      if (states.contains(WidgetState.error)) {
        return colorScheme.error;
      }
      if (states.contains(WidgetState.focused)) {
        return colorScheme.primary;
      }
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withValues(alpha: AppOpacity.disabled);
      }
      return colorScheme.onSurfaceVariant;
    });

    // Customizações finais
    return baseTheme.copyWith(
      // Extensions
      extensions: [
        SkeletonizerConfigData(
          containersColor: baseTheme.colorScheme.surfaceContainerHigh,
          effect: ShimmerEffect(
            baseColor: baseTheme.colorScheme.shimmerBase,
            highlightColor: baseTheme.colorScheme.shimmerHighlight,
          ),
          textBorderRadius: TextBoneBorderRadius(
            BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ],

      // Ícone de voltar customizado
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(Icons.chevron_left),
      ),

      // Botões mais gordos
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseTheme.elevatedButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: baseTheme.filledButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: baseTheme.outlinedButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: baseTheme.textButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),

      // TextTheme customizado
      textTheme: baseTheme.textTheme.merge(
        AppTypography.createTextTheme(),
      ),

      // AppBar com fonte Comfortaa
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle: AppTypography.appBarTitle
            .copyWith(
              color: Colors.black,
            )
            .merge(baseTheme.appBarTheme.titleTextStyle),
      ),

      // Input Decoration customizado
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        border: AppBorders.baseBorder(
          baseTheme.colorScheme.outlineVariant,
          AppSizes.borderWidth,
        ),
        enabledBorder: AppBorders.baseBorder(
          baseTheme.colorScheme.outlineVariant,
          AppSizes.borderWidth,
        ),
        focusedBorder: AppBorders.baseBorder(
          baseTheme.colorScheme.primary,
          AppSizes.focusedBorderWidth,
        ),
        errorBorder: AppBorders.baseBorder(
          baseTheme.colorScheme.error,
          AppSizes.borderWidth,
        ),
        focusedErrorBorder: AppBorders.baseBorder(
          baseTheme.colorScheme.error,
          AppSizes.focusedBorderWidth,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: baseTheme.inputDecorationTheme.labelStyle?.copyWith(
          color: stateColor,
        ),
      ),
    );
  }
}
