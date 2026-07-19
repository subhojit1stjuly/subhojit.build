# Feature Specification: Architecture Refactor

**Feature Branch**: `004-architecture-refactor`

**Created**: 2026-07-19

**Status**: Draft

**Input**: User description: "Implement a Hybrid Content Architecture to eliminate 'spaghetti code' by strictly separating Data, Layout, and Styling. Use jaspr_content strictly for Collection-Driven Data (Blog, Career, Projects), storing them as Markdown files with YAML frontmatter in the content/ directory. Keep Singleton/Structural UI (Home, Hero, Nav, Footer) as pure Dart components without forcing them into Markdown. Extract explicit data models (e.g., Article, JobExperience, Project) into a new lib/models/ directory. Refactor presentation components in lib/components/ to be 'dumb' UI elements that only accept data via constructors and do not contain hardcoded arrays. Update lib/pages/ to act as the 'glue' layer, fetching data via jaspr_content and passing it to the UI components."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Maintain Collection-Driven Content (Priority: P1)

As a content author, I want collection-driven content (Blog, Career, Projects) to be stored as Markdown with YAML frontmatter, so that I can easily write and update content without touching Dart code.

**Why this priority**: Separating data from UI is the primary goal of the refactor, ensuring content can scale without bloating the codebase.

**Independent Test**: Can be fully tested by creating a new markdown file in the `content/` folder and observing it seamlessly load into the site without code changes.

**Acceptance Scenarios**:

1. **Given** a collection of projects, **When** a new project Markdown file is added to `content/`, **Then** the site correctly parses the YAML frontmatter and renders the project.
2. **Given** existing blog entries, **When** they are migrated to `content/`, **Then** they display identically to the hardcoded versions.

---

### User Story 2 - Maintain Structural UI (Priority: P2)

As a developer, I want singleton and structural UI elements (Home, Hero, Nav, Footer) to remain pure Dart components, so that I have full programmatic control over their complex layouts and styling.

**Why this priority**: Ensuring structural elements aren't forced into Markdown prevents restrictive workarounds and preserves layout flexibility.

**Independent Test**: Can be fully tested by verifying that `Home`, `Nav`, and `Footer` are standalone components in `lib/components/` that do not depend on content fetching for their core structure.

**Acceptance Scenarios**:

1. **Given** the application shell, **When** the site is rendered, **Then** structural components load directly from Dart without markdown parsing overhead.

---

### User Story 3 - Component Reusability via Data Injection (Priority: P3)

As a developer, I want presentation components to be "dumb", receiving their data exclusively via constructors, so that they can be reused across different pages and contexts without hardcoded data dependencies.

**Why this priority**: Removes "spaghetti code" by keeping side-effects and data-fetching strictly in the page layer.

**Independent Test**: Can be fully tested by instantiating a presentation component with mock data in a test environment to verify it renders correctly without external dependencies.

**Acceptance Scenarios**:

1. **Given** a presentation component, **When** it is instantiated with a data model instance, **Then** it accurately renders the provided data.
2. **Given** a presentation component, **When** it is inspected, **Then** it contains no hardcoded arrays or data fetching logic.

### Edge Cases

- What happens when a markdown file has invalid or missing YAML frontmatter?
- How does the system handle fetching a collection when the `content/` folder is empty?
- How does the "glue" layer (Pages) handle errors if `jaspr_content` fails to load content?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST parse and load Markdown files with YAML frontmatter from the `content/` directory using `jaspr_content`.
- **FR-002**: System MUST define explicit, typed data models for domain entities (e.g., Article, JobExperience, Project) in the `lib/models/` directory.
- **FR-003**: System MUST NOT fetch data within presentation components located in `lib/components/`.
- **FR-004**: System MUST inject all necessary data into presentation components via their constructors.
- **FR-005**: System MUST use `lib/pages/` components as the exclusive layer for fetching data via `jaspr_content` and routing it to presentation components.
- **FR-006**: System MUST maintain Singleton/Structural UI elements (e.g., Nav, Footer, Hero) as pure Dart components that do not rely on Markdown representations.

### Key Entities

- **Article**: Represents a blog post, including title, date, excerpt, tags, and markdown body.
- **JobExperience**: Represents a career history entry, including company, role, duration, and responsibilities.
- **Project**: Represents a portfolio project, including name, description, technologies used, and external links.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of collection-driven data (Blog, Career, Projects) is removed from Dart code and stored in the `content/` directory.
- **SC-002**: 0 presentation components (`lib/components/`) contain hardcoded data arrays or fetch logic.
- **SC-003**: 100% of data models are cleanly defined and typed in the `lib/models/` directory.
- **SC-004**: System builds and renders all pages flawlessly with the new architecture, visually matching the previous implementation.

## Assumptions

- Content authors will ensure valid YAML frontmatter in Markdown files.
- Visual design and features are not changing; this is strictly an architectural refactor.
- `jaspr_content` provides the necessary APIs to parse YAML frontmatter and markdown body cleanly.
