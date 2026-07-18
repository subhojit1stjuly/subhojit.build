# Theme System Contract

**Feature**: 003-theme-switching  
**Contract Type**: Component API  
**Version**: 1.0.0  
**Date**: 2026-07-18

## Overview

This contract defines the public API for the Lumina theme system. All components in the `subhojit.build` project consume theme values through this stable interface. The contract guarantees backward compatibility — any changes to internal theme implementation (e.g., switching from ContentTheme to a custom system) must maintain this API surface.

---

## 1. Public Exports from `constants/theme.dart`

### 1.1 Theme Instance

**Export**: `appTheme`  
**Type**: `ContentTheme` (from `jaspr_content/theme.dart`)  
**Purpose**: Complete theme configuration for the application, consumed by `ContentApp` in `main.server.dart`

**Usage Contract**:
```dart
// main.server.dart
import 'constants/theme.dart';

runApp(
  ContentApp(
    theme: appTheme,  // ← Required: pass to ContentApp for CSS generation
    child: Document(...),
  ),
);
```

**Guarantees**:
- ✅ `appTheme` is a valid `ContentTheme` instance
- ✅ Defines all Lumina design system color tokens
- ✅ Includes both light and dark variants for all colors
- ✅ Safe to call `.styles` getter (generates CSS without errors)

---

### 1.2 Color Constants

**Export**: Dart constants for all Lumina color tokens  
**Type**: `Color` (from `jaspr/dom.dart`)  
**Implementation**: `Color.variable('--token-name')` (CSS variable references)

**Full API Surface**:

```dart
// Backgrounds & Surfaces
final Color bgColor;                       // --bg
final Color surfaceColor;                  // --surface
final Color surfaceContainerLowest;        // --surface-container-lowest
final Color surfaceContainerLow;           // --surface-container-low
final Color surfaceContainer;              // --surface-container
final Color surfaceContainerHigh;          // --surface-container-high
final Color surfaceContainerHighest;       // --surface-container-highest
final Color surfaceVariant;                // --surface-variant

// Primary Brand Colors
final Color primaryColor;                  // --primary
final Color primaryContainer;              // --primary-container
final Color onPrimary;                     // --on-primary
final Color primaryFixed;                  // --primary-fixed
final Color onPrimaryFixedVariant;         // --on-primary-fixed-variant
final Color inversePrimary;                // --inverse-primary

// Text Colors
final Color onSurface;                     // --on-surface
final Color onSurfaceVariant;              // --on-surface-variant
final Color inverseSurface;                // --inverse-surface
final Color inverseOnSurface;              // --inverse-on-surface
final Color textPrimary;                   // --text-primary (alias for onSurface)
final Color textSecondary;                 // --text-secondary (alias for onSurfaceVariant)

// Borders & Outlines
final Color outlineColor;                  // --outline
final Color outlineVariant;                // --outline-variant
final Color borderColor;                   // --border (alias for outlineVariant)

// Secondary/Accent Colors
final Color secondaryContainer;            // --secondary-container
final Color onSecondaryContainer;          // --on-secondary-container
final Color accentColor;                   // --accent (alias for primaryColor)
final Color accentHoverColor;              // --accent-hover (alias for onPrimaryFixedVariant)

// Utility Colors
final Color tagBgColor;                    // --tag-bg (alias for primaryFixed)
```

**Usage Contract**:

Components import and use these constants directly in `@css` blocks:

```dart
// components/hero_section.dart
import '../constants/theme.dart';

@css
static List<StyleRule> get styles => [
  css('.hero').styles(
    backgroundColor: bgColor,          // ← Theme-aware (light/dark)
    color: onSurface,                  // ← Theme-aware (light/dark)
  ),
  css('.hero-title').styles(
    color: primaryColor,               // ← Theme-aware (light/dark)
  ),
  css('.hero-card').styles(
    backgroundColor: surfaceContainer, // ← Theme-aware (light/dark)
    borderColor: outlineVariant,       // ← Theme-aware (light/dark)
  ),
];
```

**Guarantees**:
- ✅ All constants are non-null and implement `Color` interface
- ✅ `.value` getter returns CSS-safe string (e.g., `'var(--primary)'`)
- ✅ Safe to use in `.styles()` API: `color: primaryColor` → `color: var(--primary)`
- ✅ Safe to use in `raw:` maps: `{'border-color': borderColor.value}` → `{'border-color': 'var(--border)'}`
- ✅ Theme values update automatically when user toggles light/dark mode (no component code change needed)

**Breaking Changes (never allowed)**:
- ❌ Removing any exported constant
- ❌ Changing constant names (e.g., `bgColor` → `backgroundColor`)
- ❌ Returning non-`Color` type from constants
- ❌ Returning `null` from any constant

**Non-Breaking Changes (allowed)**:
- ✅ Adding new color constants (extends API)
- ✅ Changing light or dark color values (visual tweak only)
- ✅ Changing internal implementation (e.g., `Color.variable()` → custom wrapper)

---

### 1.3 Global Styles

**Export**: `styles` getter  
**Type**: `List<StyleRule>` (from `jaspr/dom.dart`)  
**Purpose**: Global CSS rules (resets, typography, utility classes)

**Usage Contract**:

**Pre-003 (direct use)**:
```dart
// main.server.dart
import 'constants/theme.dart';

runApp(
  Document(
    styles: styles,  // ← Global styles injected here
    body: App(),
  ),
);
```

**Post-003 (ContentApp integration)**:
```dart
// main.server.dart
import 'constants/theme.dart';

runApp(
  ContentApp(
    theme: appTheme,  // ← ContentTheme.styles handles global styles internally
    child: Document(
      // styles: [] — no longer needed, ContentApp injects theme styles
      body: App(),
    ),
  ),
);
```

**Guarantees**:
- ✅ `styles` getter is safe to call (no runtime errors)
- ✅ Includes all Lumina typography classes (`.t-display`, `.t-headline`, `.t-body`, etc.)
- ✅ Includes utility classes (`.container`, `.tonal-card`, `.pulse-dot`)
- ✅ Includes responsive media queries
- ✅ **Post-003**: May return empty list if ContentApp handles styles (deprecated but safe)

**Deprecation Notice (Post-003)**:
The `styles` getter is **redundant** after integrating `ContentApp`, as ContentTheme emits its own `:root` variables and base styles. Components should not directly import or use `styles` — `ContentApp` handles global style injection.

---

## 2. Component Integration Contract

### 2.1 Required Imports

All components consuming theme values **MUST** import `constants/theme.dart`:

```dart
import '../constants/theme.dart';  // Relative import from lib/components/
import '../../constants/theme.dart';  // Relative import from lib/pages/
```

**Forbidden**:
- ❌ Direct import of `jaspr_content/theme.dart` in components (violates encapsulation)
- ❌ Hardcoded `Color('#hex')` values in component styles (bypasses theme system)
- ❌ Magic string CSS variables: `Color.variable('--some-random-var')` (undocumented, fragile)

### 2.2 Allowed Color Usage Patterns

**Pattern A — Direct constant reference** (preferred):
```dart
css('.card').styles(
  backgroundColor: surfaceContainer,  // ← Theme constant
  color: onSurface,                   // ← Theme constant
  borderColor: outlineVariant,        // ← Theme constant
)
```

**Pattern B — Raw CSS map** (for unsupported properties):
```dart
css('.card').styles(
  raw: {
    'border-color': borderColor.value,  // ← .value extracts CSS variable string
    'box-shadow': '0 2px 8px ${outlineVariant.value}33',  // ← with alpha channel
  },
)
```

**Pattern C — Component-specific override** (rare, only if justified):
```dart
// When theme doesn't provide exact semantic token needed
css('.special-highlight').styles(
  backgroundColor: primaryColor.withOpacity(0.1),  // ← Derived color
)
```

**Anti-Patterns** (not allowed):
```dart
// ❌ Hardcoded color (bypasses theme)
css('.card').styles(backgroundColor: Color('#fbf9f4'))

// ❌ Undocumented CSS variable (fragile, breaks if theme changes)
css('.card').styles(backgroundColor: Color.variable('--some-custom-var'))

// ❌ Conditional theme logic in component (theme handles this)
final bgColor = isDarkMode ? Color('#0b0d0e') : Color('#fbf9f4');
```

---

## 3. ThemeToggle Component Contract

### 3.1 Integration

**Import**:
```dart
import 'package:jaspr_content/components/theme_toggle.dart';
```

**Usage**:
```dart
class Navbar extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return nav([
      // ... other navbar elements
      ThemeToggle(),  // ← Zero-config, drop-in component
    ]);
  }
}
```

**Guarantees**:
- ✅ `ThemeToggle()` constructor accepts only `key` parameter (optional)
- ✅ Renders a clickable button with sun/moon icon
- ✅ Clicking toggles `<html data-theme="light|dark">` attribute
- ✅ Theme preference persists to `localStorage['jaspr:theme']`
- ✅ Falls back to system preference (`prefers-color-scheme`) if no stored preference
- ✅ Accessible via keyboard (Tab to focus, Enter/Space to toggle)
- ✅ ARIA label: `"Theme Toggle"`
- ✅ No FOUC on page load (SSR-injected inline script sets `data-theme` before paint)

**Constraints**:
- ⚠️ `ThemeToggle` is `@client` component — cannot be used in server-only contexts
- ⚠️ Only supports binary light/dark toggle (no "system" option after first interaction)
- ⚠️ ARIA label is hardcoded (cannot be customized without wrapping component)
- ⚠️ Icon style is fixed (moon/sun SVG icons, cannot be overridden)

**Breaking Changes (external, jaspr_content-owned)**:
If `jaspr_content` changes `ThemeToggle` API in a future version, components must not break. Mitigation: pin `jaspr_content` version or create abstraction layer.

---

## 4. Theme Switching Behavior Contract

### 4.1 Data Attribute Contract

**Mechanism**: Theme mode is controlled by `data-theme` attribute on `<html>` element

```html
<!-- Light mode -->
<html data-theme="light">

<!-- Dark mode -->
<html data-theme="dark">
```

**CSS Cascade**:
```css
/* Light mode — default :root */
:root {
  --primary: #523fb9;
  --background: #fbf9f4;
}

/* Dark mode — override :root when attribute present */
:root[data-theme="dark"] {
  --primary: #c8bfff;
  --background: #0b0d0e;
}
```

**Components** reference CSS variables:
```css
.hero {
  background-color: var(--background);  /* Resolves based on data-theme */
  color: var(--on-surface);             /* Resolves based on data-theme */
}
```

**Guarantees**:
- ✅ Changing `data-theme` attribute instantly updates all CSS variable values
- ✅ All components using theme constants automatically re-render with new colors
- ✅ No component code needs theme-aware logic (CSS cascade handles it)

---

### 4.2 Persistence Contract

**Storage**: `window.localStorage`  
**Key**: `'jaspr:theme'`  
**Values**: `'light'` | `'dark'`

**Behavior**:
1. **First visit** (no `localStorage` entry):
   - If `prefers-color-scheme: dark` → Set `data-theme="dark"`, store `'dark'`
   - Else → Set `data-theme="light"`, store `'light'`

2. **Returning visitor** (`localStorage['jaspr:theme']` exists):
   - Read stored value
   - Set `data-theme` to stored value
   - Ignore system preference

3. **User toggles theme**:
   - Toggle `data-theme` attribute
   - Write new value to `localStorage`
   - Theme persists across navigation and sessions

**Fallback** (localStorage unavailable):
- Theme state persists in-memory for current session
- Next page load reverts to system preference

**Guarantees**:
- ✅ Theme preference survives page refresh
- ✅ Theme preference survives browser close/reopen
- ✅ Theme preference survives navigation (SPA or full page load)
- ✅ No errors thrown if `localStorage` is blocked (graceful degradation)

---

## 5. Accessibility Contract

### 5.1 Contrast Requirements (WCAG AA)

**Requirement**: All text/background pairs must meet WCAG 2.1 Level AA

| Text Size | Minimum Contrast | Lumina Compliance |
|-----------|------------------|-------------------|
| Normal text (<18px) | 4.5:1 | ✅ Validated |
| Large text (≥18px) | 3:1 | ✅ Validated |
| UI components | 3:1 | ✅ Validated |

**Validation**:
- Pre-implementation: All color pairs validated in `research.md` using WebAIM
- Post-implementation: Lighthouse accessibility audit must score 100

**Guarantees**:
- ✅ `onSurface` on `bgColor` → ≥4.5:1 in both themes
- ✅ `primaryColor` on `bgColor` → ≥3:1 in both themes (used for large headings)
- ✅ `outlineVariant` on `bgColor` → ≥3:1 in both themes (borders)

---

### 5.2 Keyboard Navigation

**Requirement**: `ThemeToggle` button must be fully keyboard-accessible

**Guarantees**:
- ✅ Button is focusable via Tab key
- ✅ Enter or Space key activates toggle
- ✅ Focus indicator is visible (browser default or custom `:focus-visible` style)
- ✅ Screen readers announce button as "Theme Toggle, button"

**Known Issue**:
`ThemeToggle` component applies `outline: Outline.unset` in its `@css` styles, which removes the default browser focus ring. Consuming applications **SHOULD** add a custom `:focus-visible` style:

```dart
// In navbar.dart or global styles
css.global('.theme-toggle:focus-visible').styles(
  outline: Outline.solid(width: 2.px, color: primaryColor),
  outlineOffset: 2.px,
)
```

---

### 5.3 Reduced Motion

**Requirement**: Respect `prefers-reduced-motion` user preference

**Implementation**:
```dart
@css
List<StyleRule> get styles => [
  // Default: smooth 200ms transition
  css('*, *::before, *::after').styles(
    raw: {'transition': 'background-color 0.2s ease, color 0.2s ease'},
  ),

  // Override: instant theme change for reduced motion
  css.media(MediaQuery.prefersReducedMotion(), [
    css('*, *::before, *::after').styles(
      raw: {'transition': 'none !important'},
    ),
  ]),
];
```

**Guarantees**:
- ✅ Users with `prefers-reduced-motion: reduce` see instant theme changes
- ✅ Users without motion preference see smooth 200ms transitions
- ✅ No jarring flashes or abrupt color shifts

---

## 6. Performance Contract

### 6.1 Build-Time Guarantees

**Static Site Generation**:
- ✅ `jaspr build` completes without errors
- ✅ Generated CSS includes both `:root` (light) and `:root[data-theme="dark"]` (dark) variables
- ✅ Pre-rendered HTML defaults to light theme (no `data-theme` attribute on `<html>`)
- ✅ Theme toggle script injected in `<head>` (prevents FOUC)

**Bundle Size**:
- ✅ Theme CSS adds <5 KB gzipped to bundle (spec requirement: `SC-007`)
- ✅ No additional JavaScript bundles (ThemeToggle is part of jaspr_content)

---

### 6.2 Runtime Guarantees

**Theme Toggle Response Time**:
- ✅ Toggle action completes in <100ms (spec requirement: `SC-002`)
  - `setState()` → ~1ms
  - `localStorage.setItem()` → ~0.5ms
  - `setAttribute('data-theme')` → <0.1ms
  - CSS cascade update → <1ms
  - **Total**: <50ms perceived delay

**No Layout Shift**:
- ✅ Toggling theme changes only colors (no layout reflow)
- ✅ No Cumulative Layout Shift (CLS) from theme change

---

## 7. Versioning & Deprecation Policy

### 7.1 Semantic Versioning

**Version format**: `MAJOR.MINOR.PATCH`  
**Current**: `1.0.0`

**Breaking changes** (require MAJOR bump):
- Removing any exported color constant
- Renaming color constants
- Changing constant type (e.g., `Color` → `String`)
- Removing `appTheme` export
- Changing `appTheme` type (e.g., `ContentTheme` → custom class)

**Non-breaking changes** (MINOR or PATCH bump):
- Adding new color constants
- Changing light or dark color values (visual tweak)
- Refactoring internal implementation (if API unchanged)
- Fixing contrast ratios (accessibility fix)

---

### 7.2 Deprecation Process

If a constant must be removed or renamed:

1. **Deprecation Notice** (MINOR version):
   ```dart
   @Deprecated('Use newColorName instead. Will be removed in 2.0.0.')
   final oldColorName = Color.variable('--old-name');
   ```

2. **Migration Period**: Minimum 1 release cycle (e.g., 1.1.0 → 1.2.0)

3. **Removal** (MAJOR version):
   ```dart
   // 2.0.0: oldColorName removed entirely
   ```

---

## 8. Testing Contract

### 8.1 Component Testing

**Components** consuming theme constants:

**Required Tests** (per component):
- ✅ Component renders without errors in light theme
- ✅ Component renders without errors in dark theme
- ✅ All text is readable (manual visual check or screenshot comparison)

**Test Pattern**:
```dart
// hero_section_test.dart
import 'package:jaspr_test/jaspr_test.dart';
import 'package:subhojit_build/components/hero_section.dart';

void main() {
  testComponents('HeroSection renders in light theme', (tester) async {
    await tester.pumpComponent(const HeroSection());
    expect(find.text('Subhojit Pramanik'), findsOneComponent);
    // Visual: verify dark text on light background
  });

  testComponents('HeroSection renders in dark theme', (tester) async {
    // Manually set data-theme attribute
    web.document.documentElement!.setAttribute('data-theme', 'dark');
    
    await tester.pumpComponent(const HeroSection());
    expect(find.text('Subhojit Pramanik'), findsOneComponent);
    // Visual: verify light text on dark background
  });
}
```

---

### 8.2 Integration Testing

**System-level tests**:

1. ✅ Theme defaults to light on first visit (no localStorage)
2. ✅ Theme defaults to dark if `prefers-color-scheme: dark` detected
3. ✅ Clicking `ThemeToggle` switches `data-theme` attribute
4. ✅ Theme preference persists after page refresh
5. ✅ Theme preference persists after browser restart (requires manual test)

---

## 9. Breaking Change Examples

### ❌ Example 1: Renaming Constant

**Before**:
```dart
final bgColor = Color.variable('--bg');
```

**After (BREAKING)**:
```dart
final backgroundColor = Color.variable('--bg');  // ❌ Breaks all components using bgColor
```

**Migration**:
```dart
// Step 1: Deprecate old name
@Deprecated('Use backgroundColor instead. Removed in 2.0.0.')
final bgColor = Color.variable('--bg');

// Step 2: Add new name
final backgroundColor = Color.variable('--bg');

// Step 3: Update all components to use new name (can be done gradually)

// Step 4: Remove old name in next MAJOR version
```

---

### ❌ Example 2: Changing ColorToken Name

**Before**:
```dart
ColorToken('primary', Color('#523fb9'), dark: Color('#c8bfff'))
// Components use: Color.variable('--primary')
```

**After (BREAKING)**:
```dart
ColorToken('brand-primary', Color('#523fb9'), dark: Color('#c8bfff'))  // ❌ Breaks all CSS
// Components now need: Color.variable('--brand-primary')
```

**Why breaking**: All `Color.variable('--primary')` references in components now resolve to undefined CSS variable (falls back to default).

---

## 10. Support & Maintenance

**Owner**: subhojit.build core team  
**Contact**: Raise issue in `subhojit1stjuly/subhojit.build` repository  
**Documentation**: `specs/003-theme-switching/` (this contract, research.md, data-model.md)

**SLA**:
- **Critical bugs** (theme not loading, accessibility failure): 24h response
- **Visual bugs** (wrong color in theme): 1 week response
- **Feature requests** (new color tokens): Backlog, no SLA

---

**Contract version 1.0.0 ratified: 2026-07-18**
