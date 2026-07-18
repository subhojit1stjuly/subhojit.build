# Feature Specification: jaspr_content Infrastructure Setup & Validation

**Feature Branch**: `002-content-setup`

**Created**: 2026-07-18

**Status**: Draft

**Input**: Set up jaspr_content infrastructure with minimal risk - configure the library, create directory structure, add ONE sample blog post to validate the setup works correctly, while keeping all existing hardcoded content functional as fallback.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Validate jaspr_content Works with One Sample Post (Priority: P1)

As a developer, I need to validate that jaspr_content is properly configured and can load at least one blog post from a Markdown file, so I can confidently proceed with full migration knowing the infrastructure works.

**Why this priority**: This is a proof-of-concept and risk mitigation step. We validate the entire jaspr_content pipeline (file loading, frontmatter parsing, Markdown rendering, static generation) with minimal risk. If anything goes wrong, we haven't touched the existing hardcoded content.

**Independent Test**: Can be fully tested by creating ONE sample blog post at `content/blog/sample-post.md`, modifying the blog page to load from jaspr_content (with hardcoded fallback), running `jaspr build`, and verifying the sample post appears alongside existing hardcoded posts without breaking anything.

**Acceptance Scenarios**:

1. **Given** jaspr_content is configured in pubspec.yaml, **When** `build_runner build` is executed, **Then** content models are generated successfully without errors
2. **Given** one sample blog post exists at `content/blog/sample-post.md`, **When** the blog page component queries content, **Then** the sample post loads correctly with all frontmatter fields
3. **Given** the sample post is loaded, **When** the blog page renders, **Then** the sample post displays alongside existing hardcoded posts (hybrid mode)
4. **Given** `jaspr build` is executed, **When** the build completes, **Then** the static site includes the sample post without breaking existing functionality
5. **Given** jaspr_content loading fails, **When** an error occurs, **Then** the app falls back to hardcoded content gracefully with a console warning

---

### User Story 2 - Create Content Directory Structure (Priority: P2)

As a developer, I need a well-organized content directory structure ready for future migration, so content files have a clear home and the project follows best practices.

**Why this priority**: Proper organization from the start prevents refactoring later. This is a zero-risk setup task that prepares for future content addition.

**Independent Test**: Can be tested by verifying the directory structure exists after setup and that the structure matches jaspr_content conventions.

**Acceptance Scenarios**:

1. **Given** the setup is complete, **When** the project is inspected, **Then** `content/` directory exists at project root with subdirectories: `blog/`, `projects/`, `career/`, `certifications/`
2. **Given** each content directory exists, **When** inspected, **Then** each contains a `.gitkeep` or README file explaining its purpose
3. **Given** content directory structure exists, **When** Git status is checked, **Then** the structure is committed and tracked in version control

---

### User Story 3 - Document Content Schema & Usage (Priority: P3)

As a future content editor, I need clear documentation on how to add content (Markdown format, required frontmatter fields, file naming conventions), so I can add content confidently without developer help.

**Why this priority**: Documentation ensures successful handoff to content editors later. Low risk, high future value.

**Independent Test**: Can be tested by reading the documentation and successfully adding a new blog post following only the documented instructions.

**Acceptance Scenarios**:

1. **Given** documentation exists at `content/README.md`, **When** a content editor reads it, **Then** they understand how to create a blog post with required frontmatter
2. **Given** documentation includes schema examples, **When** a developer reviews it, **Then** all required fields and types are clearly documented
3. **Given** documentation includes troubleshooting section, **When** common errors occur, **Then** the documentation provides solutions

---

### Edge Cases

- What happens if jaspr_content package fails to load (network issue during pub get)?
- What if the sample blog post has malformed frontmatter?
- What occurs if the content directory structure is accidentally deleted?
- How does the build handle empty content directories?
- What if jaspr_content version incompatibility exists with current Jaspr version?
- What happens during hot reload with content file changes?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST add `jaspr_content: ^0.5.3+1` to dependencies if not already present
- **FR-002**: System MUST configure `build.yaml` for jaspr_content if required by the library
- **FR-003**: System MUST create `content/` directory at project root with subdirectories: `blog/`, `projects/`, `career/`, `certifications/`
- **FR-004**: System MUST create ONE sample blog post at `content/blog/sample-post.md` with valid frontmatter
- **FR-005**: Sample blog post MUST include frontmatter fields: `title`, `date`, `excerpt`, `category`, `tags` (list), `featured` (boolean), `readMin`, `imageColor`
- **FR-006**: System MUST run `build_runner build` to generate content models
- **FR-007**: System MUST validate that generated content models compile without errors
- **FR-008**: Blog page component MUST load sample post from jaspr_content alongside hardcoded posts (hybrid mode)
- **FR-009**: System MUST maintain ALL existing hardcoded blog posts as fallback
- **FR-010**: System MUST display sample post in blog listing with correct metadata
- **FR-011**: System MUST complete `jaspr build` successfully with sample content loaded
- **FR-012**: System MUST NOT break any existing functionality (navbar, routing, other pages)
- **FR-013**: System MUST include error handling - if jaspr_content fails, fall back to hardcoded content with console warning
- **FR-014**: System MUST create `content/README.md` documenting schema, frontmatter format, and usage examples
- **FR-015**: System MUST commit all setup files (content structure, sample post, documentation) to Git

### Key Entities *(include if feature involves data)*

- **ContentSchema**: Defines the structure and required fields for blog posts (title, date, excerpt, category, tags, featured, readMin, imageColor)
- **SampleBlogPost**: One example blog post demonstrating correct frontmatter and Markdown content format
- **ContentDirectory**: File system structure organizing content by type (blog, projects, career, certifications)

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `build_runner build` completes successfully with zero errors and generates content models
- **SC-002**: Sample blog post appears on the blog page listing alongside existing hardcoded posts
- **SC-003**: `jaspr build` completes successfully with sample content included in static output
- **SC-004**: All existing functionality remains intact - zero visual or functional regressions
- **SC-005**: If jaspr_content is disabled/commented out, site still builds and runs with hardcoded content (rollback safety)
- **SC-006**: Documentation in `content/README.md` contains complete schema definition and usage examples

## Assumptions

- jaspr_content `^0.5.3+1` is compatible with Jaspr `^0.23.1` in static mode
- jaspr_content requires `build_runner` for code generation (already in dev_dependencies)
- Sample blog post does not need to be "real" content - placeholder text is acceptable
- Content directory structure can exist empty (except sample post) without breaking builds
- Hot reload may or may not work with content changes (acceptable limitation for now)
- No existing `content/` directory conflicts exist in the project
- Git repository is in a clean state before starting setup
- Developer has permission to run `build_runner build` locally
- Static site generation remains the build mode (no server mode needed)
- Sample post can be removed or modified later without consequence
