import 'package:jaspr/dom.dart';

const bgColor = Color('#fbf9f4');
const surfaceColor = Color('#fbf9f4');
const surfaceContainerLowest = Color('#ffffff');
const surfaceContainerLow = Color('#f5f3ee');
const surfaceContainer = Color('#f0eee9');
const surfaceContainerHigh = Color('#eae8e3');
const surfaceContainerHighest = Color('#e4e2dd');
const surfaceVariant = Color('#e4e2dd');
const primaryColor = Color('#523fb9');
const primaryContainer = Color('#6b59d3');
const onPrimary = Color('#ffffff');
const primaryFixed = Color('#e5deff');
const onPrimaryFixedVariant = Color('#452fab');
const inversePrimary = Color('#c8bfff');
const onSurface = Color('#1b1c19');
const onSurfaceVariant = Color('#484553');
const inverseSurface = Color('#30312e');
const inverseOnSurface = Color('#f2f1ec');
const secondaryContainer = Color('#d1e6f2');
const onSecondaryContainer = Color('#546771');
const outlineColor = Color('#787585');
const outlineVariant = Color('#c9c4d5');
const accentColor = primaryColor;
const accentHoverColor = onPrimaryFixedVariant;
const textPrimary = onSurface;
const textSecondary = onSurfaceVariant;
const borderColor = outlineVariant;
const tagBgColor = primaryFixed;

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
];
