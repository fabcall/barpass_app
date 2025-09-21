import 'dart:ui';

/// Tokens para tamanhos de componentes, elevações e outros valores dimensionais.
class AppSizes {
  const AppSizes._();

  // === LARGURA DAS BORDAS ===
  /// Largura padrão de bordas (1px)
  static const double borderWidth = 1;

  /// Largura de bordas focadas (2px)
  static const double focusedBorderWidth = 2;

  // === TAMANHOS DE ÍCONES REUTILIZÁVEIS ===
  /// Ícone extra pequeno (16px) - chips, badges
  static const double iconXs = 16;

  /// Ícone pequeno (20px) - bottom bar, toolbars
  static const double iconSm = 20;

  /// Ícone médio (24px) - padrão
  static const double iconMd = 24;

  /// Ícone grande (32px) - headers, destaques
  static const double iconLg = 32;

  /// Ícone extra grande (40px) - FAB, features principais
  static const double iconXl = 40;

  // === TAMANHOS DE IMAGENS/AVATARES REUTILIZÁVEIS ===
  /// Imagem/avatar extra pequeno (32px)
  static const double imageXs = 32;

  /// Imagem/avatar pequeno (40px)
  static const double imageSm = 40;

  /// Imagem/avatar médio (56px) - padrão para avatares e cards
  static const double imageMd = 56;

  /// Imagem/avatar grande (72px)
  static const double imageLg = 72;

  /// Imagem/avatar extra grande (96px)
  static const double imageXl = 96;

  /// Imagem/avatar extra extra grande (120px)
  static const double imageXxl = 120;

  // === ALIASES SEMÂNTICOS PARA AVATARES ===
  // Facilitam a leitura quando o contexto é especificamente avatar

  /// Avatar extra pequeno (32px) - listas compactas, chips
  static const double avatarXs = imageXs;

  /// Avatar pequeno (40px) - comentários, notificações
  static const double avatarSm = imageSm;

  /// Avatar médio (56px) - padrão para perfis, cards
  static const double avatarMd = imageMd;

  /// Avatar grande (72px) - headers, perfis destacados
  static const double avatarLg = imageLg;

  /// Avatar extra grande (96px) - página de perfil
  static const double avatarXl = imageXl;

  /// Avatar extra extra grande (120px) - perfil principal, onboarding
  static const double avatarXxl = imageXxl;

  // === ALTURAS DE COMPONENTES ===
  /// Altura pequena de componente (40px) - chips, badges
  static const double componentHeightSm = 40;

  /// Altura média de componente (48px) - botões, inputs
  static const double componentHeightMd = 48;

  /// Altura grande de componente (56px) - botões destacados
  static const double componentHeightLg = 56;

  /// Altura extra grande de componente (64px) - headers
  static const double componentHeightXl = 64;

  // === NAVEGAÇÃO ===
  /// Altura da bottom app bar (80px)
  static const double bottomAppBarHeight = 80;

  /// Tamanho dos ícones da bottom app bar (20px)
  static const double bottomAppBarIconSize = iconSm;

  /// Gap entre ícone e texto na bottom app bar (8px)
  static const double bottomAppBarIconGap = 8;

  /// Blur da sombra da bottom app bar (4px)
  static const double bottomAppBarShadowBlur = 4;

  /// Offset da sombra da bottom app bar
  static const Offset bottomAppBarShadowOffset = Offset(0, -4);

  // === FAB (Floating Action Button) ===
  /// Tamanho do FAB (56px)
  static const double fabSize = 56;

  /// Offset do FAB em relação à bottom bar (24px)
  static const double fabOffset = 24;

  /// Padding do notch ao redor do FAB (6px)
  static const double notchPadding = 6;

  /// Raio do notch calculado (FAB/2 + padding)
  static double get notchRadius => (fabSize / 2) + notchPadding;

  // === OUTROS COMPONENTES DE NAVEGAÇÃO ===
  /// Altura da navigation bar (72px)
  static const double navigationBarHeight = 72;

  /// Altura da track do slider (8px)
  static const double sliderTrackHeight = 8;

  /// Peso do indicador da tab bar (4px)
  static const double tabBarIndicatorWeight = 4;

  // === CHIPS E BADGES ===
  /// Tamanho da fonte em chips (12px)
  static const double chipFontSize = 12;

  /// Tamanho do ícone em chips (16px)
  static const double chipIconSize = iconXs;

  // === LARGURAS MÁXIMAS REUTILIZÁVEIS ===
  /// Largura máxima pequena (400px) - forms, dialogs pequenos
  static const double contentMaxWidthSm = 400;

  /// Largura máxima média (600px) - cards, modais
  static const double contentMaxWidthMd = 600;

  /// Largura máxima grande (800px) - conteúdo principal
  static const double contentMaxWidthLg = 800;

  /// Largura máxima extra grande (1200px) - layouts desktop
  static const double contentMaxWidthXl = 1200;

  // === BREAKPOINTS RESPONSIVOS ===
  /// Breakpoint mobile (até 600px)
  static const double mobileBreakpoint = 600;

  /// Breakpoint tablet (até 900px)
  static const double tabletBreakpoint = 900;

  /// Breakpoint desktop (1200px+)
  static const double desktopBreakpoint = 1200;
}
