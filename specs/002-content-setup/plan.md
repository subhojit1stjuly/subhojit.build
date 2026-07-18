# Implementation Plan: jaspr_content Infrastructure Setup

**Branch**: `002-content-setup` | **Date**: 2026-07-18 | **Spec**: [specs/002-content-setup/spec.md](spec.md)

**Input**: Feature specification from `specs/002-content-setup/spec.md`

## Summary

Set up jaspr_content v0.5.3+1 infrastructure with minimal risk by:
1. Creating content directory structure (`content/blog/`, `projects/`, `career/`, `certifications/`)
2. Adding ONE sample blog post to validate the entire pipeline (file loading, frontmatter parsing, Markdown rendering, static generation)
3. Configuring ContentApp with hybrid mode (MemoryLoader for existing hardcoded posts + FilesystemLoader for new sample post)
4. Maintaining all existing hardcoded content as fallback to ensure zero regressions
5. Documenting content schema and usage for future content authors

**Key Technical Approach** (from research):
- jaspr_content is runtime-only (NO build.yaml or code generation needed)
- Static mode fully supported — content files read at build time during `jaspr build`
- Hot reload enabled in dev mode via FilesystemLoader DirectoryWatcher
- Hybrid mode via `ContentApp.custom(loaders: [MemoryLoader, FilesystemLoader])` allows gradual migration
- Defensive error handling with MemoryLoader fallback ensures graceful degradation

## Technical Context

**Language/Version**: Dart SDK ^3.10.0

**Primary Dependencies**: 
- jaspr: ^0.23.1 (web framework)
- jaspr_content: ^0.5.3+1 (content management — runtime-only, no codegen)
- jaspr_router: ^0.8.2 (routing)
- build_runner: ^2.10.0 (for @client annotations only, NOT for jaspr_content)

**Storage**: Filesystem (Markdown files in `content/` directory)

**Testing**: jaspr_test ^0.23.2 (testing framework — minimal tests for this setup feature)

**Target Platform**: Static site (Jaspr mode: static) deployed to web

**Project Type**: Static website (personal portfolio + technical blog)

**Performance Goals**: 
- First Contentful Paint (FCP) < 1.5 seconds
- Time to Interactive (TTI) < 3 seconds on 3G
- Hot reload content changes < 500ms in dev mode

**Constraints**: 
- MUST maintain static site generation (no server mode)
- MUST preserve all existing functionality (zero regressions)
- MUST NOT require build_runner for jaspr_content (it's runtime-only)
- Content changes MUST NOT require code redeployment

**Scale/Scope**: 
- Initial: 1 sample blog post (validation)
- Current: 5 hardcoded blog articles (preserved via MemoryLoader)
- Future: 20-50 blog posts, 10+ projects, career timeline, certifications

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### ✅ PASS: Component-Based Architecture (Principle I)
- jaspr_content ContentApp is a Jaspr component
- Blog posts rendered via PageLayout components (BlogLayout)
- Existing BlogPage remains a StatelessComponent
- Sample content will be rendered through jaspr_content's component pipeline

**Justification**: jaspr_content embraces component-based architecture. No violations.

---

### ✅ PASS: Content-First Architecture with jaspr_content (Principle II)
- This feature IMPLEMENTS the content-first migration strategy
- Externalizes blog posts to Markdown files in `content/blog/`
- Enables non-technical content updates without code changes
- Maintains static generation benefits

**Justification**: This feature directly fulfills the constitution's content-first principle. Currently "in progress" status moves to "active" after this feature.

---

### ✅ PASS: State Management When Needed (Principle III)
- jaspr_content does NOT introduce client-side state
- All content loading happens at build time (static mode)
- No Riverpod providers needed for this feature
- Purely presentational content rendering

**Justification**: No state management needed. Static content only.

---

### ✅ PASS: Static Site Generation (IMMUTABLE) (Principle IV)
- jaspr_content explicitly supports `mode: static`
- Content files read at build time during `jaspr build`
- No runtime server dependencies
- Build output remains fully static HTML

**Justification**: jaspr_content is designed for static generation. No violations. Research confirms first-class static mode support.

---

### ✅ PASS: Test Coverage (Principle V)
- This is an infrastructure setup feature (low test priority per constitution)
- Tests should validate: sample post loads, build succeeds, fallback works
- Future content-driven features will require component tests

**Justification**: Minimal testing acceptable for infrastructure setup. Will add validation tests for ContentApp configuration.

---

### ✅ PASS: Type Safety & Code Quality (Principle VI)
- jaspr_content Page objects are strongly typed
- Frontmatter accessed via defensive casting: `as String? ?? 'default'`
- No `dynamic` types introduced
- Follows Dart null safety

**Justification**: Type-safe defensive access patterns documented in data-model.md. No violations.

---

### Re-evaluation After Phase 1 Design

All gates remain **✅ PASS** after Phase 1 design:
- Content schema defined with strong types (data-model.md)
- Contract enforces field types and constraints (contracts/blog-post-schema.md)
- Defensive access patterns documented for runtime safety
- No architecture deviations from constitution principles

## Project Structure

### Documentation (this feature)

```text
specs/002-content-setup/
├── plan.md                          # This file
├── spec.md                          # Feature specification
├── research.md                      # Phase 0: jaspr_content research findings
├── data-model.md                    # Phase 1: Blog post data model & runtime representation
├── quickstart.md                    # Phase 1: Content author quick-start guide
├── contracts/
│   └── blog-post-schema.md          # Phase 1: Frontmatter schema contract
└── tasks.md                         # Phase 2: Generated by /speckit.tasks (NOT in this command)
```

### Source Code (repository root)

```text
D:\Projects\subhojit_build\
├── content/                          # NEW: Content root directory
│   ├── blog/                        # NEW: Blog posts (Markdown files)
│   │   ├── .gitkeep                # NEW: Preserve empty directory
│   │   └── sample-post.md          # NEW: Validation sample post
│   ├── projects/                    # NEW: Future project case studies
│   │   └── .gitkeep                # NEW
│   ├── career/                      # NEW: Future career timeline entries
│   │   └── .gitkeep                # NEW
│   ├── certifications/              # NEW: Future certifications
│   │   └── .gitkeep                # NEW
│   └── README.md                    # NEW: Content author documentation
├── lib/
│   ├── main.server.dart             # MODIFIED: Add ContentApp setup
│   ├── app.dart                     # EXISTING: May need ContentApp integration
│   ├── components/
│   │   ├── blog_section.dart        # FUTURE: May use context.pages
│   │   └── ...                      # EXISTING: Unchanged
│   ├── pages/
│   │   ├── blog.dart                # EXISTING: Unchanged (uses hardcoded _articles)
│   │   └── ...                      # EXISTING: Unchanged
│   └── constants/
│       └── theme.dart               # EXISTING: Unchanged
├── web/                             # EXISTING: Static assets
├── specs/
│   └── 002-content-setup/          # THIS FEATURE
├── .github/
│   └── copilot-instructions.md     # MODIFIED: Updated agent context
├── pubspec.yaml                     # EXISTING: Already has jaspr_content dependency
└── build.yaml                       # NOT CREATED: Not needed for jaspr_content
```

**Structure Decision**: Single-project Jaspr static site with content externalization. Content files live in dedicated `content/` directory at project root following jaspr_content conventions. Existing `lib/` structure unchanged except for main.server.dart ContentApp setup.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

**No violations** — All constitution gates pass. No complexity tracking needed.
