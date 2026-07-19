# Research: Architecture Refactor

## 1. Content Parsing and Data Models
- **Decision**: Use `jaspr_content`'s built-in parsing for YAML frontmatter and markdown content. Map the parsed YAML maps to explicit, strongly-typed Dart models (e.g., `Article`, `Project`, `JobExperience`) defined in `lib/models/`.
- **Rationale**: The specification requires separating data from UI. Using `jaspr_content` directly achieves this while fulfilling Constitution Principle II (Content-First Architecture). Explicit Dart models ensure type safety and code quality (Constitution Principle VI).
- **Alternatives considered**: Manually reading files using `dart:io` (rejected: violates static generation constraints and `jaspr_content` is the standard for Jaspr).

## 2. UI Component Architecture
- **Decision**: Refactor all components in `lib/components/` to be "dumb" presentational components (`StatelessComponent`). They will receive data exclusively via constructor arguments.
- **Rationale**: Removes "spaghetti code", makes components reusable, and follows the specification (SC-002, FR-003, FR-004) and Constitution Principle I (Component-Based Architecture).
- **Alternatives considered**: Injecting Riverpod providers directly into presentational components (rejected: violates "dumb" component pattern; state management should only be used when interactive features require shared state, not for purely static props).

## 3. Glue Layer (Pages)
- **Decision**: Use `lib/pages/` as the exclusive layer for fetching content via `jaspr_content` and instantiating the UI components with this data.
- **Rationale**: Centralizes data fetching and keeps components clean. Matches FR-005.
- **Alternatives considered**: Creating a separate controller/service layer (rejected: adds unnecessary complexity for a static site generator).
