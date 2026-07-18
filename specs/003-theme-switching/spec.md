# Feature Specification: Dark/Light Theme Switching with State Management

**Feature Branch**: `003-theme-switching`

**Created**: 2026-07-18

**Status**: Draft

**Input**: Implement a comprehensive dark/light theme system with user-controlled toggle, using jaspr_riverpod for state management, persistent theme preference storage, and smooth visual transitions between themes while maintaining brand identity and accessibility standards.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - User Toggles Between Light and Dark Themes (Priority: P1)

As a site visitor, I want to toggle between light and dark themes using a visible control in the navigation bar, so I can choose my preferred reading experience based on ambient lighting or personal preference.

**Why this priority**: Theme switching is a modern UX expectation that improves accessibility and user comfort. This is the core value proposition and introduces jaspr_riverpod for state management as documented in the constitution.

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

1. **Given** a theme object is defined, **When** a developer inspects the theme structure, **Then** all color tokens, typography, and spacing are organized hierarchically
2. **Given** components reference theme values, **When** the theme changes, **Then** components re-render with new theme values automatically via Riverpod reactivity
3. **Given** a developer wants to add a third theme (e.g., "high contrast"), **When** they define new theme tokens, **Then** the theme can be activated without modifying component code
4. **Given** CSS is generated, **When** the build completes, **Then** theme-aware CSS classes or custom properties support dynamic theme switching

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

- **FR-001**: System MUST introduce jaspr_riverpod for managing global theme state
- **FR-002**: System MUST define a `ThemeData` model containing all color tokens, typography, and spacing values
- **FR-003**: System MUST create separate `lightTheme` and `darkTheme` configurations with complete token definitions
- **FR-004**: System MUST create a Riverpod `ThemeNotifier` (StateNotifier or similar) managing current theme state
- **FR-005**: System MUST provide a `themeProvider` that components can watch for reactive theme updates
- **FR-006**: Theme system MUST detect system preference using `prefers-color-scheme` media query on first visit
- **FR-007**: Theme system MUST persist user's explicit theme choice to browser localStorage
- **FR-008**: Theme preference MUST survive page navigation, browser refresh, and new sessions
- **FR-009**: System MUST add a theme toggle button to the Navbar component
- **FR-010**: Theme toggle button MUST display current theme state (sun icon for light, moon for dark, or similar)
- **FR-011**: Theme toggle MUST be accessible (proper ARIA labels, keyboard navigable, visible focus state)
- **FR-012**: All components MUST be refactored to consume theme values from ThemeProvider instead of hardcoded constants
- **FR-013**: Color transitions MUST be smooth (200-300ms) unless `prefers-reduced-motion: reduce` is detected
- **FR-014**: Dark theme MUST maintain WCAG AA contrast ratios for text and interactive elements
- **FR-015**: System MUST update `constants/theme.dart` to export theme objects instead of individual color constants
- **FR-016**: System MUST preserve existing Lumina design system visual identity across both themes
- **FR-017**: System MUST wrap the app in `ProviderScope` for Riverpod initialization
- **FR-018**: Static build MUST default to light theme for pre-rendered HTML (hydration applies user preference)
- **FR-019**: If localStorage is unavailable, system MUST fall back to in-memory state (session-only persistence)
- **FR-020**: Components referencing `@css` styles MUST either use CSS custom properties or rebuild styles reactively

### Key Entities *(include if feature involves data)*

- **ThemeData**: Immutable model containing all design tokens (colors, typography, spacing, border radii, shadows)
- **ThemeMode**: Enum representing theme state - `light`, `dark`, or `system` (follows OS preference)
- **ThemeNotifier**: Riverpod StateNotifier managing current ThemeMode and persisting to localStorage
- **ThemeProvider**: Riverpod provider exposing current ThemeData based on active ThemeMode
- **ThemeToggle**: Component in Navbar allowing user to cycle through theme modes

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: User can toggle between light and dark themes, with preference persisting across sessions in 100% of browsers with localStorage support
- **SC-002**: Theme change completes in <100ms (state update + component re-render) for perceived instant responsiveness
- **SC-003**: All 19 components (pages + components) display correctly in both light and dark themes with WCAG AA contrast ratios
- **SC-004**: Zero hardcoded color values remain in component files after refactoring (all colors from ThemeData)
- **SC-005**: Theme toggle is keyboard accessible and navigable with visible focus states meeting WCAG 2.1 AA standards
- **SC-006**: `jaspr build` completes successfully with theme system enabled, and static HTML pre-renders with default light theme
- **SC-007**: Bundle size increases by <15 KB (gzipped) after adding jaspr_riverpod and theme system

## Assumptions

- jaspr_riverpod `^0.4.6` is compatible with Jaspr `^0.23.1` and works in static mode
- Riverpod providers can be used in static site generation without server-side runtime
- Client-side hydration applies Riverpod providers and restores theme preference from localStorage
- localStorage is available in 99%+ of target browsers (graceful degradation for remaining 1%)
- System preference detection via `prefers-color-scheme` is widely supported
- Users expect instant theme toggle response (no loading spinners or delays)
- Dark theme uses inverted color palette (dark backgrounds, light text) while preserving brand colors
- Existing `constants/theme.dart` can be refactored to theme objects without breaking existing components (gradual migration acceptable)
- CSS-in-Dart (`@css`) styles may need refactoring to support reactive theme values
- Theme toggle icon can use Material Symbols already loaded in the project
- No third-party theme switcher libraries needed (implement using Riverpod primitives)
