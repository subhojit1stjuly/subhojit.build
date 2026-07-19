import 'package:jaspr/dom.dart';
import 'package:jaspr_content/theme.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/core/theme/lumina_typography.dart';

// ============================================================
// ContentTheme — Register all tokens with jaspr_content
// ============================================================
final appTheme = ContentTheme(
  colors: [
    bgColor,
    surfaceColor,
    surfaceContainerLowest,
    surfaceContainerLow,
    surfaceContainer,
    surfaceContainerHigh,
    surfaceContainerHighest,
    surfaceVariant,
    primaryColor,
    primaryContainer,
    onPrimary,
    primaryFixed,
    onPrimaryFixedVariant,
    inversePrimary,
    onSurface,
    onSurfaceVariant,
    inverseSurface,
    inverseOnSurface,
    outline,
    outlineVariant,
    secondaryContainer,
    onSecondaryContainer,
  ],
  font: FontFamily('Inter'),
  typography: ContentTypography(
    rules: [
      // Standardizes tag behaviors inside dynamic markdown components
      StyleRule(selector: Selector('h1'), styles: LuminaTypography.headline),
      StyleRule(selector: Selector('h2'), styles: LuminaTypography.headlineM),
      StyleRule(selector: Selector('h3'), styles: LuminaTypography.title),
      StyleRule(selector: Selector('p'), styles: LuminaTypography.bodyLg),
      StyleRule(selector: Selector('span, label'), styles: LuminaTypography.body),
    ],
    styles: Styles(
      // Base styles for all content within the main content area
      fontSize: 1.05.rem,
      lineHeight: 1.7.em,
    ),
  ),
);

// ============================================================
// Global styles — Lumina System
// ============================================================
@css
List<StyleRule> get styles => [
  ...appTheme.styles,

  css.import('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap'),
  css.import('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@400,0&display=swap'),

  css('*, *::before, *::after').styles(boxSizing: BoxSizing.borderBox),

  css('html, body').styles(
    width: 100.percent,
    padding: .zero,
    margin: .zero,
    color: onSurface,
    fontFamily: const .list([FontFamily('Inter'), FontFamilies.sansSerif]),
    backgroundColor: bgColor,
    raw: {'scroll-behavior': 'smooth', '-webkit-font-smoothing': 'antialiased'},
  ),
  css('h1, h2, h3, h4, h5, h6').styles(padding: .zero, margin: .zero),
  css('p').styles(padding: .zero, margin: .zero),
  css('a').styles(textDecoration: TextDecoration(line: .none)),
  css('button').styles(cursor: Cursor.pointer),

  // Lumina typography scale ─────────────────────────────────
  css(
    '.t-display',
  ).styles(fontSize: 57.px, fontWeight: .w600, raw: {'line-height': '64px', 'letter-spacing': '-0.02em'}),
  css(
    '.t-headline',
  ).styles(fontSize: 32.px, fontWeight: .w600, raw: {'line-height': '40px', 'letter-spacing': '0.01em'}),
  css(
    '.t-headline-m',
  ).styles(fontSize: 28.px, fontWeight: .w600, raw: {'line-height': '36px', 'letter-spacing': '0.01em'}),
  css('.t-title').styles(fontSize: 22.px, fontWeight: .w500, raw: {'line-height': '28px'}),
  css(
    '.t-body-lg',
  ).styles(fontSize: 16.px, fontWeight: .w400, raw: {'line-height': '24px', 'letter-spacing': '0.01em'}),
  css('.t-body').styles(fontSize: 14.px, fontWeight: .w400, raw: {'line-height': '20px', 'letter-spacing': '0.01em'}),
  css('.t-label').styles(
    fontSize: 12.px,
    fontWeight: .w500,
    textTransform: TextTransform.upperCase,
    raw: {'line-height': '16px', 'letter-spacing': '0.05em'},
  ),

  // Material Symbols icon font ──────────────────────────────
  css('.material-symbols-outlined').styles(
    raw: {
      'font-family': "'Material Symbols Outlined'",
      'font-variation-settings': "'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24",
      'user-select': 'none',
      'vertical-align': 'middle',
      'font-style': 'normal',
      'display': 'inline-block',
    },
  ),

  // Layout utility ──────────────────────────────────────────
  css('.container').styles(
    width: 100.percent,
    maxWidth: 1200.px,
    padding: .symmetric(horizontal: 4.rem),
    raw: {'margin': '0 auto'},
  ),

  // Theme transitions ───────────────────────────────────────
  css('*, *::before, *::after').styles(
    raw: {
      'transition':
          'background-color 200ms ease, color 200ms ease, border-color 200ms ease, fill 200ms ease, stroke 200ms ease',
    },
  ),

  // Tonal card base (no hard borders — tonal layering only) ─
  css('.tonal-card').styles(
    radius: BorderRadius.circular(12.px),
    backgroundColor: surfaceContainer,
    raw: {'box-shadow': '0px 4px 20px rgba(26, 28, 30, 0.04)'},
  ),

  // Status dot pulse animation ──────────────────────────────
  css.keyframes('pulse-dot', {
    '0%, 100%': Styles(opacity: 1),
    '50%': Styles(opacity: 0.4),
  }),
  css('.pulse-dot').styles(raw: {'animation': 'pulse-dot 2s cubic-bezier(0.4,0,0.6,1) infinite'}),

  // Anchor offset for the sticky 64 px topbar ───────────────
  css('#about, #projects, #career, #contact').styles(raw: {'scroll-margin-top': '5rem'}),

  // Responsive overrides ────────────────────────────────────
  css.media(MediaQuery.screen(maxWidth: 768.px), [
    css('.container').styles(padding: .symmetric(horizontal: 1.rem)),
    css('.t-display').styles(fontSize: 36.px),
    css('.t-headline').styles(fontSize: 28.px),
  ]),

  // Reduced motion accessibility ────────────────────────────
  css('@media (prefers-reduced-motion: reduce)', [
    css('*, *::before, *::after').styles(raw: {'transition': 'none !important', 'animation': 'none !important'}),
  ]),
];
