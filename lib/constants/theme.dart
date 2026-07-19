import 'package:jaspr/dom.dart';
import 'package:jaspr_content/theme.dart';

// ============================================================
// Theme Configuration — Lumina Design System
// ============================================================

// Backgrounds & Surfaces (dark base + subtle elevation)
final bgColor = ColorToken('bg',
  Color('#fbf9f4'),  // light: warm off-white
  dark: Color('#0b0d0e'));  // dark: very dark gray-blue

final surfaceColor = ColorToken('surface',
  Color('#fbf9f4'),
  dark: Color('#1a1c1e'));  // +8% brightness from bg

final surfaceContainerLowest = ColorToken('surface-container-lowest',
  Color('#ffffff'),  // pure white
  dark: Color('#0f1113'));  // darker than bg (modal overlays)

final surfaceContainerLow = ColorToken('surface-container-low',
  Color('#f5f3ee'),
  dark: Color('#1f2225'));  // +5% from surface

final surfaceContainer = ColorToken('surface-container',
  Color('#f0eee9'),
  dark: Color('#22252a'));  // +3% from low

final surfaceContainerHigh = ColorToken('surface-container-high',
  Color('#eae8e3'),
  dark: Color('#2c2f35'));  // elevated cards

final surfaceContainerHighest = ColorToken('surface-container-highest',
  Color('#e4e2dd'),
  dark: Color('#36393f'));  // top-level elevation

final surfaceVariant = ColorToken('surface-variant',
  Color('#e4e2dd'),
  dark: Color('#36393f'));  // matches highest

// Primary Brand Colors (desaturate in dark)
final primaryColor = ColorToken('primary',
  Color('#523fb9'),  // saturated purple
  dark: Color('#c8bfff'));  // pastel purple (40% lighter, -20% saturation)

final primaryContainer = ColorToken('primary-container',
  Color('#6b59d3'),
  dark: Color('#452fab'));  // darker variant for dark mode containers

final onPrimary = ColorToken('on-primary',
  Color('#ffffff'),
  dark: Color('#1a1c1e'));  // dark text on light primary button in dark mode

final primaryFixed = ColorToken('primary-fixed',
  Color('#e5deff'),  // tag backgrounds
  dark: Color('#2e2548'));  // dark mode tags: dark purple-gray

final onPrimaryFixedVariant = ColorToken('on-primary-fixed-variant',
  Color('#452fab'),  // hover states
  dark: Color('#b5a7ff'));  // lighter hover in dark mode

final inversePrimary = ColorToken('inverse-primary',
  Color('#c8bfff'),
  dark: Color('#523fb9'));  // swap for dark mode

// Text & Content
final onSurface = ColorToken('on-surface',
  Color('#1b1c19'),  // near-black text
  dark: Color('#e4e2dd'));  // light gray text (not pure white)

final onSurfaceVariant = ColorToken('on-surface-variant',
  Color('#484553'),  // secondary text
  dark: Color('#c9c4d5'));  // lighter secondary text

final inverseSurface = ColorToken('inverse-surface',
  Color('#30312e'),
  dark: Color('#e4e2dd'));

final inverseOnSurface = ColorToken('inverse-on-surface',
  Color('#f2f1ec'),
  dark: Color('#1b1c19'));

// Borders & Dividers
final outline = ColorToken('outline',
  Color('#787585'),
  dark: Color('#8e8c99'));  // subtle increase for visibility

final outlineVariant = ColorToken('outline-variant',
  Color('#c9c4d5'),  // soft borders
  dark: Color('#484553'));  // reduced contrast in dark

// Accent & Secondary
final secondaryContainer = ColorToken('secondary-container',
  Color('#d1e6f2'),  // light blue backgrounds
  dark: Color('#1f3a47'));  // dark teal-gray

final onSecondaryContainer = ColorToken('on-secondary-container',
  Color('#546771'),
  dark: Color('#b3d4e5'));  // light text on dark secondary

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
);

// Aliases (for backward compatibility with existing components)
final accentColor = primaryColor;
final accentHoverColor = onPrimaryFixedVariant;
final textPrimary = onSurface;
final textSecondary = onSurfaceVariant;
final borderColor = outlineVariant;
final tagBgColor = primaryFixed;

// ============================================================
// Global styles — Lumina System
// ============================================================
@css
List<StyleRule> get styles => [
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
      'transition': 'background-color 200ms ease, color 200ms ease, border-color 200ms ease, fill 200ms ease, stroke 200ms ease',
    }
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
    css('*, *::before, *::after').styles(
      raw: {'transition': 'none !important', 'animation': 'none !important'}
    ),
  ]),
];
