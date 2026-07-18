# Contract: Blog Post Frontmatter Schema

**Feature**: 002-content-setup  
**Version**: 1.0.0  
**Date**: 2026-07-18  
**Status**: Active

## Purpose

This contract defines the required and optional frontmatter fields for blog posts in the `content/blog/` directory. All blog post Markdown files MUST conform to this schema to be correctly parsed, rendered, and listed by the jaspr_content system.

---

## Contract Scope

**Applies to**: All `.md` files in `content/blog/` directory (except `index.md`)

**Enforced by**: 
- Content authors (manual adherence)
- Future validation tooling (linting, CI checks)
- jaspr_content MarkdownParser (runtime parsing)

**Consumers**:
- jaspr_content `BlogLayout` (renders blog post pages)
- Blog listing components (query and display posts)
- SEO meta tag generation
- RSS feed generation (future)
- Sitemap generation

---

## Schema Definition

### Required Fields

All blog posts MUST include these fields:

```yaml
title: String              # 1-200 characters; post title
date: String               # ISO 8601 format (YYYY-MM-DD) or readable (Month DD, YYYY)
excerpt: String            # 50-300 characters; summary for listing pages
category: String           # One of predefined categories (see below)
layout: "blog"             # Must be literal string "blog"
```

### Optional Fields

Blog posts MAY include these fields (defaults apply if omitted):

```yaml
tags: List<String>         # Default: [] (empty list)
featured: Boolean          # Default: false
readMin: String            # Default: "" (empty string) — e.g., "8 min read"
imageColor: String         # Default: "#e5deff" — valid hex color for card background
author: String             # Default: site author (from _data/site.yaml or global config)
authorImage: String        # Default: site author image — URL or asset path
description: String        # Default: uses excerpt value — SEO meta description
keywords: List<String>     # Default: [] (empty list) — SEO meta keywords
image: String              # Default: site default OG image — Open Graph image URL
```

---

## Field Specifications

### `title` (Required)
- **Type**: String
- **Constraints**: 
  - Length: 1-200 characters
  - No leading/trailing whitespace
  - HTML special characters will be escaped in output
- **Used in**:
  - `<title>` tag
  - `<h1>` in BlogLayout
  - `og:title` meta tag
  - Blog listing cards
- **Example**: `"Clean Architecture in Flutter: A Production Guide"`

---

### `date` (Required)
- **Type**: String
- **Format Options**:
  - ISO 8601: `"YYYY-MM-DD"` (e.g., `"2026-07-18"`) — **RECOMMENDED** for sortability
  - Readable: `"Month DD, YYYY"` (e.g., `"July 18, 2026"`)
- **Used in**:
  - Sorting posts chronologically
  - Display date in blog post header
  - Sitemap `lastmod` field
- **Example**: `"2026-07-18"`

---

### `excerpt` (Required)
- **Type**: String
- **Constraints**:
  - Length: 50-300 characters (guideline, not enforced)
  - Should be a complete sentence or two
  - No markdown formatting (plain text)
- **Used in**:
  - Blog listing card descriptions
  - SEO meta description (if `description` field omitted)
  - RSS feed descriptions (future)
- **Example**: `"How to structure large Flutter apps with Clean Architecture so your codebase stays maintainable as the team and feature-set grow."`

---

### `category` (Required)
- **Type**: String
- **Allowed Values**:
  - `"Architecture"`
  - `"Performance"`
  - `"State Management"`
  - `"DevOps"`
  - `"UI & Animations"`
  - `"Testing"`
  - `"Web"`
- **Used in**:
  - Category badge/tag in listing cards
  - Filtering posts by category
  - Taxonomy sidebar counts
- **Example**: `"Architecture"`
- **⚠️ Breaking Change Policy**: Adding new categories is a **minor version bump** to this contract. Existing posts are not affected.

---

### `layout` (Required)
- **Type**: String
- **Allowed Values**: `"blog"` (literal string)
- **Used in**: jaspr_content PageLayout selection
- **Example**: `"blog"`
- **Rationale**: Explicit layout selection required by jaspr_content. Future layouts (e.g., `"docs"`, `"project"`) may be added.

---

### `tags` (Optional)
- **Type**: List of Strings
- **Default**: `[]` (empty list)
- **Constraints**:
  - Each tag: lowercase, kebab-case (e.g., `"flutter"`, `"state-management"`)
  - No duplicates within a post
  - No predefined tag list (open-ended)
- **Used in**:
  - Tag pills below blog post content
  - Filtering posts by tag
  - Related posts suggestions (future)
- **Example**: `["dart", "jaspr", "web", "static-site"]`

---

### `featured` (Optional)
- **Type**: Boolean
- **Default**: `false`
- **Used in**: Highlighting featured posts in blog listing (shown first, larger card)
- **Example**: `true`

---

### `readMin` (Optional)
- **Type**: String
- **Default**: `""` (empty string — not displayed if omitted)
- **Format**: Free-form string, typically `"X min read"`
- **Used in**: Blog post header and listing cards (combined with date)
- **Example**: `"12 min read"`
- **Future**: May be auto-calculated from word count

---

### `imageColor` (Optional)
- **Type**: String
- **Default**: `"#e5deff"` (primary-fixed color from theme)
- **Format**: Hex color code (6 or 3 digits with `#` prefix)
- **Used in**: Background color for blog listing card image placeholder
- **Example**: `"#d1e6f2"`
- **Rationale**: Matches existing hardcoded blog design; provides visual variety in listing

---

### `author` (Optional)
- **Type**: String
- **Default**: Site author (from global config or `_data/site.yaml`)
- **Used in**: BlogLayout author byline below title
- **Example**: `"Subhojit Pramanik"`

---

### `authorImage` (Optional)
- **Type**: String (URL or asset path)
- **Default**: Site author image (from global config)
- **Format**: Absolute URL or relative path to asset (e.g., `/assets/avatar.png`)
- **Used in**: Circular author avatar in BlogLayout
- **Example**: `"/assets/avatar.png"`

---

### `description` (Optional)
- **Type**: String
- **Default**: Uses `excerpt` value
- **Used in**: `<meta name="description">` and `og:description` tags
- **Example**: `"Step-by-step guide to integrating jaspr_content with static site generation."`
- **Rationale**: Allows SEO description to differ from excerpt if needed

---

### `keywords` (Optional)
- **Type**: List of Strings
- **Default**: `[]` (empty list)
- **Used in**: `<meta name="keywords">` tag
- **Example**: `["flutter", "architecture", "clean-code"]`
- **Note**: Modern SEO gives low weight to keywords; primarily for legacy SEO

---

### `image` (Optional)
- **Type**: String (URL or asset path)
- **Default**: Site default Open Graph image
- **Format**: Absolute URL or relative path to image (e.g., `/assets/og-images/post.png`)
- **Used in**: `og:image` and `twitter:image` meta tags
- **Example**: `"/assets/blog/jaspr-content-og.png"`
- **Recommended Size**: 1200×630px for optimal social sharing

---

## Complete Example

```yaml
---
title: "Setting Up jaspr_content for Static Sites"
date: "2026-07-18"
excerpt: "Learn how to configure jaspr_content for a static Jaspr website with hot reload and content management."
category: "Web"
tags:
  - jaspr
  - dart
  - static-site
  - content-management
featured: true
readMin: "12 min read"
imageColor: "#d1e6f2"
author: "Subhojit Pramanik"
authorImage: "/assets/avatar.png"
layout: blog
description: "Step-by-step guide to integrating jaspr_content with static site generation, including directory setup, frontmatter schemas, and hot reload configuration."
keywords:
  - jaspr
  - static site generator
  - dart web framework
image: "/assets/blog/jaspr-content-og.png"
---
```

---

## Minimal Valid Example

```yaml
---
title: "My First Blog Post"
date: "2026-07-18"
excerpt: "This is a brief summary of my first blog post on this site."
category: "Web"
layout: blog
---
```

---

## Validation

### Pre-commit Validation (Future)

Future CI/CD pipeline should validate:
1. All required fields present
2. `date` is valid ISO 8601 or readable format
3. `category` matches allowed values
4. `imageColor` is valid hex color (if present)
5. `featured` is boolean (if present)
6. `tags` is list of strings (if present)
7. YAML is well-formed

**Suggested Tooling**: 
- Dart script using `yaml` package
- GitHub Actions workflow
- Pre-commit hook

### Runtime Validation (jaspr_content)

jaspr_content performs minimal validation:
- ✅ YAML must be parseable
- ✅ File must be valid Markdown
- ⚠️ Frontmatter fields are NOT type-checked (stored as `Map<String, Object?>`)
- ⚠️ Missing required fields result in empty strings or null at runtime

**Defensive Access Pattern** (in components):
```dart
final title = post.data.page['title'] as String? ?? 'Untitled';
final date = post.data.page['date'] as String? ?? '';
final featured = post.data.page['featured'] == true;  // handles null
```

---

## Backward Compatibility

**Adding optional fields**: ✅ Non-breaking — defaults apply to existing posts

**Adding required fields**: ❌ Breaking — requires updating all existing posts

**Changing field types**: ❌ Breaking — requires migration script

**Removing fields**: ⚠️ Breaking if still consumed by components — deprecation notice required

**Category taxonomy changes**:
- Adding new category: ✅ Non-breaking (minor version bump)
- Renaming category: ❌ Breaking — requires updating all posts using old name
- Removing category: ❌ Breaking — requires updating/recategorizing affected posts

---

## Contract Versioning

**Current Version**: 1.0.0

**Version Bumps**:
- **MAJOR (X.0.0)**: Breaking changes (new required fields, type changes, field removal)
- **MINOR (1.X.0)**: Non-breaking additions (new optional fields, new categories)
- **PATCH (1.0.X)**: Clarifications, examples, documentation fixes

**Version History**:
- `1.0.0` (2026-07-18): Initial schema for 002-content-setup feature

---

## Migration Guide (Future)

When this contract changes, provide migration scripts and documentation:

**Example**: Adding new required field `publishedAt`
1. **Migration script**: Add `publishedAt: <date>` to all existing .md files based on existing `date` field
2. **Deprecation period**: Support both `date` and `publishedAt` for N releases
3. **Final migration**: Remove `date` field entirely after deprecation

---

## Contract Enforcement

**Responsibilities**:
- **Content Authors**: Follow schema when creating/editing blog posts
- **Code Reviewers**: Verify new blog posts conform to schema
- **CI/CD Pipeline** (future): Automated validation on PR
- **Component Developers**: Use defensive access patterns for frontmatter data

**Non-Conforming Content**:
- Missing required field → Post may not render correctly, appears as "Untitled" or with empty date
- Invalid category → May appear in "Other" or "Uncategorized" filter group
- Malformed YAML → Build fails with parsing error (caught at build time)

---

## Related Documents

- `specs/002-content-setup/data-model.md` — Runtime representation and querying
- `specs/002-content-setup/quickstart.md` — Step-by-step content creation guide
- `content/README.md` — Content author documentation
