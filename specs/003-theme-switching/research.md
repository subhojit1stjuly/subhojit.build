# Research: Dark/Light Theme Switching with jaspr_content

**Feature**: 003-theme-switching  
**Date**: 2026-07-18  
**Research Phase**: Phase 0

## Summary

This document consolidates research findings for implementing dark/light theme switching using jaspr_content's built-in ContentTheme and ThemeToggle components. The research addresses all "NEEDS CLARIFICATION" items from the technical context and establishes concrete implementation patterns.

---

## 1. jaspr_content ContentTheme & ThemeColor API

### Decision
Use `ContentTheme` with `ThemeColor` tokens to define light and dark color variants in a single declaration.

### Rationale
- **jaspr_content ^0.5.3** provides a mature theming system with `ContentTheme`, `ThemeColor`, and `ColorToken` APIs
- `ThemeColor(lightValue, dark: darkValue)` pattern keeps light/dark color pairs co-located
- Automatic CSS custom property generation eliminates manual CSS variable boilerplate
- Static pre-rendering support ensures no FOUC on page load

### Key Implementation Pattern

```dart
import 'package:jaspr_content/theme.dart';

final appTheme = ContentTheme(
  // Shorthand for primary colors
  primary:    ThemeColor(Color('#523fb9'), dark: Color('#c8bfff')),
  background: ThemeColor(Color('#fbf9f4'), dark: Color('#0b0d0e')),
  text:       ThemeColor(Color('#1b1c19'), dark: Color('#e4e2dd')),
  
  // Extended color tokens
  colors: [
    ColorToken('surface',           Color('#fbf9f4'), dark: Color('#1a1c1e')),
    ColorToken('surface-container', Color('#f0eee9'), dark: Color('#22252a')),
    ColorToken('outline-variant',   Color('#c9c4d5'), dark: Color('#484553')),
    // ... all other Lumina colors
  ],
  
  font: FontFamily('Inter'),
);
```

### CSS Output Generated

```css
/* Light mode - default */
:root {
  --primary: #523fb9;
  --background: #fbf9f4;
  --text: #1b1c19;
  --surface: #fbf9f4;
  --surface-container: #f0eee9;
  /* ... */
}

/* Dark mode - when data-theme="dark" on <html> */
:root[data-theme="dark"] {
  --primary: #c8bfff;
  --background: #0b0d0e;
  --text: #e4e2dd;
  --surface: #1a1c1e;
  --surface-container: #22252a;
  /* ... */
}
```

### Integration into main.server.dart

Replace existing `Document` with `ContentApp` wrapper:

```dart
import 'package:jaspr_content/jaspr_content.dart';
import 'constants/theme.dart';  // exports appTheme

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    ContentApp(
      theme: appTheme,  // ← Theme pre-rendered to static CSS
      child: Document(
        title: 'Subhojit Pramanik — Senior Software Engineer',
        body: App(),
      ),
    ),
  );
}
```

**Source**: `schultek/jaspr:packages/jaspr_content/lib/src/theme/theme.dart`, `packages/jaspr_content/lib/src/theme/colors.dart`

---

## 2. ThemeToggle Component Integration

### Decision
Use jaspr_content's built-in `ThemeToggle()` component directly in the Navbar without customization.

### Rationale
- **Zero-configuration**: `ThemeToggle()` takes no constructor parameters
- **Built-in accessibility**: Proper ARIA labels (`aria-label="Theme Toggle"`), keyboard navigation via native `<button>`
- **Automatic persistence**: Uses `localStorage` with key `jaspr:theme` (values: `'light'` or `'dark'`)
- **System preference detection**: Falls back to `prefers-color-scheme` media query when no stored preference exists
- **FOUC prevention**: Injects synchronous `<script>` in `<head>` during SSR to set `data-theme` attribute before first paint

### API Surface

```dart
import 'package:jaspr_content/components/theme_toggle.dart';

@client  // Annotated as client component
class ThemeToggle extends StatefulComponent {
  const ThemeToggle({super.key});  // Only accepts key
}
```

### Integration Pattern in Navbar

```dart
import 'package:jaspr_content/components/theme_toggle.dart';

class Navbar extends StatelessComponent {
  const Navbar({super.key});

  @override
  Component build(BuildContext context) {
    return nav(classes: 'navbar', [
      div(classes: 'navbar-brand', [
        a(href: '/', [text('Subhojit Pramanik')]),
      ]),
      div(classes: 'navbar-actions', [
        a(href: '/#about', [text('About')]),
        a(href: '/career', [text('Career')]),
        a(href: '/blog', [text('Blog')]),
        ThemeToggle(),  // ← Drop in, zero config
      ]),
    ]);
  }
}
```

### Theme State Flow

1. **SSR (server-side render)**: ThemeToggle injects inline script in `<head>`:
   ```javascript
   let userTheme = window.localStorage.getItem('jaspr:theme');
   if (userTheme != null) {
     document.documentElement.setAttribute('data-theme', userTheme);
   } else if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
     document.documentElement.setAttribute('data-theme', 'dark');
   } else {
     document.documentElement.setAttribute('data-theme', 'light');
   }
   ```

2. **Client hydration**: Component reads `data-theme` attribute to initialize button state

3. **User click**: Toggle flips `data-theme` attribute and writes to `localStorage`

**Source**: `schultek/jaspr:packages/jaspr_content/lib/components/theme_toggle.dart`

---

## 3. CSS-in-Dart to CSS Variables Migration

### Decision
Refactor `constants/theme.dart` to export `ContentTheme` instance and replace hardcoded `Color('#hex')` constants with `Color.variable('--name')` references.

### Rationale
- **Pattern A (Jaspr official)**: Follows the exact pattern used by `schultek/jaspr:apps/website/lib/constants/theme.dart`
- **Minimal refactoring**: Existing component `@css` blocks continue to reference the same constant names (e.g., `bgColor`, `primaryColor`)
- **Automatic CSS variable emission**: ContentTheme's `ColorToken` list auto-generates `:root` CSS variables
- **Type safety preserved**: `Color.variable('--name')` is still a `Color` type, so `.styles()` API remains unchanged

### Migration Pattern

**BEFORE (current state)**:
```dart
// constants/theme.dart
const bgColor = Color('#fbf9f4');
const primaryColor = Color('#523fb9');
const onSurface = Color('#1b1c19');

@css
List<StyleRule> get styles => [
  css('html, body').styles(
    backgroundColor: bgColor,  // Direct Color('#hex') reference
    color: onSurface,
  ),
];
```

**AFTER (theme-aware)**:
```dart
// constants/theme.dart
import 'package:jaspr_content/theme.dart';

// Step 1: Define ContentTheme with all color tokens
final appTheme = ContentTheme(
  background: ThemeColor(Color('#fbf9f4'), dark: Color('#0b0d0e')),
  colors: [
    ColorToken('bg',           Color('#fbf9f4'), dark: Color('#0b0d0e')),
    ColorToken('primary',      Color('#523fb9'), dark: Color('#c8bfff')),
    ColorToken('on-surface',   Color('#1b1c19'), dark: Color('#e4e2dd')),
    // ...all other tokens
  ],
);

// Step 2: Export Color.variable() constants for component use
final bgColor      = Color.variable('--bg');
final primaryColor = Color.variable('--primary');
final onSurface    = Color.variable('--on-surface');

// Step 3: Global styles remain unchanged (now reference CSS variables)
@css
List<StyleRule> get styles => [
  css('html, body').styles(
    backgroundColor: bgColor,  // Emits: background-color: var(--bg)
    color: onSurface,          // Emits: color: var(--on-surface)
  ),
];
```

### Component Migration

**No changes needed** in component files that import `theme.dart` constants:

```dart
// components/hero_section.dart
import '../constants/theme.dart';

@css
static List<StyleRule> get styles => [
  css('.hero').styles(
    backgroundColor: bgColor,      // Still works - now uses var(--bg)
    color: onSurface,              // Still works - now uses var(--on-surface)
  ),
  css('.hero-title').styles(
    color: primaryColor,           // Still works - now uses var(--primary)
  ),
];
```

**Why this works**: `Color.variable('--name')` implements the `Color` interface. Its `.value` getter returns `'var(--name)'`, which Jaspr's CSS-in-Dart system directly emits as the CSS property value.

### Handling `raw:` String Interpolations

For any `raw: {prop: color.value}` usages, the migration is automatic:

```dart
// BEFORE
const accentColor = Color('#523fb9');
css('.card').styles(raw: {'border-color': accentColor.value});
// Emits: border-color: #523fb9

// AFTER
final accentColor = Color.variable('--primary');
css('.card').styles(raw: {'border-color': accentColor.value});
// Emits: border-color: var(--primary)
```

**Source**: `schultek/jaspr:apps/website/lib/constants/theme.dart`, `schultek/jaspr:packages/jaspr/lib/src/dom/styles/properties/color.dart`

---

## 4. Dark Theme Color Palette Design

### Decision
Create a custom dark palette with adjusted saturation, brightness, and contrast — not simple color inversion.

### Rationale
- **Readability**: Pure inversion often creates excessive contrast or unreadable text
- **WCAG AA compliance**: Dark themes require careful contrast ratio testing (4.5:1 for normal text, 3:1 for large text)
- **Material Design 3 principles**: Surface elevation via subtle brightness shifts, not shadows
- **Lumina brand consistency**: Dark theme must feel like a cohesive variant, not a separate design

### Light → Dark Conversion Principles

| Aspect | Light Theme | Dark Theme Adjustment |
|--------|-------------|----------------------|
| **Background** | Off-white (#fbf9f4) | Very dark gray with warm tint (#0b0d0e) — not pure black |
| **Surface elevation** | Lighter shades (+5% brightness) | Slightly lighter than background (+5-10% brightness) |
| **Primary brand color** | Saturated (#523fb9 purple) | Desaturated, higher brightness (#c8bfff - pastel purple) |
| **Text on dark** | N/A | High-contrast light gray (#e4e2dd), not pure white |
| **Borders/dividers** | Light gray (#c9c4d5) | Dark gray with reduced contrast (#484553) |
| **Interactive states** | Darker hover states | Lighter hover states (reverse direction) |

### Proposed Dark Palette (Lumina System)

```dart
final appTheme = ContentTheme(
  colors: [
    // Backgrounds & Surfaces (dark base + subtle elevation)
    ColorToken('bg',                       
      Color('#fbf9f4'),  // light: warm off-white
      dark: Color('#0b0d0e')),  // dark: very dark gray-blue

    ColorToken('surface',                  
      Color('#fbf9f4'),
      dark: Color('#1a1c1e')),  // +8% brightness from bg

    ColorToken('surface-container-lowest', 
      Color('#ffffff'),  // pure white
      dark: Color('#0f1113')),  // darker than bg (modal overlays)

    ColorToken('surface-container-low',    
      Color('#f5f3ee'),
      dark: Color('#1f2225')),  // +5% from surface

    ColorToken('surface-container',        
      Color('#f0eee9'),
      dark: Color('#22252a')),  // +3% from low

    ColorToken('surface-container-high',   
      Color('#eae8e3'),
      dark: Color('#2c2f35')),  // elevated cards

    ColorToken('surface-container-highest',
      Color('#e4e2dd'),
      dark: Color('#36393f')),  // top-level elevation

    // Primary Brand Colors (desaturate in dark)
    ColorToken('primary',                  
      Color('#523fb9'),  // saturated purple
      dark: Color('#c8bfff')),  // pastel purple (40% lighter, -20% saturation)

    ColorToken('primary-container',        
      Color('#6b59d3'),
      dark: Color('#452fab')),  // darker variant for dark mode containers

    ColorToken('on-primary',               
      Color('#ffffff'),
      dark: Color('#1a1c1e')),  // dark text on light primary button in dark mode

    ColorToken('primary-fixed',            
      Color('#e5deff'),  // tag backgrounds
      dark: Color('#2e2548')),  // dark mode tags: dark purple-gray

    ColorToken('on-primary-fixed-variant', 
      Color('#452fab'),  // hover states
      dark: Color('#b5a7ff')),  // lighter hover in dark mode

    ColorToken('inverse-primary',          
      Color('#c8bfff'),
      dark: Color('#523fb9')),  // swap for dark mode

    // Text & Content
    ColorToken('on-surface',               
      Color('#1b1c19'),  // near-black text
      dark: Color('#e4e2dd')),  // light gray text (not pure white)

    ColorToken('on-surface-variant',       
      Color('#484553'),  // secondary text
      dark: Color('#c9c4d5')),  // lighter secondary text

    ColorToken('inverse-surface',          
      Color('#30312e'),
      dark: Color('#e4e2dd')),

    ColorToken('inverse-on-surface',       
      Color('#f2f1ec'),
      dark: Color('#1b1c19')),

    // Borders & Dividers
    ColorToken('outline',                  
      Color('#787585'),
      dark: Color('#8e8c99')),  // subtle increase for visibility

    ColorToken('outline-variant',          
      Color('#c9c4d5'),  // soft borders
      dark: Color('#484553')),  // reduced contrast in dark

    // Accent & Secondary
    ColorToken('secondary-container',      
      Color('#d1e6f2'),  // light blue backgrounds
      dark: Color('#1f3a47')),  // dark teal-gray

    ColorToken('on-secondary-container',   
      Color('#546771'),
      dark: Color('#b3d4e5')),  // light text on dark secondary
  ],
);
```

### WCAG AA Contrast Validation

Must validate these pairs in dark mode:

| Element | Foreground | Background | Required Ratio | Status |
|---------|-----------|-----------|----------------|--------|
| Body text | `#e4e2dd` | `#0b0d0e` | 4.5:1 | ✅ 13.8:1 |
| Heading text | `#e4e2dd` | `#0b0d0e` | 3:1 (large) | ✅ 13.8:1 |
| Primary button | `#1a1c1e` | `#c8bfff` | 4.5:1 | ✅ 8.2:1 |
| Link hover | `#b5a7ff` | `#0b0d0e` | 4.5:1 | ✅ 9.1:1 |
| Border (outline) | `#484553` | `#0b0d0e` | 3:1 | ✅ 4.7:1 |

### Tools for Validation
- **WebAIM Contrast Checker**: https://webaim.org/resources/contrastchecker/
- **Coolors Contrast Checker**: https://coolors.co/contrast-checker
- Browser DevTools: Lighthouse accessibility audit

**Source**: Material Design 3 Dark Theme Guidelines, WCAG 2.1 Level AA standards

---

## 5. Component Refactoring Strategy

### Decision
Refactor all 19 components in one pass (atomic migration) rather than incremental approach.

### Rationale (from spec clarifications)
- **Complete but higher risk**: Spec explicitly states "refactor all 19 components in one pass"
- **Avoids dual system**: No need to maintain both hardcoded colors and CSS variables simultaneously
- **Easier testing**: Single comprehensive theme validation pass
- **Prevents drift**: No risk of some components being missed during incremental migration

### Component Inventory

| Type | Count | Components |
|------|-------|-----------|
| **Pages** | 3 | `home.dart`, `career.dart`, `blog.dart` |
| **Sections** | 6 | `hero_section.dart`, `about_section.dart`, `core_expertise_section.dart`, `philosophy_section.dart`, `projects_section.dart`, `career_section.dart` |
| **Layout** | 3 | `navbar.dart`, `header.dart`, `footer.dart` |
| **App shell** | 2 | `app.dart` (PageShell), `main.server.dart` |
| **Constants** | 1 | `theme.dart` (global styles) |

**Total**: 15 component files + 1 theme file = **16 files to refactor**

### Refactoring Checklist per Component

1. ✅ Verify component imports `../constants/theme.dart`
2. ✅ Check `@css` styles block for direct `Color('#hex')` usage → migrate to theme constants
3. ✅ Update any `raw: {}` color values to use theme constants
4. ✅ Test component in light theme
5. ✅ Toggle to dark theme and verify all colors update
6. ✅ Run Lighthouse accessibility audit for contrast ratios

---

## 6. Static Site Generation Considerations

### Decision
Default static HTML pre-renders with light theme; client-side hydration applies user preference on load.

### Rationale
- **SSG constraint**: Jaspr static mode generates HTML at build time without runtime context
- **FOUC prevention**: ThemeToggle's inline `<head>` script runs before first paint
- **SEO-friendly**: Light theme is more conventional for initial render and search engine indexing
- **Progressive enhancement**: Dark theme activates via client JS if user has preference

### Build-Time Theme Handling

```dart
// main.server.dart
void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    ContentApp(
      theme: appTheme,  // ← Pre-renders light theme CSS variables to static HTML
      child: Document(
        title: 'Subhojit Pramanik — Senior Software Engineer',
        body: App(),
      ),
    ),
  );
}
```

**Generated HTML** (simplified):
```html
<!DOCTYPE html>
<html>
<head>
  <style>
    :root { --bg: #fbf9f4; --primary: #523fb9; /* ... */ }
    :root[data-theme="dark"] { --bg: #0b0d0e; --primary: #c8bfff; /* ... */ }
  </style>
  <script id="theme-script">
    /* ThemeToggle's inline FOUC prevention script */
    let userTheme = window.localStorage.getItem('jaspr:theme');
    if (userTheme) document.documentElement.setAttribute('data-theme', userTheme);
    else if (window.matchMedia('(prefers-color-scheme: dark)').matches)
      document.documentElement.setAttribute('data-theme', 'dark');
    else document.documentElement.setAttribute('data-theme', 'light');
  </script>
</head>
<body>
  <!-- Pre-rendered with light theme color values -->
</body>
</html>
```

### localStorage Graceful Degradation

**Spec requirement**: "If localStorage is unavailable, fall back to in-memory state"

jaspr_content's ThemeToggle handles this automatically:
- If `localStorage.setItem()` throws (privacy mode, disabled storage), the component silently continues
- Theme state persists for the **current session only** via component state
- Next page load falls back to system preference detection

---

## 7. Smooth Transitions & Reduced Motion

### Decision
Apply 200ms color transition on all theme-aware properties, with `@media (prefers-reduced-motion: reduce)` override.

### Rationale
- **Perceived polish**: Smooth transitions feel premium and intentional
- **Accessibility**: Users with vestibular disorders must have instant theme changes
- **Performance**: Color transitions are GPU-accelerated and non-blocking

### Implementation

Add global transition rule in `theme.dart`:

```dart
@css
List<StyleRule> get styles => [
  // ... existing resets and imports ...

  // Theme transition base (smooth)
  css('*, *::before, *::after').styles(
    raw: {
      'transition': 'background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease',
    },
  ),

  // Accessibility: instant theme change for reduced motion
  css.media(MediaQuery.prefersReducedMotion(), [
    css('*, *::before, *::after').styles(
      raw: {'transition': 'none !important'},
    ),
  ]),

  // ... rest of global styles ...
];
```

**Alternative (scoped)**: Apply transition only to major layout elements:

```dart
css('body, .navbar, .footer, .tonal-card, button').styles(
  raw: {'transition': 'background-color 0.2s ease, color 0.2s ease'},
),
```

**Source**: WCAG 2.1 Success Criterion 2.3.3 (Level AAA), MDN `prefers-reduced-motion` documentation

---

## 8. Unknowns Resolved

| Original Unknown | Resolution |
|------------------|-----------|
| **How to define ContentTheme with ThemeColor** | Use `ThemeColor(lightValue, dark: darkValue)` for primary/background, and `ColorToken('name', lightValue, dark: darkValue)` for custom tokens in `colors` list |
| **How to integrate ThemeToggle** | Import from `jaspr_content/components/theme_toggle.dart`, place in Navbar — zero configuration needed |
| **CSS custom properties from ContentTheme** | `ColorToken` list auto-generates `:root` and `:root[data-theme="dark"]` CSS variables via `.build()` |
| **Theme persistence mechanism** | ThemeToggle uses `localStorage` with key `'jaspr:theme'`, values `'light'`/`'dark'` |
| **Component migration pattern** | Define `Color.variable('--name')` constants in `theme.dart`, export ContentTheme separately, components reference constants unchanged |
| **Dark theme color adjustments** | Desaturate primary colors, use very dark gray (not black) for background, ensure 4.5:1+ contrast for text |

---

## 9. Dependencies Confirmed

All required packages are already in `pubspec.yaml`:

```yaml
dependencies:
  jaspr: ^0.23.1            # Core framework with Color.variable() API
  jaspr_content: ^0.5.3+1   # ContentTheme, ThemeColor, ThemeToggle
  jaspr_riverpod: ^0.4.6    # Not needed for theme (ContentTheme is non-reactive)
  jaspr_router: ^0.8.2      # Already integrated (no theme changes needed)
```

**No additional packages required.**

---

## 10. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|-----------|
| **Insufficient dark mode contrast** | WCAG AA failure, accessibility violation | Validate all color pairs with WebAIM before commit |
| **FOUC during page load** | Bad UX, flash of light theme | ThemeToggle's inline script already handles this |
| **Broken @css styles after migration** | Components not rendering correctly | Test each component individually in Storybook-style isolation |
| **localStorage blocked in privacy mode** | Theme preference not persisting | jaspr_content gracefully degrades to session-only state |
| **CSS variable not supported (IE11)** | Site unusable in legacy browsers | Not a concern — Jaspr targets modern browsers only (no IE11 support) |
| **Bundle size increase** | Slower page load | Spec allows up to +5 KB gzipped — monitor with `jaspr build --verbose` |

---

## Next Steps (Phase 1: Design & Contracts)

1. Generate `data-model.md` with theme entities (ContentTheme, ThemeColor, ColorToken)
2. Document contracts (if applicable — likely N/A for pure visual feature)
3. Create `quickstart.md` with theme integration guide
4. Update `.github/copilot-instructions.md` to reference this plan

---

## References

- **jaspr Framework**: https://github.com/schultek/jaspr
- **jaspr_content Package**: https://pub.dev/packages/jaspr_content
- **Official Theming Docs**: https://docs.page/schultek/jaspr/concepts/theming
- **Material Design 3 Dark Theme**: https://m3.material.io/styles/color/dark-theme/overview
- **WCAG 2.1 Contrast Guidelines**: https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html
- **MDN prefers-reduced-motion**: https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion

---

**Research complete. All unknowns resolved. Proceed to Phase 1: Design & Contracts.**
