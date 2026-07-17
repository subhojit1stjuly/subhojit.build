---

description: "Task list for jaspr_content Infrastructure Setup & Validation"
---

# Tasks: jaspr_content Infrastructure Setup & Validation

**Branch**: `002-content-setup`

**Input**: Design documents from `specs/002-content-setup/` (spec.md, plan.md, data-model.md, contracts/blog-post-schema.md, quickstart.md, research.md)

**Prerequisites**: plan.md (complete), spec.md (complete), research.md (complete), data-model.md (complete), contracts/blog-post-schema.md (complete)

**Tests**: Tests are NOT included in this feature per spec.md (infrastructure setup, low test priority)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `- [ ] [ID] [P?] [Story?] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and content directory structure

- [ ] T001 Create content directory structure at D:\Projects\subhojit_build\content\
- [ ] T002 [P] Create blog subdirectory at D:\Projects\subhojit_build\content\blog\ with .gitkeep file
- [ ] T003 [P] Create projects subdirectory at D:\Projects\subhojit_build\content\projects\ with .gitkeep file
- [ ] T004 [P] Create career subdirectory at D:\Projects\subhojit_build\content\career\ with .gitkeep file
- [ ] T005 [P] Create certifications subdirectory at D:\Projects\subhojit_build\content\certifications\ with .gitkeep file
- [ ] T006 Verify jaspr_content ^0.5.3+1 exists in pubspec.yaml dependencies (no changes if present)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T007 Create sample blog post at D:\Projects\subhojit_build\content\blog\sample-post.md with valid frontmatter per contracts/blog-post-schema.md
- [ ] T008 Add sample post metadata: title, date, excerpt, category, tags, featured=true, readMin, imageColor, layout=blog
- [ ] T009 Add sample post Markdown content (placeholder text acceptable per spec assumptions)
- [ ] T010 Create content author documentation at D:\Projects\subhojit_build\content\README.md with schema, frontmatter format, and usage examples from quickstart.md

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Validate jaspr_content Works with One Sample Post (Priority: P1) 🎯 MVP

**Goal**: Validate that jaspr_content is properly configured and can load at least one blog post from a Markdown file, proving the infrastructure works

**Independent Test**: Create sample post, modify blog page to load from jaspr_content with hardcoded fallback, run jaspr build, verify sample post appears alongside existing posts without breaking anything

### Implementation for User Story 1

- [ ] T011 [US1] Configure ContentApp.custom() in lib/main.server.dart with FilesystemLoader('content') and MemoryLoader for existing hardcoded posts
- [ ] T012 [US1] Add jaspr_content imports (import 'package:jaspr_content/jaspr_content.dart') in lib/main.server.dart
- [ ] T013 [US1] Set eagerlyLoadAllPages: true in ContentApp configuration in lib/main.server.dart
- [ ] T014 [US1] Add PageConfig.all(parsers: [MarkdownParser()]) as configResolver in ContentApp in lib/main.server.dart
- [ ] T015 [US1] Create MemoryLoader with all 5 existing hardcoded blog articles from lib/pages/blog.dart _articles list
- [ ] T016 [US1] Convert each _Article to MemoryPage with path 'blog/<slug>.md', frontmatter as initialData.page, and content as markdown body
- [ ] T017 [US1] Implement defensive error handling - if FilesystemLoader fails, fall back to MemoryLoader with console warning
- [ ] T018 [US1] Verify lib/app.dart integrates with ContentApp (add ContentApp wrapper if needed)
- [ ] T019 [US1] Run jaspr build and verify build completes successfully with zero errors
- [ ] T020 [US1] Verify static output in build/web/ includes sample blog post at build/web/blog/sample-post/index.html
- [ ] T021 [US1] Verify all existing hardcoded blog posts still render correctly (zero regressions)
- [ ] T022 [US1] Start jaspr serve in dev mode and verify hot reload works when modifying content/blog/sample-post.md
- [ ] T023 [US1] Verify sample post displays on blog page with correct metadata (title, excerpt, category, featured badge, imageColor)
- [ ] T024 [US1] Test rollback safety: comment out FilesystemLoader, verify site still builds with MemoryLoader only

**Checkpoint**: At this point, User Story 1 should be fully functional - jaspr_content infrastructure validated with ONE sample post

---

## Phase 4: User Story 2 - Create Content Directory Structure (Priority: P2)

**Goal**: Ensure content directories are properly organized and tracked in version control

**Independent Test**: Verify directory structure exists and matches jaspr_content conventions, all directories tracked in Git

### Implementation for User Story 2

- [ ] T025 [P] [US2] Create .gitkeep file in content/blog/ to preserve empty directory (if not already present from T002)
- [ ] T026 [P] [US2] Create .gitkeep file in content/projects/ to preserve empty directory
- [ ] T027 [P] [US2] Create .gitkeep file in content/career/ to preserve empty directory
- [ ] T028 [P] [US2] Create .gitkeep file in content/certifications/ to preserve empty directory
- [ ] T029 [US2] Verify all content directories and .gitkeep files are tracked by Git (run git status)
- [ ] T030 [US2] Update .gitignore if needed to ensure content/ directory is NOT ignored

**Checkpoint**: At this point, content directory structure is complete and version-controlled

---

## Phase 5: User Story 3 - Document Content Schema & Usage (Priority: P3)

**Goal**: Provide clear documentation for future content editors on how to add blog posts following the schema

**Independent Test**: Read the documentation and successfully add a new blog post following only the documented instructions

### Implementation for User Story 3

- [ ] T031 [P] [US3] Copy content from specs/002-content-setup/quickstart.md into content/README.md (main content author guide)
- [ ] T032 [P] [US3] Add reference links in content/README.md to contracts/blog-post-schema.md for complete field reference
- [ ] T033 [P] [US3] Add reference links in content/README.md to data-model.md for runtime representation and querying
- [ ] T034 [US3] Add troubleshooting section to content/README.md with common errors and solutions (malformed YAML, missing fields, build failures)
- [ ] T035 [US3] Include minimal and complete blog post examples in content/README.md demonstrating required vs optional fields
- [ ] T036 [US3] Document category taxonomy (Architecture, Performance, State Management, DevOps, UI & Animations, Testing, Web) in content/README.md
- [ ] T037 [US3] Document file naming conventions (kebab-case, .md extension, slug becomes URL) in content/README.md
- [ ] T038 [US3] Add instructions for running jaspr serve for hot reload and jaspr build for production in content/README.md
- [ ] T039 [US3] Verify documentation by reading it and attempting to add a new blog post following only the documented instructions (validation test)

**Checkpoint**: Documentation is complete and validated - future content editors can add posts without developer help

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final validation, cleanup, and documentation updates

- [ ] T040 [P] Update .github/copilot-instructions.md with jaspr_content context (ContentApp, MemoryLoader, FilesystemLoader patterns)
- [ ] T041 [P] Add section to .github/copilot-instructions.md documenting blog post frontmatter schema reference
- [ ] T042 Run complete build validation: jaspr build completes with zero errors and warnings
- [ ] T043 Verify sample post appears in production build output at build/web/blog/sample-post/index.html
- [ ] T044 Verify all existing pages (home, blog listing, about, etc.) remain functional (zero regressions)
- [ ] T045 Run quickstart.md validation: follow quickstart instructions to add a second blog post and verify it works
- [ ] T046 Commit all setup files (content structure, sample post, documentation, ContentApp config) to Git with descriptive commit message

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup (Phase 1) completion - BLOCKS all user stories
- **User Story 1 (Phase 3)**: Depends on Foundational (Phase 2) - Must complete before US2 and US3
- **User Story 2 (Phase 4)**: Depends on Setup (Phase 1) - Can run in parallel with US1 after Phase 2
- **User Story 3 (Phase 5)**: Depends on Foundational (Phase 2) and User Story 1 (Phase 3) - Requires sample post to exist for validation
- **Polish (Phase 6)**: Depends on all user stories (US1, US2, US3) being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories - **REQUIRED FOR MVP**
- **User Story 2 (P2)**: Can start after Setup (Phase 1) - Independent of US1, but overlaps with setup tasks
- **User Story 3 (P3)**: Depends on US1 completion (needs sample post to validate documentation)

### Within Each User Story

**User Story 1**:
- T011-T014: ContentApp configuration (sequential)
- T015-T016: MemoryLoader creation (after ContentApp config)
- T017: Error handling (after loader setup)
- T018: Integration verification (after ContentApp setup)
- T019-T024: Validation tasks (sequential, after implementation complete)

**User Story 2**:
- T025-T028: All .gitkeep creation tasks can run in parallel
- T029-T030: Git verification (after .gitkeep files created)

**User Story 3**:
- T031-T033: Documentation tasks can run in parallel
- T034-T038: Additional documentation sections (sequential or parallel)
- T039: Validation test (must be last, after all documentation complete)

### Parallel Opportunities

**Phase 1 (Setup)**:
- T002, T003, T004, T005 can all run in parallel (different directories)

**Phase 2 (Foundational)**:
- T007, T008, T009 (sample post creation) are sequential
- T010 (documentation) can run in parallel with sample post creation

**Phase 4 (User Story 2)**:
- T025, T026, T027, T028 can all run in parallel (different .gitkeep files)

**Phase 5 (User Story 3)**:
- T031, T032, T033 can run in parallel (different documentation sections)

**Phase 6 (Polish)**:
- T040, T041 can run in parallel (different documentation files)

---

## Parallel Example: Setup Phase

```bash
# Launch all content directory creation tasks together:
Task: "Create blog subdirectory at D:\Projects\subhojit_build\content\blog\ with .gitkeep file"
Task: "Create projects subdirectory at D:\Projects\subhojit_build\content\projects\ with .gitkeep file"
Task: "Create career subdirectory at D:\Projects\subhojit_build\content\career\ with .gitkeep file"
Task: "Create certifications subdirectory at D:\Projects\subhojit_build\content\certifications\ with .gitkeep file"
```

## Parallel Example: User Story 2

```bash
# Launch all .gitkeep creation tasks together:
Task: "Create .gitkeep file in content/blog/"
Task: "Create .gitkeep file in content/projects/"
Task: "Create .gitkeep file in content/career/"
Task: "Create .gitkeep file in content/certifications/"
```

## Parallel Example: User Story 3

```bash
# Launch all documentation reference tasks together:
Task: "Copy content from specs/002-content-setup/quickstart.md into content/README.md"
Task: "Add reference links in content/README.md to contracts/blog-post-schema.md"
Task: "Add reference links in content/README.md to data-model.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001-T006)
2. Complete Phase 2: Foundational (T007-T010) - CRITICAL
3. Complete Phase 3: User Story 1 (T011-T024)
4. **STOP and VALIDATE**: Test User Story 1 independently
   - Verify sample post loads
   - Verify jaspr build succeeds
   - Verify existing posts still work
   - Test rollback (comment out FilesystemLoader)
5. Deploy/demo if ready - **MVP ACHIEVED**

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready (T001-T010)
2. Add User Story 1 → Test independently → Deploy/Demo (T011-T024) - **MVP!**
3. Add User Story 2 → Test independently → Deploy/Demo (T025-T030) - Directory structure solidified
4. Add User Story 3 → Test independently → Deploy/Demo (T031-T039) - Documentation complete
5. Polish & validate → Final deployment (T040-T046)

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together (T001-T010)
2. Once Foundational is done:
   - **Developer A**: User Story 1 (T011-T024) - PRIMARY, MVP CRITICAL
   - **Developer B**: User Story 2 (T025-T030) - Can start after T001-T006
   - **Developer C**: Start User Story 3 docs (T031-T038), wait for US1 completion for T039 validation
3. Stories complete and integrate independently

---

## Edge Cases Handled

Per spec.md edge cases, the implementation handles:

- ✅ **jaspr_content package fails to load**: MemoryLoader provides fallback, site still builds
- ✅ **Sample post has malformed frontmatter**: Build fails with clear error, documented in troubleshooting (T034)
- ✅ **Content directory accidentally deleted**: .gitkeep files preserve structure, FilesystemLoader returns empty list (no crash)
- ✅ **Empty content directories**: .gitkeep files prevent Git from ignoring directories, site builds normally
- ✅ **jaspr_content version incompatibility**: Validated in research.md that ^0.5.3+1 works with Jaspr ^0.23.1
- ✅ **Hot reload with content file changes**: Tested in T022, FilesystemLoader DirectoryWatcher handles this

---

## Success Criteria Validation

### SC-001: build_runner build completes successfully
- **Validation**: Not applicable - jaspr_content is runtime-only, no build_runner integration (research.md Q1)

### SC-002: Sample blog post appears on blog page
- **Validation**: T023 - Verify sample post displays with correct metadata

### SC-003: jaspr build completes successfully
- **Validation**: T019, T042 - Verify static build succeeds

### SC-004: All existing functionality intact
- **Validation**: T021, T044 - Zero visual or functional regressions

### SC-005: Rollback safety
- **Validation**: T024 - Site builds with MemoryLoader only when FilesystemLoader disabled

### SC-006: Documentation complete
- **Validation**: T031-T039 - content/README.md contains schema and examples, validated by test

---

## Notes

- **[P] tasks**: Different files, no dependencies, can run in parallel
- **[Story] label**: Maps task to specific user story for traceability
- **Each user story** is independently completable and testable
- **Commit strategy**: Commit after each phase or logical group (T046 final commit)
- **Stop at any checkpoint** to validate story independently
- **Tests optional**: No test tasks included per spec.md (infrastructure setup, low test priority)
- **Exact file paths**: All tasks include complete Windows paths for clarity
- **Defensive error handling**: T017 ensures graceful degradation if jaspr_content fails
- **Hot reload validation**: T022 confirms dev experience works as expected
- **Rollback validation**: T024 confirms zero-risk approach works (can disable FilesystemLoader anytime)

---

## Total Task Count

- **Setup (Phase 1)**: 6 tasks
- **Foundational (Phase 2)**: 4 tasks
- **User Story 1 (Phase 3)**: 14 tasks
- **User Story 2 (Phase 4)**: 6 tasks
- **User Story 3 (Phase 5)**: 9 tasks
- **Polish (Phase 6)**: 7 tasks

**Total**: 46 tasks

**Parallel opportunities identified**: 13 tasks marked [P] across all phases

**MVP scope**: Phase 1 (6 tasks) + Phase 2 (4 tasks) + Phase 3 (14 tasks) = **24 tasks for MVP**
