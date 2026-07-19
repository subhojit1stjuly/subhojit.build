# Implementation Plan: Architecture Refactor

**Branch**: `004-architecture-refactor` | **Date**: 2026-07-19 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/004-architecture-refactor/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement a Hybrid Content Architecture to strictly separate Data, Layout, and Styling. Use `jaspr_content` to manage collection-driven data (Blog, Career, Projects) via Markdown files in the `content/` directory. Maintain singleton/structural UI elements as pure Dart components. Introduce explicit data models in `lib/models/` and refactor presentation components in `lib/components/` to be "dumb", receiving data strictly via constructors. Fetching and routing data will happen exclusively in `lib/pages/`.

## Technical Context

**Language/Version**: Dart 3.10.0

**Primary Dependencies**: Jaspr `^0.23.1`, Jaspr Content `^0.5.3+1`

**Storage**: Markdown files in `content/` with YAML frontmatter

**Testing**: Jaspr Test `^0.23.2`

**Target Platform**: Web (Static Site)

**Project Type**: Web Application

**Performance Goals**: First Contentful Paint (FCP) < 1.5 seconds, Time to Interactive (TTI) < 3 seconds on 3G, Lighthouse score > 90

**Constraints**: NO Flutter-specific widgets, static mode only (`jaspr: mode: static`), NO runtime server dependencies

**Scale/Scope**: Refactoring existing site architecture, eliminating hardcoded data arrays in UI components

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Component-Based Architecture**: PASS. Components will be self-contained and located in `lib/components/`.
- **Content-First Architecture**: PASS. Introducing `jaspr_content` for blog, career, and projects.
- **State Management When Needed**: PASS. Presentational components will remain `StatelessComponent`.
- **Static Site Generation (IMMUTABLE)**: PASS. Pre-rendering logic remains intact.
- **Test Coverage**: PASS. Minimal tests for static pages.
- **Type Safety & Code Quality**: PASS. New models in `lib/models/` enforce type safety.

## Project Structure

### Documentation (this feature)

```text
specs/004-architecture-refactor/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md
```

### Source Code (repository root)

```text
content/
├── blog/
├── career/
└── projects/

lib/
├── components/   # "Dumb" presentation components
├── models/       # Explicit data models (Article, JobExperience, Project)
├── pages/        # "Glue" layer for fetching jaspr_content and rendering
└── app.dart      # Main app shell
```

**Structure Decision**: A Web application structure utilizing a `content/` folder for markdown data, `lib/models/` for schemas, `lib/components/` for purely presentational UI elements, and `lib/pages/` for data loading and page layout mapping.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| N/A | N/A | N/A |
