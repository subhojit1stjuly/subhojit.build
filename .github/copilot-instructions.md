# Copilot Instructions for subhojit.build

## Project Overview

This is a **personal portfolio website** built with [Jaspr](https://docs.page/schultek/jaspr) - a modern web framework for Dart that compiles to HTML/CSS/JavaScript. The site showcases blog posts, career experiences, and projects using a content-driven architecture.

## Tech Stack

- **Framework**: Jaspr ^0.23.1 (Dart for Web)
- **Content Management**: jaspr_content ^0.5.3+1 (Markdown + YAML frontmatter)
- **Routing**: jaspr_router ^0.8.2
- **State Management**: jaspr_riverpod ^0.4.6
- **Dart SDK**: ^3.10.0
- **Build Mode**: Static Site Generation (SSG)

## Architecture Principles

### Hybrid Content Architecture

1. **Collections (Content-Driven)**: Blog posts, career experiences, and projects are managed via `jaspr_content` with Markdown files in `content/` directory
2. **Singletons (Component-Driven)**: Home page, navigation, hero sections, and other structural UI elements are pure Dart components
3. **Strict Separation**: Data models (`lib/models/`), presentation components (`lib/shared_components/`), and data fetching (`lib/pages/`) are clearly separated

### Directory Structure

```
content/               # Markdown files with YAML frontmatter
├── blog/             # Blog posts
├── career/           # Job experiences
└── projects/         # Project showcases

lib/
├── app.dart          # Main app shell
├── core/             # Core utilities and configurations
├── models/           # Explicit data models (Article, JobExperience, Project)
├── pages/            # Page components (data fetching + layout)
├── shared_components/ # Reusable "dumb" presentation components
├── main.client.dart  # Client-side entry point
└── main.server.dart  # Server-side entry point (SSG)

specs/                # SpecKit feature specifications and plans
.specify/             # SpecKit configuration and templates
```

## Coding Guidelines

### Component Development

1. **Stateless by Default**: Use `StatelessComponent` unless state is absolutely necessary
2. **Constructor Injection**: Components receive all data via constructors (no hardcoded data)
3. **Type Safety**: Always use explicit types; leverage Dart's strong typing
4. **Naming Convention**: 
   - Components: PascalCase (e.g., `HeroSection`, `BlogCard`)
   - Files: snake_case (e.g., `hero_section.dart`, `blog_card.dart`)

### Content Management

1. **Markdown Files**: All content lives in `content/` with `.md` extension
2. **Frontmatter**: Use YAML frontmatter for metadata (title, date, tags, etc.)
3. **Models**: Define explicit Dart models in `lib/models/` for type safety
4. **Fetching**: Use `jaspr_content` APIs in page components to load content

### Styling

1. **CSS-in-Dart**: Use Jaspr's `Styles` API for component styling
2. **No Global Styles**: Keep styles scoped to components
3. **Responsive Design**: Mobile-first approach with breakpoints

## Development Commands

```bash
# Development server with hot reload
jaspr serve

# Production build (outputs to build/jaspr/)
jaspr build

# Run tests
dart test

# Code generation (if needed)
dart run build_runner build

# Clean build artifacts
dart run build_runner clean
```

## Performance Targets

- First Contentful Paint (FCP): < 1.5 seconds
- Time to Interactive (TTI): < 3 seconds on 3G
- Lighthouse Score: > 90
- Static mode only - NO runtime server dependencies

## Important Constraints

- ❌ NO Flutter widgets (use Jaspr HTML components)
- ❌ NO runtime server logic (static mode only)
- ❌ NO hardcoded data arrays in UI components
- ✅ YES to pre-rendering and SSG
- ✅ YES to pure Dart for everything

## SpecKit Integration

This project uses [SpecKit](https://github.com/Stitch-Digital/spec-kit) for structured development workflows:

- Feature specifications: `specs/[feature-name]/spec.md`
- Implementation plans: `specs/[feature-name]/plan.md`
- Current active plan: `specs/004-architecture-refactor/plan.md`

**When making architecture decisions, always reference the current plan for context.**

## Testing

- Use `jaspr_test ^0.23.2` for component testing
- Minimal tests for static pages
- Focus on model validation and component rendering

## Code Review Checklist

Before committing:
1. ✅ All components are type-safe with explicit models
2. ✅ No hardcoded data in presentation components
3. ✅ Content changes go in `content/` directory
4. ✅ Tests pass (`dart test`)
5. ✅ Build succeeds (`jaspr build`)
6. ✅ Performance targets met (use Lighthouse)

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan:
`specs/004-architecture-refactor/plan.md`
<!-- SPECKIT END -->
