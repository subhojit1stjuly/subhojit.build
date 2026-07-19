<!--
SYNC IMPACT REPORT

Version change: 0.1.0 (Initial Constitution)

Modified principles: N/A (initial version)

Added sections:
- Core Principles (5 principles: Component-Based Architecture, State Management with Riverpod, Static Site Generation, Test Coverage, Type Safety & Code Quality)
- Technology Stack Requirements
- Development Workflow

Removed sections: N/A

Templates requiring updates:
✅ plan-template.md - reviewed, no changes needed
✅ spec-template.md - reviewed, no changes needed
✅ tasks-template.md - reviewed, no changes needed

Follow-up TODOs: None
-->

# Subhojit.Build Constitution

## Core Principles

### I. Component-Based Architecture

Every UI element MUST be implemented as a reusable Jaspr component. Components MUST be:
- Self-contained with clear responsibilities
- Properly typed with explicit parameters
- Located in `lib/components/` for shared components or feature-specific directories
- Documented with DartDoc comments explaining purpose and usage
- Composable - complex UIs built from simpler components

**Rationale**: Component-based architecture ensures maintainability, reusability, and testability. Jaspr's component model enables building scalable web applications with predictable structure.

### II. Content-First Architecture with jaspr_content

Content SHOULD be managed through `jaspr_content` for externalized, editable data. Requirements:
- Blog posts MUST be authored in Markdown files under `content/blog/`
- Project data, career timeline, and certifications SHOULD be externalized as structured content
- Content schemas MUST be defined with type-safe models
- Static content MUST remain pre-renderable at build time
- Content updates MUST NOT require code redeployment

**Current Status**: jaspr_content dependency added; migration in progress. Hardcoded data acceptable until migration complete.

**Rationale**: Separating content from code enables non-technical content updates, better version control for content, and maintains static generation benefits while improving maintainability.

### III. State Management When Needed

State management MUST use `jaspr_riverpod` when interactive features require shared or complex state. Requirements:
- Purely presentational components SHOULD remain `StatelessComponent`
- Global state (auth, theme, API data) MUST be managed through Riverpod providers when introduced
- Form state and validation MUST use Riverpod StateNotifier or StateProvider
- Providers MUST be defined in `lib/providers/` directory when created
- Local UI-only state (animations, toggles) MAY use `useState` from Jaspr

**Current Status**: jaspr_riverpod dependency added but NOT implemented. Current codebase is purely static with zero state management needs. Introduce Riverpod when adding: newsletter/contact forms, authentication, blog filtering, theme switching, or client-side data fetching.

**Rationale**: State management adds complexity and should only be introduced when genuinely needed. Riverpod provides compile-time safe, testable state management for future interactive features while keeping the current static architecture simple.

### IV. Static Site Generation (IMMUTABLE)

The project MUST maintain static site generation mode (`jaspr: mode: static` in pubspec.yaml). Requirements:
- All pages MUST be pre-renderable at build time
- No runtime server-side rendering dependencies
- Content loaded via `jaspr_content` MUST be available at build time
- Client-side dynamic data fetching MAY occur after hydration for progressive enhancement
- Build output MUST be deployable to static hosting (Netlify, Vercel, GitHub Pages)

**Rationale**: Static generation ensures fast loading (FCP < 1.5s), excellent SEO, simple deployment, zero server costs, and global CDN distribution. This is a core architectural decision that must not be compromised.

### V. Test Coverage

Testing with `jaspr_test` is REQUIRED for interactive features and business logic. Requirements:
- Component tests MUST verify rendering for complex interactive components
- Provider/state tests MUST verify state transitions when Riverpod is introduced
- Tests SHOULD be written alongside implementation (TDD encouraged for forms/logic)
- All tests located in `test/` directory following source structure
- Tests MUST pass before merging to main branch
- Purely presentational static components MAY have minimal test coverage

**Current Status**: jaspr_test dependency added. Testing strategy evolves as interactivity increases. Static presentational components currently have lower testing priority than future interactive features.

**Rationale**: Tests prevent regressions and document expected behavior. Focus testing effort on interactive features, forms, state management, and business logic rather than static presentation.

### VI. Type Safety & Code Quality

Dart's type system and static analysis MUST be leveraged fully. Requirements:
- No `dynamic` types without explicit justification
- All functions MUST have explicit return types
- Null safety MUST be respected - no null assertion (`!`) without safety checks
- Follow `analysis_options.yaml` lints strictly (currently `lints: ^5.0.0`)
- All code MUST pass `dart analyze` with zero errors/warnings before commit
- Format code with `dart format` before commit

**Rationale**: Type safety catches errors at compile time, improves IDE support, and makes code self-documenting. Strict linting maintains consistency across the codebase.

## Technology Stack Requirements

The project technology stack is defined and MUST be followed:

**Core Framework** (Currently Implemented):
- Dart SDK: `^3.10.0`
- Jaspr: `^0.23.1` (web framework) ✅ **In Use**
- Jaspr Router: `^0.8.2` (routing) ✅ **In Use**

**Content & State** (Dependencies Added, Implementation Pending):
- Jaspr Content: `^0.5.3+1` (content management) ⚠️ **Added, Not Implemented**
- Jaspr Riverpod: `^0.4.6` (state management) ⚠️ **Added, Not Used (no state yet)**

**Development**:
- Jaspr Builder: `^0.23.1` (build tooling)
- Build Runner: `^2.10.0` (code generation)
- Build Web Compilers: `^4.8.0` (Dart-to-JS compilation)
- Jaspr Test: `^0.23.2` (testing framework) ⚠️ **Added, Minimal Tests**

**Current Architecture**:
- ✅ All components are `StatelessComponent` (no state management in use)
- ✅ Static data hardcoded in components (blog articles, projects, career entries)
- ✅ CSS-only interactivity (navbar drawer uses `:has()` selector)
- ✅ Zero client-side state or API calls
- ⚠️ Content migration to `jaspr_content` is planned next step

**Constraints**:
- NO Flutter-specific widgets (this is Jaspr web, not Flutter web)
- NO server-side Dart code (static mode only)
- NO runtime server dependencies
- Package additions MUST be justified and approved
- Maintain static generation benefits during any architectural evolution

**Performance Goals**:
- First Contentful Paint (FCP) < 1.5 seconds
- Time to Interactive (TTI) < 3 seconds on 3G networks
- Lighthouse score > 90 for Performance, Accessibility, Best Practices, SEO
- Bundle size < 500 KB (gzipped)

## Development Workflow

**Branch Strategy**:
- Main branch (`master`) is protected and always deployable
- Feature branches follow pattern: `###-feature-name` (e.g., `001-user-auth`)
- Use `/speckit.git.feature` command to create feature branches

**Development Cycle**:
1. Create feature specification with `/speckit.specify`
2. Generate implementation plan with `/speckit.plan`
3. Generate tasks with `/speckit.tasks`
4. Implement following TDD when tests are required
5. Run `jaspr build` to verify static build succeeds
6. Run tests with `dart test` (all must pass)
7. Commit changes (auto-commit via hooks or manual)
8. Merge to master after validation

**Evolution Roadmap**:

Phase 1 (Current): Pure Static Jaspr ✅ **COMPLETE**
- Component-based architecture with StatelessComponent
- jaspr_router for SPA navigation
- Hardcoded content in components
- CSS-only interactivity

Phase 2 (Next): Content Externalization ⏳ **IN PROGRESS**
- Migrate blog posts to Markdown files with jaspr_content
- Externalize projects, career, certifications as structured content
- Maintain static generation
- Enable content updates without code deployment

Phase 3 (Future): Add Interactivity 🔮 **WHEN NEEDED**
- Newsletter/contact form submission (introduce Riverpod)
- Blog post filtering by category/tag
- Theme switching (light/dark mode)
- Search functionality
- User preferences persistence

**Code Review Requirements**:
- All constitution principles MUST be verified
- Type safety and linting checks passed
- Tests included and passing
- Build output verified (run `jaspr build`)
- No breaking changes to existing functionality unless explicitly planned

## Governance

This constitution supersedes all other development practices and preferences. All code changes, reviews, and architectural decisions MUST align with these principles.

**Amendment Process**:
- Amendments require documentation of rationale and impact
- Version bumps follow semantic versioning (MAJOR.MINOR.PATCH)
- Templates in `.specify/templates/` MUST be updated when principles change
- Constitution changes MUST be committed via `/speckit.constitution` command

**Compliance**:
- All PRs/reviews MUST verify compliance with principles
- Complexity or deviations MUST be explicitly justified
- Use `.specify/templates/` for consistent feature development
- Refer to this constitution when making architectural decisions

**Versioning Policy**:
- MAJOR: Breaking changes to core principles (e.g., changing from static to server mode)
- MINOR: New principles added or substantial guidance expansions
- PATCH: Clarifications, examples, or non-semantic improvements

<!--
SYNC IMPACT REPORT

Version change: 1.0.0 → 1.1.0 (Minor - New guidance, no breaking changes)

Modified principles:
- Principle II: Changed from "Riverpod (NON-NEGOTIABLE)" to "Content-First with jaspr_content" (reflects migration priority)
- Principle III: Changed from "Static Site Generation" to "State Management When Needed" (better ordering, reflects current reality)
- Principle IV: Changed from "Test Coverage" to "Static Site Generation (IMMUTABLE)" (core principle elevated)
- Principle V: Changed from "Type Safety" to "Test Coverage" (reordered, clarified current status)
- Principle VI: New - "Type Safety & Code Quality" (preserved from V)

Technology Stack:
- Added current implementation status (✅ In Use, ⚠️ Added/Not Implemented)
- Clarified architecture evolution roadmap
- Documented zero state management in current codebase

Templates requiring updates: None (guidance changes only, no template structure impact)

Follow-up TODOs:
- [ ] Create jaspr_content migration specification
- [ ] Migrate blog articles to Markdown
- [ ] Define content schemas for projects/career/certs
-->

**Version**: 1.1.0 | **Ratified**: 2026-07-18 | **Last Amended**: 2026-07-18T01:15:00+05:30

**Amendment Summary**: Updated principles to reflect actual current architecture - pure static site with no state management. Clarified jaspr_content as next priority, jaspr_riverpod as future when interactive features are added. Reordered principles to match implementation priority.
