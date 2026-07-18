# Data Model: Blog Post Content Schema

**Feature**: 002-content-setup  
**Date**: 2026-07-18  
**Status**: Design

## Overview

This document defines the data model for blog post content in the jaspr_content system. Blog posts are Markdown files with YAML frontmatter stored in the `content/blog/` directory.

---

## Entity: BlogPost

A blog post is represented by:
1. A Markdown file in `content/blog/<slug>.md`
2. YAML frontmatter containing metadata
3. Markdown body content

**File Naming Convention**: `kebab-case-slug.md` (e.g., `flutter-clean-architecture.md`)

**URL Mapping**: `content/blog/<slug>.md` → Route: `/blog/<slug>`

---

## Frontmatter Schema

### Required Fields

| Field | Type | Description | Example | Constraints |
|-------|------|-------------|---------|-------------|
| `title` | String | Post title (used in h1, title tag, og:title) | `"Clean Architecture in Flutter"` | 1-200 characters |
| `date` | String | Publication date (ISO 8601 or readable format) | `"2025-07-18"` or `"July 18, 2025"` | ISO 8601 preferred for sortability |
| `excerpt` | String | Brief summary for listing pages | `"How to structure large Flutter apps..."` | 50-300 characters |
| `category` | String | Primary category for grouping/filtering | `"Architecture"` | Predefined list (see below) |
| `layout` | String | PageLayout to use (must be `blog` for BlogLayout) | `"blog"` | Always `"blog"` |

### Optional Fields

| Field | Type | Description | Example | Default |
|-------|------|-------------|---------|---------|
| `tags` | List<String> | Tags for filtering and discovery | `["dart", "jaspr", "web"]` | `[]` |
| `featured` | Boolean | Whether post is featured (shown prominently) | `true` | `false` |
| `readMin` | String | Reading time estimate | `"8 min read"` | Auto-calculated or empty |
| `imageColor` | String | Background color for card in listing | `"#e5deff"` | `"#e5deff"` (primary-fixed) |
| `author` | String | Author name (shown below title in BlogLayout) | `"Subhojit Pramanik"` | Site default |
| `authorImage` | String | Author avatar URL (circular image in BlogLayout) | `"/assets/avatar.png"` | Site default |
| `description` | String | SEO meta description (fallback to excerpt) | `"Learn how to..."` | Uses `excerpt` |
| `keywords` | List<String> | SEO meta keywords | `["flutter", "architecture"]` | `[]` |
| `image` | String | Open Graph image URL | `"/assets/og-image.png"` | Site default |

---

## Category Taxonomy

Predefined categories (expandable in future):

- `"Architecture"` — System design, patterns, project structure
- `"Performance"` — Optimization, profiling, benchmarking
- `"State Management"` — Riverpod, Bloc, state patterns
- `"DevOps"` — CI/CD, deployment, tooling
- `"UI & Animations"` — Design, motion, accessibility
- `"Testing"` — Unit, widget, integration tests
- `"Web"` — Web-specific topics (Jaspr, WASM, etc.)

**Validation**: Tasks should validate category against this list; new categories require spec update.

---

## Example: Complete Blog Post

**File**: `content/blog/jaspr-content-setup.md`

```markdown
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

# Setting Up jaspr_content

Jaspr Content is a powerful content management system built specifically for Jaspr applications...

## Prerequisites

Before starting, ensure you have:
- Dart SDK ^3.10.0
- Jaspr ^0.23.1
- jaspr_content ^0.5.3+1

## Step 1: Create Content Directory

Create a `content/` directory at your project root...

<!-- Rest of blog post content -->
```

---

## Runtime Representation

At runtime, a blog post is represented as a `Page` object from jaspr_content:

```dart
class Page {
  final String path;          // 'blog/jaspr-content-setup.md'
  final String url;           // '/blog/jaspr-content-setup'
  final String content;       // Raw markdown body (without frontmatter)
  final PageDataMap data;     // Typed map with .page and .site accessors
  final PageConfig config;    // Parser, layout, extensions
  final RouteLoaderBase loader;
  
  // data.page is Map<String, Object?> containing frontmatter:
  // {
  //   'title': 'Setting Up jaspr_content...',
  //   'date': '2026-07-18',
  //   'excerpt': 'Learn how to configure...',
  //   'category': 'Web',
  //   'tags': ['jaspr', 'dart', 'static-site'],
  //   'featured': true,
  //   'readMin': '12 min read',
  //   'imageColor': '#d1e6f2',
  //   'layout': 'blog',
  //   // ... etc
  // }
}
```

---

## Querying Blog Posts

### Server-Side Components Only (kIsWeb == false)

```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

class BlogIndex extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    // Requires eagerlyLoadAllPages: true in ContentApp
    final allPages = context.pages;
    
    // Filter to blog posts only
    final blogPosts = allPages
        .where((page) => page.path.startsWith('blog/') && page.path != 'blog/index.md')
        .toList();
    
    // Sort by date descending (newest first)
    blogPosts.sort((a, b) {
      final dateA = a.data.page['date'] as String? ?? '';
      final dateB = b.data.page['date'] as String? ?? '';
      return dateB.compareTo(dateA);
    });
    
    // Filter featured posts
    final featured = blogPosts.where((post) => 
      post.data.page['featured'] == true
    ).toList();
    
    return div([
      h2([.text('Featured Posts')]),
      ...featured.map((post) => _renderPostCard(post)),
      h2([.text('All Posts')]),
      ...blogPosts.map((post) => _renderPostCard(post)),
    ]);
  }
  
  Component _renderPostCard(Page post) {
    final title = post.data.page['title'] as String? ?? 'Untitled';
    final excerpt = post.data.page['excerpt'] as String? ?? '';
    final category = post.data.page['category'] as String? ?? '';
    final readMin = post.data.page['readMin'] as String? ?? '';
    final imageColor = post.data.page['imageColor'] as String? ?? '#e5deff';
    final tags = post.data.page['tags'] as List<dynamic>? ?? [];
    
    return a(href: post.url, [
      div(styles: Styles(backgroundColor: Color(imageColor)), [
        span(classes: 'category', [.text(category)]),
        h3([.text(title)]),
        p([.text(excerpt)]),
        span([.text(readMin)]),
        div([
          for (final tag in tags)
            span(classes: 'tag', [.text(tag.toString())]),
        ]),
      ]),
    ]);
  }
}
```

---

## Validation Rules

**File-level validation** (enforced during content creation):
1. Frontmatter must be valid YAML
2. Required fields must be present
3. `date` should be ISO 8601 format for sortability
4. `category` must match predefined taxonomy
5. `imageColor` must be valid hex color
6. `featured` must be boolean
7. `tags` must be list of strings

**Build-time validation** (enforced by jaspr_content):
1. File must be parseable by MarkdownParser
2. `layout: blog` must map to registered BlogLayout
3. Frontmatter keys map to `Map<String, Object?>` (no type checking)

**Runtime defensive access**:
```dart
// Always cast with fallback
final title = post.data.page['title'] as String? ?? 'Untitled';
final featured = post.data.page['featured'] == true;  // handles null/missing
final tags = (post.data.page['tags'] as List<dynamic>?) ?? [];
```

---

## File Organization

```
content/
└── blog/
    ├── index.md                     # Blog listing page (optional)
    ├── sample-post.md               # Sample validation post
    ├── flutter-clean-architecture.md
    ├── p99-tail-latency.md
    └── riverpod-vs-bloc.md
```

**Index page** (`content/blog/index.md`):
- Route: `/blog`
- Optional — if missing, custom BlogIndex component can handle listing
- If present, can contain custom content above/below post listing

---

## Migration Path

**Current State**: Hardcoded `_Article` class in `lib/pages/blog.dart`

```dart
class _Article {
  final String category, readMin, title, excerpt, href, imageColor;
  final bool featured;
}

const _articles = [
  _Article(category: 'Architecture', readMin: '12 min read', ...),
  // ... 5 hardcoded articles
];
```

**Phase 1 (This Feature)**: Add ONE sample post via FilesystemLoader
```dart
ContentApp.custom(
  loaders: [
    FilesystemLoader('content'),  // Loads sample-post.md
    MemoryLoader(pages: [
      // All 5 existing articles as MemoryPages
      for (final article in _articles)
        MemoryPage(path: 'blog/${_slugify(article.title)}.md', ...),
    ]),
  ],
);
```

**Phase 2 (Future Feature)**: Full migration
1. Convert all 5 _Article objects to .md files in content/blog/
2. Remove MemoryLoader
3. Remove _articles hardcoded data
4. Update BlogPage to use context.pages queries

---

## Schema Evolution

When frontmatter schema changes:
1. Update this data-model.md
2. Update contracts/blog-post-schema.md
3. Update quickstart.md examples
4. Add migration notes for existing content files
5. Use backward-compatible defaults for new optional fields

Example: Adding `publishedBy` field (new optional field):
- Old posts without `publishedBy` → default to site author
- New posts include `publishedBy: "Guest Author"` explicitly
- No breaking changes to existing .md files
