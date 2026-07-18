# Quick Start: Theme Integration Guide

**Feature**: 003-theme-switching  
**Audience**: Developers integrating theme-aware components  
**Time to implement**: ~5 minutes per component  
**Last updated**: 2026-07-18

## TL;DR

```dart
// 1. Import theme constants
import '../constants/theme.dart';

// 2. Use in your component styles
@css
static List<StyleRule> get styles => [
  css('.my-component').styles(
    backgroundColor: surfaceContainer,  // ← Auto light/dark
    color: onSurface,                   // ← Auto light/dark
    borderColor: outlineVariant,        // ← Auto light/dark
  ),
];

// 3. Done! Component now supports light/dark themes
```

---

## Prerequisites

**✅ Complete** (already in project):
- `jaspr: ^0.23.1` in `pubspec.yaml`
- `jaspr_content: ^0.5.3+1` in `pubspec.yaml`
- `constants/theme.dart` defines `appTheme` and color constants
- `main.server.dart` wraps app with `ContentApp(theme: appTheme)`
- `ThemeToggle()` component added to `Navbar`

**If missing** any of the above, see [full implementation guide](./plan.md).

---

## 1. Basic Component Integration (Most Common)

### Scenario: Component uses hardcoded colors

**Before** (hardcoded):
```dart
import 'package:jaspr/jaspr.dart';

class MyCard extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(classes: 'my-card', [
      h3([text('Card Title')]),
      p([text('Card content')]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.my-card').styles(
      backgroundColor: Color('#f0eee9'),    // ❌ Hardcoded
      color: Color('#1b1c19'),              // ❌ Hardcoded
      borderColor: Color('#c9c4d5'),        // ❌ Hardcoded
      padding: .all(1.rem),
      radius: BorderRadius.circular(12.px),
    ),
  ];
}
```

**After** (theme-aware):
```dart
import 'package:jaspr/jaspr.dart';
import '../constants/theme.dart';  // ← Step 1: Import theme

class MyCard extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(classes: 'my-card', [
      h3([text('Card Title')]),
      p([text('Card content')]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.my-card').styles(
      backgroundColor: surfaceContainer,   // ← Step 2: Use theme constant
      color: onSurface,                    // ← Step 2: Use theme constant
      borderColor: outlineVariant,         // ← Step 2: Use theme constant
      padding: .all(1.rem),                // ← Non-color properties unchanged
      radius: BorderRadius.circular(12.px),
    ),
  ];
}
```

**Result**: Component automatically switches colors when user toggles theme.

---

## 2. Available Color Constants

Import from `constants/theme.dart`:

### Backgrounds & Surfaces
```dart
bgColor                    // Page background (#fbf9f4 → #0b0d0e)
surfaceColor               // Surface base (#fbf9f4 → #1a1c1e)
surfaceContainerLowest     // Lowest elevation (#ffffff → #0f1113)
surfaceContainerLow        // Low elevation (#f5f3ee → #1f2225)
surfaceContainer           // Default card background (#f0eee9 → #22252a)
surfaceContainerHigh       // High elevation (#eae8e3 → #2c2f35)
surfaceContainerHighest    // Highest elevation (#e4e2dd → #36393f)
surfaceVariant             // Variant surfaces (#e4e2dd → #36393f)
```

### Brand Colors
```dart
primaryColor               // Primary brand color (#523fb9 → #c8bfff)
primaryContainer           // Primary container (#6b59d3 → #452fab)
onPrimary                  // Text on primary (#ffffff → #1a1c1e)
accentColor                // Accent (alias for primaryColor)
accentHoverColor           // Accent hover (#452fab → #b5a7ff)
primaryFixed               // Fixed primary (#e5deff → #2e2548)
onPrimaryFixedVariant      // Variant text on fixed (#452fab → #b5a7ff)
inversePrimary             // Inverse primary (#c8bfff → #523fb9)
```

### Text Colors
```dart
onSurface                  // Primary text (#1b1c19 → #e4e2dd)
onSurfaceVariant           // Secondary text (#484553 → #c9c4d5)
textPrimary                // Alias for onSurface
textSecondary              // Alias for onSurfaceVariant
inverseSurface             // Inverse surface (#30312e → #e4e2dd)
inverseOnSurface           // Inverse text (#f2f1ec → #1b1c19)
```

### Borders & Dividers
```dart
outlineColor               // Standard outline (#787585 → #8e8c99)
outlineVariant             // Subtle border (#c9c4d5 → #484553)
borderColor                // Alias for outlineVariant
```

### Secondary & Utility
```dart
secondaryContainer         // Secondary background (#d1e6f2 → #1f3a47)
onSecondaryContainer       // Text on secondary (#546771 → #b3d4e5)
tagBgColor                 // Tag background (#e5deff → #2e2548)
```

**Usage**:
```dart
import '../constants/theme.dart';

// All constants are ready to use:
css('.heading').styles(color: primaryColor);
css('.card').styles(backgroundColor: surfaceContainer);
css('.border').styles(borderColor: outlineVariant);
```

---

## 3. Advanced: Raw CSS Properties

For properties not supported by Jaspr's `.styles()` API, use `.value`:

```dart
import '../constants/theme.dart';

@css
static List<StyleRule> get styles => [
  css('.custom-shadow').styles(
    raw: {
      'box-shadow': '0 4px 20px ${outlineVariant.value}33',  // ← .value for interpolation
      'border': '2px solid ${primaryColor.value}',           // ← .value for interpolation
    },
  ),
];
```

**Explanation**:
- `outlineVariant` is a `Color` object
- `outlineVariant.value` returns `'var(--outline-variant)'`
- Jaspr emits: `box-shadow: 0 4px 20px var(--outline-variant)33;`

---

## 4. Typography & Non-Color Styles

**Typography classes** are already defined in `constants/theme.dart`:

```dart
// Usage in HTML:
h1(classes: 't-display', [text('Large Display Text')])
h2(classes: 't-headline', [text('Headline Text')])
h3(classes: 't-title', [text('Title Text')])
p(classes: 't-body-lg', [text('Large body text')])
p(classes: 't-body', [text('Regular body text')])
span(classes: 't-label', [text('Uppercase label')])
```

**Utility classes**:
```dart
div(classes: 'container', [...])       // Max-width centered container
div(classes: 'tonal-card', [...])      // Card with tonal background
span(classes: 'pulse-dot', [...])      // Pulsing status indicator
```

**These are NOT theme colors** — keep using them as-is. They inherit colors from parent elements.

---

## 5. Common Patterns

### Pattern 1: Card Component
```dart
@css
static List<StyleRule> get styles => [
  css('.card').styles(
    backgroundColor: surfaceContainer,      // ← Light surface
    color: onSurface,                       // ← Text color
    borderColor: outlineVariant,            // ← Subtle border
    border: Border.all(width: 1.px),
    radius: BorderRadius.circular(12.px),
    padding: .all(1.5.rem),
  ),
];
```

### Pattern 2: Button (Primary)
```dart
@css
static List<StyleRule> get styles => [
  css('.btn-primary').styles(
    backgroundColor: primaryColor,          // ← Brand color
    color: onPrimary,                       // ← White text on primary
    border: Border.unset,
    radius: BorderRadius.circular(8.px),
    padding: .symmetric(horizontal: 1.5.rem, vertical: 0.75.rem),
    cursor: Cursor.pointer,
  ),
  css('.btn-primary:hover').styles(
    backgroundColor: accentHoverColor,      // ← Darker hover state
  ),
];
```

### Pattern 3: Navbar
```dart
@css
static List<StyleRule> get styles => [
  css('.navbar').styles(
    backgroundColor: surfaceContainerLowest,  // ← Elevated white/dark surface
    borderColor: outlineVariant,              // ← Subtle bottom border
    borderBottom: Border(width: 1.px),
    padding: .symmetric(horizontal: 2.rem, vertical: 1.rem),
  ),
  css('.navbar a').styles(
    color: onSurfaceVariant,                  // ← Secondary text for links
  ),
  css('.navbar a:hover').styles(
    color: primaryColor,                      // ← Primary color on hover
  ),
];
```

### Pattern 4: Tag/Badge
```dart
@css
static List<StyleRule> get styles => [
  css('.tag').styles(
    backgroundColor: tagBgColor,              // ← Light purple background
    color: primaryColor,                      // ← Primary text color
    padding: .symmetric(horizontal: 0.75.rem, vertical: 0.25.rem),
    radius: BorderRadius.circular(4.px),
    fontSize: 12.px,
    fontWeight: .w500,
  ),
];
```

### Pattern 5: Footer
```dart
@css
static List<StyleRule> get styles => [
  css('.footer').styles(
    backgroundColor: surfaceVariant,          // ← Subtle variant surface
    color: onSurfaceVariant,                  // ← Secondary text
    borderColor: outlineVariant,
    borderTop: Border(width: 1.px),
    padding: .vertical(2.rem),
  ),
];
```

---

## 6. Testing Your Component

### Visual Check (Manual)

1. **Light theme**: Run `jaspr serve`, verify component looks correct
2. **Toggle to dark**: Click theme toggle button in navbar
3. **Verify**:
   - ✅ Background is dark (not light)
   - ✅ Text is light (readable on dark background)
   - ✅ No pure white (`#fff`) or pure black (`#000`) — use theme constants
   - ✅ Borders/dividers are visible (not too bright or too dark)

### Automated Test (Optional)

```dart
// my_card_test.dart
import 'package:jaspr_test/jaspr_test.dart';
import 'package:subhojit_build/components/my_card.dart';

void main() {
  testComponents('MyCard renders in light theme', (tester) async {
    await tester.pumpComponent(const MyCard());
    expect(find.text('Card Title'), findsOneComponent);
  });

  testComponents('MyCard renders in dark theme', (tester) async {
    // Simulate dark theme by setting data-theme attribute
    web.document.documentElement!.setAttribute('data-theme', 'dark');
    
    await tester.pumpComponent(const MyCard());
    expect(find.text('Card Title'), findsOneComponent);
    
    // Optional: verify CSS variables resolve correctly
    // (requires browser-based testing, not unit test)
  });
}
```

---

## 7. Troubleshooting

### Issue: Component still shows hardcoded colors after migration

**Cause**: Old color constant is still a `Color('#hex')` instead of `Color.variable('--name')`

**Fix**: Check `constants/theme.dart`:
```dart
// ❌ Wrong: Hardcoded color (bypasses theme)
const bgColor = Color('#fbf9f4');

// ✅ Correct: CSS variable reference (theme-aware)
final bgColor = Color.variable('--bg');
```

---

### Issue: Color is undefined (shows as transparent or default)

**Cause**: CSS variable name mismatch

**Example**:
```dart
// In theme.dart
ColorToken('background', ...)  // ← Token name: 'background'

// In component
final myBg = Color.variable('--bg');  // ❌ Mismatch: looking for '--bg', but token is '--background'
```

**Fix**: Match token name exactly:
```dart
final myBg = Color.variable('--background');  // ✅ Matches token
```

---

### Issue: Component looks wrong in dark mode (too bright/dark)

**Cause**: Using wrong semantic token

**Example**:
```dart
css('.card').styles(
  backgroundColor: surfaceContainerLowest,  // ← Pure white in light, very dark in dark
  color: onSurface,                         // ← Near-black in light, light-gray in dark
);
// Result: Very high contrast card in dark mode (jarring)
```

**Fix**: Use appropriate elevation:
```dart
css('.card').styles(
  backgroundColor: surfaceContainer,        // ← Mid-level surface (balanced contrast)
  color: onSurface,                         // ← Correct text color
);
```

**Rule of thumb**:
- **Low contrast** (subtle): `surfaceContainer`, `surfaceContainerLow`
- **High contrast** (prominent): `surfaceContainerHighest`, `primaryColor`

---

### Issue: Text is hard to read (insufficient contrast)

**Cause**: Using wrong text color for background

**Example**:
```dart
css('.card').styles(
  backgroundColor: primaryColor,           // ← Dark purple in light, light purple in dark
  color: onSurface,                        // ❌ Wrong: onSurface is for backgrounds, not primary
);
// Result: Dark text on dark background in light mode (unreadable)
```

**Fix**: Use correct "on-" prefix token:
```dart
css('.card').styles(
  backgroundColor: primaryColor,
  color: onPrimary,                        // ✅ Correct: white on dark primary (light), dark on light primary (dark)
);
```

**Rule**: Use matching "on-" token:
- `primaryColor` → `onPrimary`
- `surfaceContainer` → `onSurface`
- `secondaryContainer` → `onSecondaryContainer`

---

## 8. When to NOT Use Theme Constants

### Scenario 1: Decorative non-semantic colors

**Example**: Gradient background that's purely decorative (not part of brand)

```dart
css('.decorative-bg').styles(
  background: .linearGradient(
    angle: 45.deg,
    // ✅ OK to hardcode if not part of theme system
    stops: [
      (0.percent, Color('#ff6b6b')),
      (100.percent, Color('#4ecdc4')),
    ],
  ),
);
```

**Rationale**: If the gradient doesn't need to change between light/dark (e.g., it's a background image), hardcoding is fine.

### Scenario 2: Third-party component with fixed colors

**Example**: Syntax highlighter with specific color scheme

```dart
css('.code-block .keyword').styles(
  color: Color('#d73a49'),  // ✅ OK: GitHub syntax highlighting (fixed)
);
```

**Rationale**: If you're implementing a specific syntax theme (e.g., GitHub Light), don't force it to switch with the site theme.

### Scenario 3: Brand logo colors

**Example**: Logo with exact brand colors that must not change

```dart
css('.logo-icon').styles(
  fill: Color('#523fb9'),  // ✅ OK: Brand purple must be exact hex
);
```

**Rationale**: If brand guidelines specify exact colors, don't let theme system alter them.

---

## 9. Checklist: Migrating a Component

- [ ] Import `constants/theme.dart` at top of file
- [ ] Replace all `Color('#hex')` with corresponding theme constant
- [ ] Test in light theme (visually)
- [ ] Toggle to dark theme
- [ ] Verify text is readable (contrast sufficient)
- [ ] Verify borders/dividers are visible
- [ ] Verify hover states look correct
- [ ] Check responsive breakpoints (if applicable)
- [ ] Run `jaspr build` to ensure no errors
- [ ] (Optional) Write automated test for both themes

---

## 10. Resources

- **Full spec**: [spec.md](./spec.md)
- **Implementation plan**: [plan.md](./plan.md)
- **Data model**: [data-model.md](./data-model.md)
- **API contract**: [contracts/theme-api.md](./contracts/theme-api.md)
- **Research findings**: [research.md](./research.md)
- **jaspr_content docs**: https://docs.page/schultek/jaspr/concepts/theming
- **Contrast checker**: https://webaim.org/resources/contrastchecker/

---

## Questions?

**Common questions**:

**Q**: Can I add a new color constant?  
**A**: Yes, add a `ColorToken` to `appTheme.colors` in `constants/theme.dart`, then export a `Color.variable('--new-token')` constant.

**Q**: How do I override a color for one component only?  
**A**: Define a component-specific CSS variable in your `@css` block:
```dart
css('.my-component').styles(
  raw: {'--my-custom-bg': surfaceContainer.value},
  backgroundColor: Color.variable('--my-custom-bg'),
)
```

**Q**: Can I animate color changes slower/faster?  
**A**: Yes, override the transition in your component:
```dart
css('.slow-transition').styles(
  raw: {'transition': 'background-color 0.5s ease'},  // 500ms instead of 200ms
)
```

**Q**: Why does my component still show light colors in dark mode?  
**A**: Check `constants/theme.dart` — ensure the constant is `Color.variable('--name')` NOT `Color('#hex')`.

---

**Happy theming! 🎨**
