# Feature Specification: Dark/Light Theme Switching with State Management

**Feature Branch**: `003-theme-switching`

**Created**: 2026-07-18

**Status**: Draft

**Input**: Implement a comprehensive dark/light theme system with user-controlled toggle, using jaspr_content's built-in ContentTheme and ThemeToggle component, persistent theme preference storage, and smooth visual transitions between themes while maintaining brand identity and accessibility standards.

## Clarifications

### Session 2026-07-18

- Q: Should we use ContentTheme with ThemeColor for light/dark variants instead of implementing a custom ThemeData model with jaspr_riverpod? → A: Use jaspr_content ContentTheme with built-in ThemeColor system (no custom ThemeData model needed)
- Q: Should we use jaspr_content's built-in `<ThemeToggle>` component directly in the Navbar, or create a custom styled theme toggle that matches the Lumina design system? → A: Use jaspr_content's built-in ThemeToggle component directly (fastest, accessible by default)
- Q: Should we refactor all components to use ContentTheme CSS custom properties, or migrate incrementally? → A: Refactor all 19 components in one pass (complete but higher risk)
- Q: For the dark theme, should we use inverted Lumina colors or create a custom dark color palette with adjusted saturation/brightness for better readability? → A: Custom dark palette with adjusted colors
- Q: Where should we define the ContentTheme instance - in constants/theme.dart and import it, or inline in main.server.dart? → A: Define ContentTheme in constants/theme.dart and import in main.server.dart
- Q: For the dark theme, should we use inverted Lumina colors or create a custom dark color palette with adjusted saturation/brightness for better readability? → A: Custom dark palette with adjusted colors

## User Scenarios & Testing *(mandatory)*

### User Story 1 - User Toggles Between Light and Dark Themes (Priority: P1)

As a site visitor, I want to toggle between light and dark themes using a visible control in the navigation bar, so I can choose my preferred reading experience based on ambient lighting or personal preference.

**Why this priority**: Theme switching is a modern UX expectation that improves accessibility and user comfort. This is the core value proposition leveraging jaspr_content's built-in theming system already integrated in the project.

**Independent Test**: Can be fully tested by clicking the theme toggle button in the navbar, verifying the theme changes immediately across all pages, and confirming the preference persists across page navigation and browser sessions.

**Acceptance Scenarios**:

1. **Given** the user is on light theme, **When** they click the theme toggle button in the navbar, **Then** the entire site switches to dark theme immediately with smooth transition
2. **Given** the user is on dark theme, **When** they click the theme toggle button, **Then** the site switches to light theme immediately
3. **Given** the user has selected dark theme, **When** they navigate to a different page (/career, /blog), **Then** the dark theme persists across navigation
4. **Given** the user has selected a theme preference, **When** they close and reopen the browser, **Then** their theme choice is remembered via localStorage
5. **Given** the user has not selected a theme, **When** they first visit the site, **Then** the theme defaults to their system preference (prefers-color-scheme media query)

---

### User Story 2 - Generalized Theme System Architecture (Priority: P2)

As a developer, I need a scalable theme system that separates theme tokens from hardcoded colors, so future theme customization or additional theme variants can be added without refactoring components.

**Why this priority**: The current codebase has hardcoded color values in `constants/theme.dart`. Generalizing the theme system enables maintainability, supports multiple themes beyond light/dark, and follows modern design token patterns.

**Independent Test**: Can be tested by verifying that all color constants are organized into theme objects, components consume theme values reactively, and adding a new theme variant requires only defining new token values without touching component code.

**Acceptance Scenarios**:

1. **Given** a ContentTheme is defined with ThemeColor tokens, **When** a developer inspects the theme structure, **Then** all color tokens, typography, and spacing are organized using jaspr_content's ContentTheme API
2. **Given** components reference theme values via CSS variables, **When** the theme changes, **Then** components update automatically using jaspr_content's built-in theme reactivity
3. **Given** a developer wants to add a third theme (e.g., "high contrast"), **When** they define new ContentTheme instance with custom ColorToken values, **Then** the theme can be activated by extending jaspr_content's theming system
4. **Given** CSS is generated, **When** the build completes, **Then** theme-aware CSS custom properties (--primary, --background, etc.) support dynamic theme switching

---

### User Story 3 - Accessible and Performant Theme Transitions (Priority: P3)

As a user with visual sensitivities or motion preferences, I need theme transitions to be smooth but not jarring, and respect my system-level reduced motion preferences.

**Why this priority**: Accessibility is a constitutional requirement. Smooth transitions enhance perceived quality, but must respect user preferences to avoid discomfort or accessibility violations.

**Independent Test**: Can be tested by toggling the theme with browser DevTools set to `prefers-reduced-motion: reduce`, verifying instant theme change without transition animation. With motion enabled, verify smooth 200-300ms fade transition.

**Acceptance Scenarios**:

1. **Given** the user has enabled reduced motion in their OS/browser, **When** they toggle the theme, **Then** the theme changes instantly without transition animation
2. **Given** the user has not disabled motion, **When** they toggle the theme, **Then** colors transition smoothly over 200-300ms with appropriate easing
3. **Given** the theme is changing, **When** the transition occurs, **Then** no flash of unstyled content (FOUC) or white/black flicker appears
4. **Given** the theme toggle button is clicked, **When** the state updates, **Then** the UI remains responsive (no janky freezing during transition)

---

### Edge Cases

- What happens if localStorage is disabled or blocked (privacy mode)?
- How does the system handle `prefers-color-scheme` detection in browsers that don't support it (very old browsers)?
- What occurs if a user rapidly toggles the theme multiple times (debouncing needed)?
- How are images, logos, or illustrations with theme-specific variants handled?
- What happens to CSS-in-Dart `@css` styles that reference color constants directly?
- How does the theme toggle appear on mobile vs desktop (icon vs text label)?
- What happens during SSR/SSG build - which theme is pre-rendered?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST use jaspr_content's ContentTheme API for defining light and dark theme configurations
- **FR-002**: System MUST define a ContentTheme instance with all Lumina design system colors using ThemeColor(lightValue, dark: darkValue) pattern, where dark values are custom-adjusted for readability (desaturated colors, reduced brightness, proper contrast)
- **FR-003**: System MUST use jaspr_content's built-in ThemeToggle component in the Navbar for theme switching
- **FR-004**: Theme system MUST detect system preference using jaspr_content's built-in `prefers-color-scheme` detection on first visit
- **FR-005**: Theme system MUST persist user's explicit theme choice to browser localStorage using jaspr_content's theme persistence
- **FR-006**: Theme preference MUST survive page navigation, browser refresh, and new sessions
- **FR-007**: All 19 components MUST be refactored in one pass to consume theme values from ContentTheme CSS custom properties instead of hardcoded constants
- **FR-008**: Theme toggle MUST be accessible (proper ARIA labels, keyboard navigable, visible focus state) per jaspr_content's ThemeToggle implementation
- **FR-009**: Color transitions MUST be smooth (200-300ms) unless `prefers-reduced-motion: reduce` is detected
- **FR-010**: Dark theme MUST maintain WCAG AA contrast ratios for text and interactive elements
- **FR-011**: System MUST refactor `constants/theme.dart` to export ContentTheme instance (appTheme) instead of individual color constants, maintaining theme.dart as design system source of truth
- **FR-012**: System MUST preserve existing Lumina design system visual identity across both themes
- **FR-013**: Static build MUST default to light theme for pre-rendered HTML (jaspr_content hydration applies user preference)
- **FR-014**: If localStorage is unavailable, jaspr_content MUST fall back to in-memory state (session-only persistence)
- **FR-015**: Components referencing `@css` styles MUST use CSS custom properties generated by ContentTheme's ColorToken system

### Key Entities *(include if feature involves data)*

- **ContentTheme**: jaspr_content's immutable theme model containing all design tokens (colors, typography, spacing defined via ThemeColor)
- **ThemeColor**: jaspr_content class representing a color with light and dark variants (e.g., `ThemeColor(Colors.white, dark: Color('#0b0d0e'))`)
- **ColorToken**: jaspr_content's CSS variable generator for custom theme tokens
- **ThemeToggle**: Built-in jaspr_content component for switching between light and dark modes
- **ContentColors**: Predefined color tokens for content elements (quotes, code blocks, tables, etc.)

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: User can toggle between light and dark themes, with preference persisting across sessions in 100% of browsers with localStorage support
- **SC-002**: Theme change completes in <100ms (state update + component re-render) for perceived instant responsiveness
- **SC-003**: All 19 components (pages + components) display correctly in both light and dark themes with WCAG AA contrast ratios
- **SC-004**: Zero hardcoded color values remain in component files after refactoring (all colors from ContentTheme CSS custom properties)
- **SC-005**: Theme toggle is keyboard accessible and navigable with visible focus states meeting WCAG 2.1 AA standards
- **SC-006**: `jaspr build` completes successfully with theme system enabled, and static HTML pre-renders with default light theme
- **SC-007**: Bundle size increases by <5 KB (gzipped) after implementing jaspr_content theming (no additional packages needed)

## Assumptions

- jaspr_content `^0.5.3` provides ContentTheme and ThemeToggle components already integrated in 002-content-setup
- ContentTheme's ThemeColor system auto-generates CSS custom properties for light/dark themes
- jaspr_content's built-in theme persistence uses localStorage and handles graceful degradation
- System preference detection via `prefers-color-scheme` is built into jaspr_content's theming
- Users expect instant theme toggle response (no loading spinners or delays)
- Dark theme uses custom color palette with adjusted saturation/brightness for readability (not pure color inversion)
- Existing `constants/theme.dart` will be refactored to export ContentTheme instance (appTheme) and imported in main.server.dart
- CSS-in-Dart (`@css`) styles can reference CSS custom properties generated by ContentTheme ColorTokens
- ThemeToggle component provides accessible sun/moon icon toggle by default
- No additional packages needed beyond jaspr_content already in dependencies
