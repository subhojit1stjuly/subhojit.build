# Feature Specification: Content Externalization with jaspr_content

**Feature Branch**: `001-content-migration`

**Created**: 2026-07-18

**Status**: Draft

**Input**: Migrate hardcoded content (blog articles, projects, career timeline, certifications) from Dart component files to externalized jaspr_content Markdown and YAML files, enabling content updates without code deployment while maintaining static site generation.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Content Editor Updates Blog Post (Priority: P1)

A content editor needs to publish a new blog article or update an existing one without touching any Dart code or redeploying the application.

**Why this priority**: Blog content changes frequently and should not require developer intervention. This is the primary use case for jaspr_content and delivers immediate value by enabling non-technical content updates.

**Independent Test**: Can be fully tested by creating/editing a Markdown file in `content/blog/`, running `jaspr build`, and verifying the blog page renders the new/updated content correctly in the static output.

**Acceptance Scenarios**:

1. **Given** a new blog article Markdown file exists in `content/blog/new-post.md`, **When** the static site is built, **Then** the blog page displays the new article with correct title, excerpt, category, tags, and content
2. **Given** an existing blog article is edited in `content/blog/existing-post.md`, **When** the static site is rebuilt, **Then** the blog page reflects the updated content without code changes
3. **Given** a blog article has frontmatter metadata (title, date, category, tags, featured, excerpt), **When** the article is loaded, **Then** all metadata is correctly parsed and displayed on the blog listing and detail pages

---

### User Story 2 - Manage Project Portfolio (Priority: P2)

A content editor needs to add, update, or remove portfolio projects from the homepage without modifying component code.

**Why this priority**: Project portfolio is relatively static but needs occasional updates when new projects are completed. Externalizing this content reduces developer dependency for content changes.

**Independent Test**: Can be tested by editing `content/projects.yaml`, running `jaspr build`, and verifying the projects section on the homepage shows the updated project list with correct titles, descriptions, tags, and links.

**Acceptance Scenarios**:

1. **Given** a new project entry is added to `content/projects.yaml`, **When** the site is built, **Then** the homepage projects section displays the new project card
2. **Given** an existing project's description or tags are updated, **When** the site is rebuilt, **Then** the changes are reflected on the homepage
3. **Given** a project is removed from the YAML file, **When** the site is rebuilt, **Then** the project no longer appears on the homepage

---

### User Story 3 - Update Career Timeline (Priority: P3)

A content editor needs to add new career experiences or certifications to the career page without developer involvement.

**Why this priority**: Career updates happen less frequently (every few months or years) but should still be content-editable for consistency and maintainability.

**Independent Test**: Can be tested by editing `content/career.yaml` and `content/certifications.yaml`, rebuilding the site, and verifying the career page displays updated timeline entries and certifications.

**Acceptance Scenarios**:

1. **Given** a new career experience is added to `content/career.yaml`, **When** the site is built, **Then** the career page displays the new experience in chronological order
2. **Given** certification details are updated in `content/certifications.yaml`, **When** the site is rebuilt, **Then** the academic section shows the updated certifications
3. **Given** career entry tags or descriptions are modified, **When** the site is rebuilt, **Then** all changes are reflected correctly

---

### Edge Cases

- What happens when a blog article has invalid frontmatter (missing required fields)?
- How does the system handle broken image paths in Markdown content?
- What occurs when a content file is deleted but still referenced elsewhere?
- How are content files sorted (by date, by filename, by frontmatter order)?
- What happens with non-ASCII characters or special symbols in content?
- How is content validated during the build process (schema enforcement)?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST load blog articles from Markdown files located in `content/blog/` directory
- **FR-002**: System MUST parse blog article frontmatter (title, date, excerpt, category, tags, featured, readMin, imageColor) from YAML front matter
- **FR-003**: System MUST render blog article body content from Markdown to HTML with proper styling
- **FR-004**: System MUST load project data from `content/projects.yaml` with schema validation
- **FR-005**: System MUST load career timeline entries from `content/career.yaml` with chronological ordering
- **FR-006**: System MUST load certifications from `content/certifications.yaml` for the academic section
- **FR-007**: System MUST maintain static site generation - all content MUST be available at build time
- **FR-008**: System MUST generate type-safe Dart models from content schemas
- **FR-009**: System MUST sort blog articles by date (newest first) automatically
- **FR-010**: System MUST display blog articles on listing page with pagination (articles per page configurable)
- **FR-011**: System MUST generate individual blog article detail pages at `/blog/{slug}` routes
- **FR-012**: System MUST preserve existing URL structure and navigation
- **FR-013**: System MUST handle missing or invalid content gracefully (log warnings, skip invalid entries)
- **FR-014**: System MUST validate content schemas during build (fail build on critical schema violations)
- **FR-015**: Components MUST remain presentational - no hardcoded content in Dart files after migration

### Key Entities *(include if feature involves data)*

- **BlogArticle**: Represents a blog post with title, excerpt, content body, category, tags, publication date, read time estimate, featured flag, and image color
- **Project**: Represents a portfolio project with title, description, category, technology tags, external URL, and image color
- **CareerEntry**: Represents a career experience with company name, role, duration, description, and technology tags
- **Certification**: Represents an academic credential or certification with icon identifier, type (Education/Certification), name, metadata (date/credential), and verification link

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Content editors can add a new blog article by creating a Markdown file and rebuilding the site in under 5 minutes (no code changes required)
- **SC-002**: Static build completes successfully with all content loaded from external files (zero hardcoded content in components)
- **SC-003**: Build time increases by less than 10% compared to current hardcoded approach (content parsing efficiency)
- **SC-004**: All existing blog articles, projects, career entries, and certifications display identically to current hardcoded version (visual parity)
- **SC-005**: Content schema violations are detected during build with clear error messages (developer experience)
- **SC-006**: 100% of hardcoded content arrays (`_articles`, `_projects`, `_entries`, `_certs`) are removed from Dart component files

## Assumptions

- Content editors have basic knowledge of Markdown syntax and YAML formatting
- Content files will be committed to the Git repository alongside code (no separate CMS backend)
- Build process remains local development with `jaspr build` command (no CI/CD changes needed immediately)
- All content is in English (no i18n/localization requirements in v1)
- jaspr_content library is compatible with Jaspr `^0.23.1` and works in static mode
- Content schemas can be defined using jaspr_content's built-in schema definition approach
- Blog article detail pages (`/blog/{slug}`) can be generated statically at build time
- No migration of existing blog URLs is needed (all articles are currently placeholders with `#` links)
- Image assets referenced in Markdown will use existing `web/images/` directory
- Content ordering logic (date-based sorting) is handled by jaspr_content or implemented in component queries
