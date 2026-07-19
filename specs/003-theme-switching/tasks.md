# Tasks: Dark/Light Theme Switching

**Feature**: 003-theme-switching  
**Branch**: `003-theme-switching`  
**Input**: Design documents from `/specs/003-theme-switching/`

**Prerequisites**: plan.md, spec.md, data-model.md, research.md, contracts/, quickstart.md

**Tests**: No automated tests requested - manual visual testing and Lighthouse audit only

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Theme system foundation setup

- [ ] T001 Create ContentTheme configuration with all 19 Lumina color tokens in lib/constants/theme.dart
- [ ] T002 Verify jaspr_content ^0.5.3+1 is in pubspec.yaml dependencies (already added in 002-content-setup)
- [ ] T003 Add reduced motion CSS media query support in global styles

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core theme infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Integrate ContentApp wrapper with appTheme in lib/main.server.dart
- [ ] T005 Update lib/main.client.dart to ensure theme hydration works correctly
- [ ] T006 Verify SSR pre-renders light theme by default with `jaspr build` test
- [ ] T007 Test localStorage persistence mechanism with browser DevTools
- [ ] T008 Validate WCAG AA contrast ratios for all light theme color pairs using WebAIM
- [ ] T009 Validate WCAG AA contrast ratios for all dark theme color pairs using WebAIM

**Checkpoint**: Foundation ready - theme system functional, user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - User Toggles Between Light and Dark Themes (Priority: P1) 🎯 MVP

**Goal**: Enable users to toggle between light and dark themes using a visible control in the navbar, with preference persistence across sessions

**Independent Test**: Click theme toggle button in navbar → theme switches immediately → navigate to different page → theme persists → close/reopen browser → theme still persists

### Implementation for User Story 1

- [ ] T010 [US1] Import ThemeToggle component and add to Navbar component in lib/components/navbar.dart
- [ ] T011 [P] [US1] Refactor HeroSection component colors to use theme constants in lib/components/hero_section.dart
- [ ] T012 [P] [US1] Refactor AboutSection component colors to use theme constants in lib/components/about_section.dart
- [ ] T013 [P] [US1] Refactor CoreExpertiseSection component colors to use theme constants in lib/components/core_expertise_section.dart
- [ ] T014 [P] [US1] Refactor PhilosophySection component colors to use theme constants in lib/components/philosophy_section.dart
- [ ] T015 [P] [US1] Refactor ProjectsSection component colors to use theme constants in lib/components/projects_section.dart
- [ ] T016 [P] [US1] Refactor CareerSection component colors to use theme constants in lib/components/career_section.dart
- [ ] T017 [P] [US1] Refactor Header component colors to use theme constants in lib/components/header.dart
- [ ] T018 [P] [US1] Refactor Footer component colors to use theme constants in lib/components/footer.dart
- [ ] T019 [P] [US1] Refactor Home page colors (if any hardcoded) in lib/pages/home.dart
- [ ] T020 [P] [US1] Refactor About page colors (if any hardcoded) in lib/pages/about.dart
- [ ] T021 [P] [US1] Refactor Career page colors (if any hardcoded) in lib/pages/career.dart
- [ ] T022 [P] [US1] Refactor Blog page colors (if any hardcoded) in lib/pages/blog.dart
- [ ] T023 [P] [US1] Refactor Project page colors (if any hardcoded) in lib/pages/project.dart
- [ ] T024 [US1] Update App shell (PageShell) to ensure theme context is available in lib/app.dart
- [ ] T025 [US1] Test theme toggle in light mode → dark mode transition with visual verification
- [ ] T026 [US1] Test theme toggle in dark mode → light mode transition with visual verification
- [ ] T027 [US1] Test theme persistence across page navigation (/career, /blog, /about)
- [ ] T028 [US1] Test theme persistence across browser session (close and reopen)
- [ ] T029 [US1] Test system preference detection on first visit (prefers-color-scheme: dark)
- [ ] T030 [US1] Test localStorage fallback when disabled (privacy mode)

**Checkpoint**: At this point, User Story 1 should be fully functional - users can toggle themes, preference persists, all components display correctly in both themes

---

## Phase 4: User Story 2 - Generalized Theme System Architecture (Priority: P2)

**Goal**: Ensure theme system is maintainable and scalable - all color tokens organized, components consume theme reactively, adding new themes doesn't require component changes

**Independent Test**: Verify all hardcoded Color('#hex') removed from components → attempt to define a third theme variant (e.g., high contrast) → confirm only token values need changing, no component code touched

### Implementation for User Story 2

- [ ] T031 [P] [US2] Audit all component @css blocks for remaining hardcoded Color('#hex') values using grep
- [ ] T032 [P] [US2] Document all 19 color tokens with semantic meaning in lib/constants/theme.dart comments
- [ ] T033 [US2] Create theme architecture documentation in specs/003-theme-switching/ARCHITECTURE.md
- [ ] T034 [US2] Verify CSS custom properties are generated correctly in browser DevTools Elements panel
- [ ] T035 [US2] Test that changing a ThemeColor value in theme.dart immediately updates all consuming components
- [ ] T036 [US2] Validate all components use semantic token names (e.g., surfaceContainer, not hardcoded values)
- [ ] T037 [US2] Run `jaspr build` and verify generated CSS includes :root[data-theme="dark"] overrides
- [ ] T038 [US2] Measure bundle size impact (should be <5 KB gzipped per SC-007 requirement)

**Checkpoint**: At this point, theme system is fully generalized - no hardcoded colors, all components theme-aware, architecture documented

---

## Phase 5: User Story 3 - Accessible and Performant Theme Transitions (Priority: P3)

**Goal**: Ensure theme transitions are smooth but respect reduced motion preferences, no visual jarring or accessibility violations

**Independent Test**: Enable prefers-reduced-motion in browser DevTools → toggle theme → verify instant change (no animation) → disable reduced-motion → toggle theme → verify smooth 200-300ms transition

### Implementation for User Story 3

- [ ] T039 [P] [US3] Implement CSS transition rules for color properties (200ms ease) in lib/constants/theme.dart
- [ ] T040 [US3] Add prefers-reduced-motion media query to override transitions in lib/constants/theme.dart
- [ ] T041 [US3] Test theme toggle with prefers-reduced-motion: reduce enabled (should be instant)
- [ ] T042 [US3] Test theme toggle with prefers-reduced-motion disabled (should transition smoothly)
- [ ] T043 [US3] Verify no flash of unstyled content (FOUC) during theme change
- [ ] T044 [US3] Test theme toggle response time (<100ms per SC-002 requirement) using browser Performance tab
- [ ] T045 [US3] Verify no layout shift (CLS = 0) during theme change using Lighthouse
- [ ] T046 [US3] Test rapid theme toggling (multiple clicks in quick succession) - should not freeze UI

**Checkpoint**: All user stories complete - theme system is fully functional, accessible, and performant

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final quality checks and documentation

- [ ] T047 [P] Add custom :focus-visible style for ThemeToggle button in lib/components/navbar.dart
- [ ] T048 [P] Update .github/copilot-instructions.md to reference 003-theme-switching feature plan
- [ ] T049 Run Lighthouse accessibility audit on all pages (target: 100 score, WCAG AA compliance)
- [ ] T050 Test theme system on Firefox, Chrome, Safari, Edge browsers
- [ ] T051 Test theme system on mobile viewport sizes (responsive behavior)
- [ ] T052 Verify all typography classes (.t-display, .t-headline, etc.) inherit theme colors correctly
- [ ] T053 Run specs/003-theme-switching/quickstart.md validation scenarios
- [ ] T054 Final visual regression test: screenshot compare light vs dark for all pages
- [ ] T055 Update README.md with theme switching feature mention (if applicable)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - User Story 1: Can start after Foundational - No dependencies on other stories
  - User Story 2: Can start after Foundational - Depends on User Story 1 implementation for audit
  - User Story 3: Can start after Foundational - Independent of US1/US2, but transitions apply to already refactored components
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Requires Foundational (Phase 2) complete - No dependencies on other stories (can be MVP)
- **User Story 2 (P2)**: Requires US1 complete (needs refactored components to audit) - No dependencies on US3
- **User Story 3 (P3)**: Requires US1 complete (transitions apply to theme-aware components) - Independent of US2

### Within Each User Story

**User Story 1**:
- T010 (ThemeToggle in Navbar) must complete before testing (T025-T030)
- T011-T024 (component refactoring) can all run in parallel [P]
- T025-T030 (testing) must wait for all refactoring to complete

**User Story 2**:
- T031 (audit) must complete first to identify remaining hardcoded values
- T032-T033 (documentation) can run in parallel [P]
- T034-T038 (validation) must wait for any fixes from audit

**User Story 3**:
- T039-T040 (CSS transitions) can run in parallel [P]
- T041-T046 (testing) must wait for transition code to be added

### Parallel Opportunities

- **Phase 1**: T001-T003 (all Setup) are mostly sequential (T001 creates file, T002 verifies, T003 modifies)
- **Phase 2**: T008-T009 (WCAG validation) can run in parallel [P] after T004-T007 complete
- **Phase 3 (US1)**: T011-T023 (13 component refactors) can all run in parallel [P] - MAJOR parallelization opportunity
- **Phase 4 (US2)**: T031-T032 can run in parallel [P]
- **Phase 5 (US3)**: T039-T040 can run in parallel [P]
- **Phase 6**: T047-T048 can run in parallel [P]

---

## Parallel Example: User Story 1 Component Refactoring

**Maximum parallelization scenario** (13 developers working simultaneously):

```bash
# All component refactors can happen at the same time (different files):
Developer A: "Refactor HeroSection colors in lib/components/hero_section.dart"
Developer B: "Refactor AboutSection colors in lib/components/about_section.dart"
Developer C: "Refactor CoreExpertiseSection colors in lib/components/core_expertise_section.dart"
Developer D: "Refactor PhilosophySection colors in lib/components/philosophy_section.dart"
Developer E: "Refactor ProjectsSection colors in lib/components/projects_section.dart"
Developer F: "Refactor CareerSection colors in lib/components/career_section.dart"
Developer G: "Refactor Header colors in lib/components/header.dart"
Developer H: "Refactor Footer colors in lib/components/footer.dart"
Developer I: "Refactor Home page colors in lib/pages/home.dart"
Developer J: "Refactor About page colors in lib/pages/about.dart"
Developer K: "Refactor Career page colors in lib/pages/career.dart"
Developer L: "Refactor Blog page colors in lib/pages/blog.dart"
Developer M: "Refactor Project page colors in lib/pages/project.dart"
```

**Realistic scenario** (1-2 developers):

```bash
# Batch component refactors together:
Session 1: T011-T013 (HeroSection, AboutSection, CoreExpertiseSection)
Session 2: T014-T016 (PhilosophySection, ProjectsSection, CareerSection)
Session 3: T017-T018 (Header, Footer)
Session 4: T019-T023 (All pages)
Session 5: T010, T024 (ThemeToggle integration and App shell)
Session 6: T025-T030 (All testing)
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001-T003) → ~30 minutes
2. Complete Phase 2: Foundational (T004-T009) → ~1 hour (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (T010-T030) → ~4 hours
4. **STOP and VALIDATE**: Test theme toggle works, preference persists, all pages look correct in both themes
5. Deploy/demo if ready (this is the MVP!)

**Total MVP time**: ~5.5 hours (single developer)

---

### Incremental Delivery

1. **Sprint 1**: Setup + Foundational → Foundation ready (~1.5 hours)
2. **Sprint 2**: User Story 1 → Test independently → Deploy/Demo (~4 hours) **← MVP complete!**
3. **Sprint 3**: User Story 2 → Validate architecture → Deploy/Demo (~2 hours)
4. **Sprint 4**: User Story 3 → Accessibility polish → Deploy/Demo (~2 hours)
5. **Sprint 5**: Polish → Final quality checks (~1.5 hours)

**Total feature time**: ~11 hours (single developer, sequential)

---

### Parallel Team Strategy

**With 3 developers** (after Foundational phase):

1. **Team completes Setup + Foundational together** (~1.5 hours)
2. **Once Foundational is done**:
   - Developer A: User Story 1 tasks T010-T015 (~2 hours)
   - Developer B: User Story 1 tasks T016-T020 (~2 hours)
   - Developer C: User Story 1 tasks T021-T024 (~2 hours)
3. **Reconvene**: Run US1 tests T025-T030 together (~1 hour)
4. **Split again**:
   - Developer A: User Story 2 (~2 hours)
   - Developer B: User Story 3 (~2 hours)
   - Developer C: Polish Phase 6 prep (~2 hours)
5. **Final polish**: All together (~0.5 hours)

**Total feature time**: ~6 hours (3 developers, parallel)

---

## Success Metrics (Completion Checklist)

### Functional Requirements Met

- ✅ **FR-001**: ContentTheme API used for light/dark theme config
- ✅ **FR-002**: All 19 Lumina colors defined with ThemeColor(light, dark)
- ✅ **FR-003**: ThemeToggle component integrated in Navbar
- ✅ **FR-004**: System preference detection works (prefers-color-scheme)
- ✅ **FR-005**: Theme persists to localStorage
- ✅ **FR-006**: Theme survives navigation, refresh, new sessions
- ✅ **FR-007**: All 19 components refactored (9 components + 5 pages + 1 app shell + 1 navbar + theme file)
- ✅ **FR-008**: ThemeToggle is keyboard accessible
- ✅ **FR-009**: Smooth transitions (200-300ms) unless reduced motion
- ✅ **FR-010**: WCAG AA contrast ratios validated
- ✅ **FR-011**: theme.dart exports ContentTheme instance
- ✅ **FR-012**: Lumina visual identity preserved in both themes
- ✅ **FR-013**: Static build defaults to light theme
- ✅ **FR-014**: localStorage fallback to in-memory state
- ✅ **FR-015**: @css styles use CSS custom properties

### Success Criteria Met

- ✅ **SC-001**: Theme toggle + persistence works in 100% browsers with localStorage
- ✅ **SC-002**: Theme change completes in <100ms
- ✅ **SC-003**: All components display correctly in both themes (WCAG AA)
- ✅ **SC-004**: Zero hardcoded color values in components
- ✅ **SC-005**: ThemeToggle keyboard accessible (WCAG 2.1 AA)
- ✅ **SC-006**: `jaspr build` succeeds, pre-renders light theme
- ✅ **SC-007**: Bundle size increase <5 KB gzipped

### Quality Gates

- ✅ All 55 tasks completed (T001-T055)
- ✅ No hardcoded Color('#hex') values in components (grep verification)
- ✅ Lighthouse accessibility score: 100 (all pages)
- ✅ Manual testing passed on Firefox, Chrome, Safari, Edge
- ✅ Mobile responsive behavior verified
- ✅ quickstart.md scenarios validated
- ✅ Documentation updated (.github/copilot-instructions.md, README.md)

---

## Notes

- **[P] tasks**: Different files, no dependencies - can run in parallel
- **[Story] label**: Maps task to specific user story (US1, US2, US3) for traceability
- **No automated tests**: Spec does not request TDD approach, so no test tasks included (manual testing + Lighthouse only)
- **Component count**: 16 files to refactor (spec plan.md lists 9 components + 5 pages + 1 app shell + 1 theme file = 16 total, but we add Navbar integration separately = 17 total modified files)
- **Parallel opportunities**: 13 component refactors (T011-T023) are the biggest parallelization win
- **Critical path**: Foundational phase (T004-T009) blocks ALL user stories - must complete first
- **MVP scope**: User Story 1 only (Phase 1 + Phase 2 + Phase 3) = fully functional theme toggle
- **Incremental delivery**: Each user story adds value without breaking previous stories
- **Testing approach**: Manual visual testing + browser DevTools + Lighthouse audit (no jaspr_test unit tests)
- **WCAG compliance**: Validated in Phase 2 before component refactoring begins

---

## Edge Cases Addressed

- ✅ localStorage disabled/blocked (T030) → fallback tested
- ✅ prefers-color-scheme unsupported browsers → defaults to light (graceful degradation)
- ✅ Rapid theme toggling (T046) → debouncing not needed (CSS handles state, no race conditions)
- ✅ Theme-specific images/logos → not applicable (no image variants needed per spec)
- ✅ SSR/SSG pre-render theme (T006) → verified light theme default
- ✅ Mobile vs desktop ThemeToggle appearance → jaspr_content handles responsive icon

---

## Done When

- [ ] All 55 tasks (T001-T055) completed and checked off
- [ ] tasks.md generated with all phases, task IDs, file paths, and story labels
- [ ] Completion reported with task count, story breakdown, and MVP scope
- [ ] Extension hooks dispatched (optional after_tasks hook for git commit)
