import 'package:jaspr/dom.dart';

// ============================================================
// Color Palette — Dark Portfolio Theme
// ============================================================

/// Deep slate page background.
const bgColor = Color('#0F172A');

/// Slightly elevated surface used for the navbar and cards.
const surfaceColor = Color('#1E293B');

/// Electric sky-blue accent — buttons, links, highlights.
const accentColor = Color('#38BDF8');

/// Darker shade of accent for hover states.
const accentHoverColor = Color('#0EA5E9');

/// Near-white for primary headings and body copy.
const textPrimary = Color('#F8FAFC');

/// Muted slate for secondary text and labels.
const textSecondary = Color('#94A3B8');

/// Subtle border dividers.
const borderColor = Color('#334155');

/// Dark blue fill used for skill/tech tag badges.
const tagBgColor = Color('#0C2D48');

// ============================================================
// Global base styles — applied site-wide via @css
// ============================================================
@css
List<StyleRule> get styles => [
  // Load Inter — a clean, modern geometric sans-serif.
  css.import(
    'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap',
  ),

  // Universal box-sizing reset so padding doesn't grow element dimensions.
  css('*, *::before, *::after').styles(
    boxSizing: BoxSizing.borderBox,
  ),

  // Base page defaults — dark background, Inter typeface.
  css('html, body').styles(
    width: 100.percent,
    margin: .zero,
    padding: .zero,
    backgroundColor: bgColor,
    color: textPrimary,
    fontFamily: const .list([FontFamily('Inter'), FontFamilies.sansSerif]),
  ),

  // Remove default heading/paragraph spacing so components control their own.
  css('h1, h2, h3, h4, h5, h6').styles(margin: .zero, padding: .zero),
  css('p').styles(margin: .zero, padding: .zero),

  // Strip underlines from links globally; each component re-styles as needed.
  css('a').styles(textDecoration: TextDecoration(line: .none)),

  // Reusable max-width container — centres content with side gutters.
  // Applied alongside component-specific classes: e.g. classes: 'hero container'
  css('.container').styles(
    maxWidth: 1200.px,
    width: 100.percent,
    padding: .symmetric(horizontal: 2.rem),
    raw: {'margin': '0 auto'},
  ),

  // Mobile: tighten the container side gutters.
  css.media(MediaQuery.screen(maxWidth: 600.px), [
    css('.container').styles(padding: .symmetric(horizontal: 1.25.rem)),
  ]),
];
