---
description: "Task list template for feature implementation"
---

# Tasks: Architecture Refactor

**Input**: Design documents from `specs/004-architecture-refactor/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Verify `jaspr_content` and dependencies are correctly added to `pubspec.yaml`
- [X] T002 Ensure `content/blog/`, `content/career/`, and `content/projects/` directories exist and are configured

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T003 [P] Create `Article` model in `lib/models/article.dart`
- [X] T004 [P] Create `JobExperience` model in `lib/models/job_experience.dart`
- [X] T005 [P] Create `Project` model in `lib/models/project.dart`

**Checkpoint**: Foundation ready - data models established

---

## Phase 3: User Story 1 - Maintain Collection-Driven Content (Priority: P1) 🎯 MVP

**Goal**: Store collection-driven content (Blog, Career, Projects) as Markdown with YAML frontmatter.

**Independent Test**: Can be fully tested by creating a new markdown file in the `content/` folder and observing it seamlessly load into the site without code changes.

### Implementation for User Story 1

- [X] T006 [P] [US1] Create sample markdown files for career entries in `content/career/` adhering to `frontmatter-schema.md`
- [X] T007 [P] [US1] Create sample markdown files for project entries in `content/projects/` adhering to `frontmatter-schema.md`
- [X] T008 [P] [US1] Create sample markdown files for blog entries in `content/blog/` adhering to `frontmatter-schema.md`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Maintain Structural UI (Priority: P2)

**Goal**: Ensure singleton/structural UI (Home, Hero, Nav, Footer) remain pure Dart components.

**Independent Test**: Verify that `Home`, `Nav`, and `Footer` are standalone components in `lib/components/` that do not depend on content fetching for their core structure.

### Implementation for User Story 2

- [X] T009 [P] [US2] Review and refactor `lib/components/header.dart` and `lib/components/navbar.dart` to be pure Dart components without hardcoded data arrays
- [X] T010 [P] [US2] Review and refactor `lib/components/footer.dart` to be a pure Dart component
- [X] T011 [P] [US2] Review and refactor `lib/components/hero_section.dart` and `lib/components/about_section.dart` to be pure Dart components
- [X] T012 [P] [US2] Review and refactor `lib/components/core_expertise_section.dart` and `lib/components/philosophy_section.dart` to be pure Dart components
- [X] T013 [US2] Update `lib/pages/home.dart` structural UI to use refactored components seamlessly

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Component Reusability via Data Injection (Priority: P3)

**Goal**: Refactor presentation components to be "dumb", receiving data exclusively via constructors.

**Independent Test**: Instantiate a presentation component with mock data in a test environment to verify it renders correctly without external dependencies.

### Implementation for User Story 3

- [X] T014 [P] [US3] Refactor `lib/components/projects_section.dart` to accept a list of `Project` models via constructor instead of hardcoding
- [X] T015 [P] [US3] Refactor `lib/components/career_section.dart` to accept a list of `JobExperience` models via constructor instead of hardcoding
- [X] T016 [US3] Update `lib/pages/project.dart` to fetch data via `jaspr_content` and pass it to `projects_section.dart`
- [X] T017 [US3] Update `lib/pages/career.dart` to fetch data via `jaspr_content` and pass it to `career_section.dart`
- [X] T018 [US3] Update `lib/pages/blog.dart` to fetch data via `jaspr_content` and pass it to blog components

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [X] T019 Check code cleanup and refactoring across all `lib/pages/`
- [X] T020 Run `jaspr build` to verify static site generation succeeds without errors
- [X] T021 Validate performance targets locally (FCP < 1.5s, TTI < 3s, Lighthouse > 90)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 2 (P2)**: Can start after Foundational (Phase 2)
- **User Story 3 (P3)**: Can start after Foundational (Phase 2)

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel
- Models within a story marked [P] can run in parallel

---

## Parallel Example: User Story 1

```bash
# Launch sample markdown files creation for User Story 1 together:
Task: "Create sample markdown files for career entries in content/career/ adhering to frontmatter-schema.md"
Task: "Create sample markdown files for project entries in content/projects/ adhering to frontmatter-schema.md"
Task: "Create sample markdown files for blog entries in content/blog/ adhering to frontmatter-schema.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
