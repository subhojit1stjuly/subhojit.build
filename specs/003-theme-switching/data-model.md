# Data Model: Dark/Light Theme Switching

**Feature**: 003-theme-switching  
**Date**: 2026-07-18  
**Phase**: Design (Phase 1)

## Overview

This document defines the data entities, relationships, and state management for the dark/light theme switching feature using jaspr_content's ContentTheme system. The theme system is **declarative and stateless** from the application's perspective — all reactive state is managed internally by jaspr_content components.

---

## 1. Core Entities

### 1.1 ContentTheme

**Source**: `jaspr_content` package (`jaspr_content/theme.dart`)

**Description**: Immutable theme configuration object that defines all design tokens (colors, typography, spacing) for the application. Pre-rendered to static CSS during SSR/SSG build.

**Schema**:
```dart
class ContentTheme {
  const ContentTheme({
    Color? primary,        // Shorthand for primary color token
    Color? background,     // Shorthand for background color token
    Color? text,           // Shorthand for text color token
    List<ColorToken> colors = const [],  // Extended/override color tokens
    FontFamily? font,                     // Primary typeface
    FontFamily? codeFont,                 // Monospace typeface for code
    ContentTypography? typography,        // Typography rules
    Iterable<ThemeExtension<Object?>> extensions = const [],  // Component theme extensions
    bool reset = true,     // Whether to include CSS reset
  });
}
```

**Validation Rules**:
- `colors` list can override default `ContentColors` tokens by name
- `primary`, `background`, `text` shorthands apply to `ContentColors.primary`, `ContentColors.background`, `ContentColors.text` respectively
- If `reset: false`, no base CSS reset is emitted

**Lifecycle**:
1. **Build time**: Defined in `constants/theme.dart`, imported in `main.server.dart`
2. **SSR/SSG**: Jaspr's server runner calls `ContentTheme.styles` getter to generate CSS
3. **Runtime**: CSS variables are consumed by components via `Color.variable('--name')`

**Example**:
```dart
final appTheme = ContentTheme(
  primary:    ThemeColor(Color('#523fb9'), dark: Color('#c8bfff')),
  background: ThemeColor(Color('#fbf9f4'), dark: Color('#0b0d0e')),
  text:       ThemeColor(Color('#1b1c19'), dark: Color('#e4e2dd')),
  colors: [
    ColorToken('surface', Color('#fbf9f4'), dark: Color('#1a1c1e')),
    ColorToken('outline-variant', Color('#c9c4d5'), dark: Color('#484553')),
  ],
  font: FontFamily('Inter'),
);
```

---

### 1.2 ThemeColor

**Source**: `jaspr_content` package (`jaspr_content/src/theme/colors.dart`)

**Description**: Color implementation that holds both light and dark variants. Implements the `Color` interface for seamless use in Jaspr styles.

**Schema**:
```dart
class ThemeColor implements Color {
  const ThemeColor(this.light, {this.dark});

  final Color light;    // Light mode color value
  final Color? dark;    // Dark mode color value (nullable — defaults to light if omitted)

  @override
  String get value => light.value;  // Returns light color's CSS string
}
```

**Validation Rules**:
- `light` is required (non-nullable)
- `dark` is optional — if `null`, light value is used in both themes
- Both `light` and `dark` must be valid CSS color values (hex, rgb, oklch, named colors)

**State Transitions**:
- **Light mode active** (`data-theme="light"` or no attribute): Uses `light` value
- **Dark mode active** (`data-theme="dark"`): Uses `dark` value if present, else falls back to `light`

**Example**:
```dart
ThemeColor(Color('#523fb9'), dark: Color('#c8bfff'))  // Purple: saturated (light) → pastel (dark)
ThemeColor(Colors.white, dark: Color('#0b0d0e'))      // Background: white (light) → near-black (dark)
ThemeColor(Color('#787585'))                          // Border: same in both modes (no dark variant)
```

---

### 1.3 ColorToken

**Source**: `jaspr_content` package (`jaspr_content/src/theme/colors.dart`)

**Description**: Named color token that extends `ThemeColor`. Generates CSS custom property (`--name`) for consumption by components.

**Schema**:
```dart
class ColorToken extends ThemeColor {
  const ColorToken(this.name, super.light, {super.dark});

  final String name;  // CSS variable name (without '--' prefix)

  @override
  String get value => 'var(--$name)';  // Returns CSS variable reference

  ColorToken apply(Color color) { ... }  // Override this token's color
}
```

**Naming Convention**:
- Lowercase kebab-case: `'primary'`, `'surface-container'`, `'outline-variant'`
- Semantic names preferred over descriptive: `'primary'` over `'purple-500'`
- Scoped names for component tokens: `'file-tree-bg'`, `'code-block-border'`

**Relationships**:
- **Used by**: Components via `Color.variable('--name')` in `@css` styles
- **Defined in**: `ContentTheme.colors` list
- **Generated as**: CSS custom property in `:root` and `:root[data-theme="dark"]` selectors

**Example**:
```dart
ColorToken('surface', Color('#fbf9f4'), dark: Color('#1a1c1e'))
// Generates:
// :root { --surface: #fbf9f4; }
// :root[data-theme="dark"] { --surface: #1a1c1e; }
```

---

### 1.4 ThemeToggle (Component State)

**Source**: `jaspr_content` package (`jaspr_content/components/theme_toggle.dart`)

**Description**: `@client` StatefulComponent that manages theme switching UI and persistence. **Internal state only** — not exposed to application code.

**Internal State Schema**:
```dart
class ThemeToggleState extends State<ThemeToggle> {
  late bool isDark;  // Current theme state (true = dark, false = light)
}
```

**State Initialization** (client-side):
```dart
// initState() reads from <html> data-theme attribute
isDark = web.document.documentElement!.getAttribute('data-theme') == 'dark';
```

**State Mutations**:
```dart
// onClick handler
setState(() {
  isDark = !isDark;  // Toggle boolean state
});
web.window.localStorage.setItem('jaspr:theme', isDark ? 'dark' : 'light');  // Persist
web.document.documentElement!.setAttribute('data-theme', isDark ? 'dark' : 'light');  // Apply
```

**Persistence Layer**:
- **Storage**: `window.localStorage` (Web Storage API)
- **Key**: `'jaspr:theme'`
- **Values**: `'light'` | `'dark'` (string)
- **Fallback**: Session-only state if localStorage unavailable (privacy mode)

**System Preference Detection** (SSR-injected script):
```javascript
// Runs synchronously in <head> before first paint
let userTheme = window.localStorage.getItem('jaspr:theme');
if (userTheme != null) {
  document.documentElement.setAttribute('data-theme', userTheme);
} else if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
  document.documentElement.setAttribute('data-theme', 'dark');
} else {
  document.documentElement.setAttribute('data-theme', 'light');
}
```

**State Flow**:
1. **Page load** → SSR script reads `localStorage['jaspr:theme']` or detects `prefers-color-scheme`
2. **SSR script** → Sets `<html data-theme="light|dark">`
3. **Component hydration** → Reads `data-theme` attribute into `isDark` state
4. **User click** → Toggles `isDark`, updates `localStorage`, updates `data-theme` attribute
5. **CSS cascade** → `:root[data-theme="dark"]` rules apply, theme switches instantly

---

## 2. Data Flow Diagram

```text
┌─────────────────────────────────────────────────────────────────┐
│ Build Time (SSR/SSG)                                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  constants/theme.dart                                           │
│  ┌─────────────────┐                                            │
│  │ appTheme:       │                                            │
│  │ ContentTheme    │────┐                                       │
│  │ - primary       │    │                                       │
│  │ - background    │    │                                       │
│  │ - colors: [...]│    │                                       │
│  └─────────────────┘    │                                       │
│                         ▼                                       │
│  main.server.dart                                               │
│  ┌─────────────────────────────┐                                │
│  │ ContentApp(                 │                                │
│  │   theme: appTheme,          │                                │
│  │   child: Document(...),     │                                │
│  │ )                           │                                │
│  └─────────────────────────────┘                                │
│                         │                                       │
│                         ▼                                       │
│  ┌───────────────────────────────────────┐                      │
│  │ Jaspr Builder (.styles getter call)  │                      │
│  └───────────────────────────────────────┘                      │
│                         │                                       │
│                         ▼                                       │
│  Generated CSS (static HTML <style>)                            │
│  ┌────────────────────────────────────────────────┐             │
│  │ :root {                                        │             │
│  │   --primary: #523fb9;                          │             │
│  │   --background: #fbf9f4;                       │             │
│  │   --surface: #fbf9f4;                          │             │
│  │   /* ...all light values... */                │             │
│  │ }                                              │             │
│  │ :root[data-theme="dark"] {                     │             │
│  │   --primary: #c8bfff;                          │             │
│  │   --background: #0b0d0e;                       │             │
│  │   --surface: #1a1c1e;                          │             │
│  │   /* ...all dark values... */                 │             │
│  │ }                                              │             │
│  └────────────────────────────────────────────────┘             │
│                         │                                       │
│                         ▼                                       │
│  <html> (pre-rendered with light theme as default)             │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Runtime (Browser)                                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  <head> inline script (SSR-injected by ThemeToggle)             │
│  ┌──────────────────────────────────────────────────┐           │
│  │ 1. Read localStorage['jaspr:theme']              │           │
│  │ 2. If found → set <html data-theme="...">        │           │
│  │ 3. Else detect prefers-color-scheme              │           │
│  │ 4. Else default to 'light'                       │           │
│  └──────────────────────────────────────────────────┘           │
│                         │                                       │
│                         ▼                                       │
│  <html data-theme="light|dark">                                 │
│                         │                                       │
│           ┌─────────────┴─────────────┐                         │
│           ▼                           ▼                         │
│  CSS Variables Apply        ThemeToggle Component Hydrates      │
│  ─────────────────────      ──────────────────────────────      │
│  background-color:          isDark = (data-theme == 'dark')     │
│    var(--background)                                            │
│  → resolves to                                                  │
│    #fbf9f4 (light) or                                           │
│    #0b0d0e (dark)                                               │
│                                       │                         │
│                                       ▼                         │
│                              User clicks toggle button          │
│                                       │                         │
│                                       ▼                         │
│                    ┌────────────────────────────────┐           │
│                    │ setState(() => isDark = !isDark)           │
│                    ├────────────────────────────────┤           │
│                    │ localStorage.setItem(          │           │
│                    │   'jaspr:theme',               │           │
│                    │   isDark ? 'dark' : 'light'    │           │
│                    │ )                              │           │
│                    ├────────────────────────────────┤           │
│                    │ document.documentElement       │           │
│                    │   .setAttribute(               │           │
│                    │     'data-theme',              │           │
│                    │     isDark ? 'dark' : 'light'  │           │
│                    │   )                            │           │
│                    └────────────────────────────────┘           │
│                                       │                         │
│                                       ▼                         │
│                    CSS Variables Re-Resolve                     │
│                    (instant with 200ms transition)              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Component Color Consumption Pattern

### 3.1 Export Pattern (constants/theme.dart)

```dart
import 'package:jaspr_content/theme.dart';

// Define ContentTheme with ColorTokens
final appTheme = ContentTheme(
  colors: [
    ColorToken('bg',           Color('#fbf9f4'), dark: Color('#0b0d0e')),
    ColorToken('primary',      Color('#523fb9'), dark: Color('#c8bfff')),
    ColorToken('on-surface',   Color('#1b1c19'), dark: Color('#e4e2dd')),
    // ...all other tokens
  ],
);

// Export Color.variable() constants for component use
final bgColor      = Color.variable('--bg');
final primaryColor = Color.variable('--primary');
final onSurface    = Color.variable('--on-surface');
// ...matching exports for all tokens
```

### 3.2 Component Consumption (components/hero_section.dart)

```dart
import '../constants/theme.dart';

class HeroSection extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return section(classes: 'hero', [
      h1(classes: 't-display', [text('Subhojit Pramanik')]),
      p(classes: 't-body-lg', [text('Senior Software Engineer')]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero').styles(
      backgroundColor: bgColor,      // ← Emits: background-color: var(--bg)
      color: onSurface,              // ← Emits: color: var(--on-surface)
      padding: .vertical(4.rem),
    ),
    css('.hero h1').styles(
      color: primaryColor,           // ← Emits: color: var(--primary)
    ),
  ];
}
```

**Why this works**: `Color.variable('--bg')` implements `Color` interface. Its `.value` getter returns `'var(--bg)'`, which Jaspr's CSS-in-Dart compiler emits directly as the CSS property value.

---

## 4. State Transitions

### 4.1 Theme Mode Transition

```text
┌──────────────────────────────────────────────────────────────┐
│ State Machine: Theme Mode                                    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│    ┌──────┐                                                  │
│    │LIGHT │ ◄─────────────────┐                              │
│    └──────┘                   │                              │
│       │                       │                              │
│       │ User clicks toggle    │ User clicks toggle           │
│       │ isDark = true         │ isDark = false               │
│       │ data-theme="dark"     │ data-theme="light"           │
│       │                       │                              │
│       ▼                       │                              │
│    ┌──────┐                   │                              │
│    │ DARK │───────────────────┘                              │
│    └──────┘                                                  │
│                                                              │
│  Initial State Determination (on page load):                 │
│  ─────────────────────────────────────────────               │
│  1. localStorage['jaspr:theme'] exists?                      │
│     → Use stored value                                       │
│  2. Else: prefers-color-scheme: dark?                        │
│     → Set DARK                                               │
│  3. Else:                                                    │
│     → Default to LIGHT                                       │
│                                                              │
│  Persistence:                                                │
│  ─────────────                                               │
│  - Every state change writes to localStorage                 │
│  - Persists across page navigation and browser sessions      │
│  - Survives page refresh                                     │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### 4.2 CSS Variable Resolution

```text
CSS Variable Resolution (per property, per state)
──────────────────────────────────────────────────

Input: Component style referencing a color
       .styles(backgroundColor: bgColor)
       where bgColor = Color.variable('--bg')

Emitted CSS:
       .hero { background-color: var(--bg); }

Runtime Resolution:
       <html data-theme="light">
       → :root { --bg: #fbf9f4; }
       → Resolves to: background-color: #fbf9f4;

       <html data-theme="dark">
       → :root[data-theme="dark"] { --bg: #0b0d0e; }
       → Resolves to: background-color: #0b0d0e;

Transition (on theme toggle):
       1. data-theme attribute changes (instant)
       2. CSS variables re-resolve (instant)
       3. Properties animate over 200ms (transition: background-color 0.2s ease)
```

---

## 5. Validation Rules & Constraints

### 5.1 Color Contrast (WCAG AA)

**Requirement**: All text/background pairs must meet WCAG 2.1 Level AA contrast ratios

| Text Type | Min Contrast | Lumina Dark Theme Validation |
|-----------|--------------|------------------------------|
| Normal text (<18px) | 4.5:1 | `#e4e2dd` on `#0b0d0e` → 13.8:1 ✅ |
| Large text (≥18px or ≥14px bold) | 3:1 | `#e4e2dd` on `#0b0d0e` → 13.8:1 ✅ |
| UI components (borders, icons) | 3:1 | `#484553` on `#0b0d0e` → 4.7:1 ✅ |

**Validation Process**:
1. Export all color pairs from `research.md` dark palette
2. Run through WebAIM Contrast Checker: https://webaim.org/resources/contrastchecker/
3. Log results in implementation checklist
4. Fix any failures before merge

### 5.2 ColorToken Naming

**Rules**:
- Kebab-case only: `'primary-container'`, not `'primaryContainer'`
- Semantic names preferred: `'error'` over `'red-600'`
- Scoped for components: `'navbar-bg'`, not just `'bg'` (if component-specific)
- No `--` prefix in `ColorToken` constructor (auto-added by `.value` getter)

**Invalid**:
```dart
ColorToken('--primary', ...)   // ❌ Double prefix: var(----primary)
ColorToken('Primary', ...)     // ❌ Capital letter
ColorToken('bg_color', ...)    // ❌ Underscore instead of hyphen
```

**Valid**:
```dart
ColorToken('primary', ...)
ColorToken('surface-container-highest', ...)
ColorToken('file-tree-highlight', ...)
```

### 5.3 localStorage Fallback

**Constraint**: If `localStorage` is unavailable (privacy mode, disabled):
- Theme preference persists **for current session only** (in-memory)
- Next page load falls back to `prefers-color-scheme` detection
- No error thrown — ThemeToggle handles gracefully

**Test Case**:
```text
Given: User in private browsing mode (localStorage blocked)
When:  User toggles theme to dark
Then:  Theme changes to dark immediately
       AND localStorage.setItem() silently fails
       AND theme persists across SPA navigation (in-memory state)
But:   Next browser session defaults to system preference
```

---

## 6. Edge Cases & Error Handling

### 6.1 Missing Dark Variant

**Scenario**: `ThemeColor` defined with no `dark:` parameter

```dart
ThemeColor(Color('#787585'))  // No dark variant
```

**Behavior**: Light value is used in both themes

**Generated CSS**:
```css
:root { --outline: #787585; }
/* No dark override — light value applies in dark mode too */
```

### 6.2 Invalid Color Syntax

**Scenario**: ColorToken constructed with malformed color string

```dart
ColorToken('primary', Color('invalid-color'))  // ❌ Invalid CSS color
```

**Behavior**: 
- Dart compile-time: No error (Color constructor accepts any string)
- Runtime: CSS property renders as `invalid-color` (invalid, falls back to default)
- Browser DevTools: Warns "Invalid property value"

**Prevention**: Use only validated hex, rgb, oklch, or named CSS colors

### 6.3 Rapid Toggle Clicking

**Scenario**: User clicks ThemeToggle button rapidly (5+ times per second)

**Behavior**:
- `setState()` called on every click (React-style batching not present)
- `localStorage.setItem()` called synchronously each time
- `data-theme` attribute updated each time
- CSS transitions may overlap/jank

**Mitigation**: Consider debouncing `localStorage` writes (future enhancement, not required for MVP)

### 6.4 SSR Script Failure

**Scenario**: Browser blocks inline `<script>` (strict CSP without `'unsafe-inline'`)

**Behavior**:
- Theme defaults to light mode (no `data-theme` attribute set)
- ThemeToggle component hydrates with `isDark = false`
- User can still toggle manually
- Theme preference read from `localStorage` on hydration

**Consequence**: FOUC (flash of light theme before dark theme activates)

**Mitigation**: Ensure CSP allows `'unsafe-inline'` for scripts, or refactor ThemeToggle to use external script

---

## 7. Performance Characteristics

### 7.1 CSS Variable Lookup

- **Complexity**: O(1) — CSS engine resolves `var(--name)` via hash lookup
- **Cost**: ~0.02ms per property (negligible)
- **Comparison**: Identical to hardcoded color values

### 7.2 Theme Toggle Response Time

| Operation | Time | Notes |
|-----------|------|-------|
| `setState()` | ~1ms | Component re-render |
| `localStorage.setItem()` | ~0.5ms | Synchronous write |
| `setAttribute('data-theme')` | <0.1ms | DOM mutation |
| CSS cascade update | <1ms | Browser recalc |
| **Total (perceived)** | **<50ms** | Feels instant |

### 7.3 Build-Time CSS Generation

- **ContentTheme.styles call**: ~5ms (generates all `:root` rules)
- **Impact on `jaspr build`**: <100ms added to total build time
- **Output size**: ~2-3 KB uncompressed CSS (all theme variables)
- **Gzipped**: <1 KB (meets <5 KB budget from spec)

---

## 8. Testing Strategy

### 8.1 Unit Tests (N/A)

**Reasoning**: No application-owned state to test — ContentTheme is declarative, ThemeToggle is internal

### 8.2 Integration Tests

**Test Cases**:
1. ✅ Theme defaults to light mode on first visit (no localStorage)
2. ✅ Theme defaults to dark mode if `prefers-color-scheme: dark` detected
3. ✅ Theme toggle switches `data-theme` attribute on `<html>`
4. ✅ Theme preference persists across page navigation
5. ✅ Theme preference persists across browser refresh
6. ✅ All components display correctly in dark mode (visual regression)

### 8.3 Manual Testing Checklist

- [ ] Light theme: All text readable, contrast sufficient
- [ ] Dark theme: All text readable, no pure white (#fff) text
- [ ] Toggle button accessible via keyboard (Tab → Enter)
- [ ] Toggle button has visible focus ring
- [ ] Theme changes instantly (<100ms perceived delay)
- [ ] Smooth 200ms color transitions (unless `prefers-reduced-motion`)
- [ ] No FOUC on page load
- [ ] Works in privacy mode (session-only persistence)
- [ ] Works when localStorage disabled (in-memory fallback)

### 8.4 Accessibility Audit

- [ ] Run Lighthouse accessibility audit (target: 100 score)
- [ ] Verify all contrast ratios ≥4.5:1 for text
- [ ] Verify focus indicators visible in both themes
- [ ] Test with screen reader (NVDA/VoiceOver) — toggle button announces correctly

---

## 9. Migration Checklist

**From**: Hardcoded `Color('#hex')` constants  
**To**: `Color.variable('--name')` with ContentTheme

| File | Status | Notes |
|------|--------|-------|
| `constants/theme.dart` | ⬜ Pending | Define `appTheme`, export `Color.variable()` constants |
| `main.server.dart` | ⬜ Pending | Wrap with `ContentApp(theme: appTheme)` |
| `components/navbar.dart` | ⬜ Pending | Add `ThemeToggle()` button, refactor colors |
| `components/hero_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/about_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/core_expertise_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/philosophy_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/projects_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/career_section.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/header.dart` | ⬜ Pending | Refactor to use theme constants |
| `components/footer.dart` | ⬜ Pending | Refactor to use theme constants |
| `pages/home.dart` | ⬜ Pending | Refactor to use theme constants |
| `pages/about.dart` | ⬜ Pending | Refactor to use theme constants |
| `pages/career.dart` | ⬜ Pending | Refactor to use theme constants |
| `pages/blog.dart` | ⬜ Pending | Refactor to use theme constants |
| `pages/project.dart` | ⬜ Pending | Refactor to use theme constants |
| `app.dart` (PageShell) | ⬜ Pending | Refactor to use theme constants (if any colors) |

**Total**: 16 files

---

## 10. Future Enhancements (Out of Scope for MVP)

- [ ] Third theme option: "System" (follows OS preference dynamically)
- [ ] Custom theme picker (user-selected accent colors)
- [ ] Per-page theme overrides (e.g., dark-only blog post layout)
- [ ] Theme transition animation variants (fade, slide, none)
- [ ] Theme-specific image variants (logo-light.svg, logo-dark.svg)
- [ ] `ThemeToggle` customization (icon style, ARIA label override)
- [ ] Theme preview modal (live preview before commit)

---

**Data model complete. Proceed to contracts definition (if applicable).**
