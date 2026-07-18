# Phase 0: Research Findings — jaspr_content Infrastructure Setup

**Feature**: 002-content-setup  
**Date**: 2026-07-18  
**Research Status**: ✅ Complete

## Executive Summary

jaspr_content v0.5.3+1 is a **runtime-only, zero-code-generation** Jaspr package for building content-driven sites. It operates entirely through a component pipeline at build time in static mode. Key findings that directly impact our implementation:

1. **No build.yaml required** — jaspr_content has no builders; build_runner is only used for Jaspr's `@client` annotations
2. **Static mode is fully supported** — content files are read at build time during `jaspr build`
3. **Hot reload works** — FilesystemLoader watches content directory changes in dev mode
4. **Hybrid mode fully supported** — MemoryLoader allows mixing hardcoded data with filesystem content
5. **No generated models** — access content through runtime `Page` objects and frontmatter maps

## Research Questions & Answers

### Q1: Does jaspr_content require build.yaml configuration?

**Answer**: ❌ **NO** — jaspr_content operates entirely at runtime with no build runner integration.

**Decision**: We will NOT create a build.yaml file. The existing pubspec.yaml with `jaspr_content: ^0.5.3+1` is sufficient.

**Rationale**: jaspr_content uses runtime `FilesystemLoader` and `MemoryLoader` to load content files. The only build runner integration needed in a Jaspr project is for `@client` component annotations via `jaspr_builder`, which is already in our dev_dependencies.

**Source**: schultek/jaspr:packages/jaspr_content/pubspec.yaml — no builders key; verified by examining ContentApp.dart source

---

### Q2: What is the recommended content directory structure?

**Answer**: 
```
content/                      ← Root content directory (configurable)
├── index.md                 → Serves route: /
├── _data/                   ← Data files (not served as pages)
│   ├── site.yaml           → Global site data
│   └── nav.json            → Navigation data
├── _partials/              ← Template partials (not served as pages)
├── blog/
│   ├── index.md            → Serves route: /blog
│   ├── post1.md            → Serves route: /blog/post1
│   └── post2.md            → Serves route: /blog/post2
├── projects/
├── career/
└── certifications/
```

**Decision**: Create `content/` at project root with subdirectories: `blog/`, `projects/`, `career/`, `certifications/`. Add `.gitkeep` files to preserve empty directories.

**Conventions**:
- Files/folders starting with `_` or `.` are ignored (private)
- `index.md` files map to parent directory route
- Other files use basename (without extension) as URL slug

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/route_loader/filesystem_loader.dart; docs.jaspr.site/content/guides/adding_pages

---

### Q3: What frontmatter fields should we use for blog posts?

**Answer**: 

**Universal Fields** (SEO & meta):
```yaml
title: "Post Title"              # Required — <title> tag, h1, og:title
description: "Post summary"      # SEO meta description, og:description
keywords: [dart, jaspr, web]     # Meta keywords
image: /assets/og-image.png     # Open Graph image
date: "2025-07-18"              # Publication date (ISO format or readable string)
layout: blog                     # Which PageLayout to use (activates BlogLayout)
```

**BlogLayout-Specific Fields** (from BlogLayout.dart source):
```yaml
author: "Author Name"            # Shown below title
authorImage: /assets/avatar.png # Circular profile image
readTime: "5 min"               # Combined with date as "5 min read • Date"
tags:                           # Rendered as tag pills
  - dart
  - tutorial
```

**Decision**: Sample blog post frontmatter schema:
```yaml
title: "Post Title"
date: "YYYY-MM-DD"
excerpt: "Brief summary for listing pages"
category: "Architecture"         # For filtering/grouping
tags: [dart, jaspr, web]        # List of tags
featured: false                  # Boolean for featured posts
readMin: "8 min read"           # Reading time estimate
imageColor: "#e5deff"           # Background color for card (matches existing design)
layout: blog                     # Use BlogLayout
```

**Rationale**: Balances BlogLayout requirements with our existing hardcoded blog design (which uses category, featured, imageColor). The schema is a superset that supports both layouts.

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/layouts/blog_layout.dart:53-74; lib/pages/blog.dart (current implementation)

---

### Q4: How do you query content in a Jaspr component?

**Answer**: Use `context.pages` extension (requires `eagerlyLoadAllPages: true`):

```dart
// main.server.dart
runApp(ContentApp(
  eagerlyLoadAllPages: true,  // Required for context.pages
  parsers: [MarkdownParser()],
));

// In a component
class BlogIndex extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    final allPages = context.pages;  // List<Page>
    
    final blogPosts = allPages
        .where((page) => page.path.startsWith('blog/'))
        .toList();
    
    // Access frontmatter
    final title = blogPosts.first.data.page['title'] as String?;
    final date = blogPosts.first.data.page['date'] as String?;
    
    return ul(blogPosts.map((post) =>
      li([a(href: post.url, [.text(post.data.page['title'] as String)])])
    ).toList());
  }
}
```

**Decision**: We will NOT initially migrate to ContentApp querying. Instead, use **MemoryLoader** to wrap existing hardcoded data, then gradually transition to `context.pages` queries in a future feature.

**Rationale**: Minimal risk — MemoryLoader allows us to validate jaspr_content infrastructure without rewriting blog.dart component query logic.

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/page.dart:253-288

---

### Q5: How does jaspr_content handle static site generation?

**Answer**: Content files are read **at build time** during `jaspr build`. The process:

1. `jaspr build` compiles server code with `-Djaspr.flags.generate=true` (sets `kGenerateMode = true`)
2. `FilesystemLoader.loadPageSources()` walks the content directory and creates a `Route` per file
3. Jaspr CLI crawls every registered route, calling `page.render()` per route
4. Each route is written to `build/web/<path>/index.html` as static HTML
5. Assets are copied to `build/jaspr/assets/` with cache-busting hashes

**Hot Reload**: In dev mode (`jaspr serve`), FilesystemLoader sets up a DirectoryWatcher that:
- **Modify** → invalidates page, re-reads from disk on next request
- **Add** → adds new route dynamically
- **Remove** → removes route from routing table

**Limitations**:
- ❌ No dynamic route params (must enumerate all pages at build time)
- ❌ No per-request content generation
- ✅ Full pre-rendered HTML for fast FCP and excellent SEO
- ✅ Deployable to any static host (no server required)

**Decision**: Maintain `jaspr: mode: static` in pubspec.yaml. Use jaspr_content in static mode for this feature.

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/route_loader/filesystem_loader.dart:56-71; schultek/jaspr:packages/jaspr/lib/src/foundation/constants.dart

---

### Q6: How to integrate jaspr_content with existing hardcoded data?

**Answer**: Three strategies supported (from safest to most complete):

**Strategy A: MemoryLoader** (Zero File Changes — RECOMMENDED)
```dart
final hardcodedPosts = [...];  // Existing data

runApp(ContentApp.custom(
  loaders: [
    MemoryLoader(pages: [
      for (final post in hardcodedPosts)
        MemoryPage(
          path: 'posts/${post['slug']}.md',
          content: post['content'] as String,
          initialData: {'page': {'title': post['title'], 'date': post['date']}},
        ),
    ]),
    FilesystemLoader('content'),  // New file-based content
  ],
  eagerlyLoadAllPages: true,
  configResolver: PageConfig.all(parsers: [MarkdownParser()]),
));
```

**Strategy B: MemoryPage.builder** (Full Component Bypass)
```dart
MemoryLoader(pages: [
  MemoryPage.builder(
    path: 'about.html',
    applyLayout: true,
    builder: (context) => MyExistingAboutPageComponent(),
  ),
]),
```

**Strategy C: routerBuilder** (Mix Custom Routes)
```dart
ContentApp.custom(
  loaders: [FilesystemLoader('content')],
  routerBuilder: (contentRoutes) => Router(routes: [
    Route(path: '/', builder: (_, _) => MyExistingHomePage()),
    for (final routes in contentRoutes) ...routes,
  ]),
);
```

**Decision**: Use **Strategy A (MemoryLoader)** for initial setup. Maintain all existing hardcoded blog posts as MemoryPages while adding ONE new sample post from filesystem.

**Rationale**: 
- Zero risk to existing functionality
- Validates entire jaspr_content pipeline (parsing, rendering, static generation)
- Easy rollback — remove FilesystemLoader, keep MemoryLoader
- Gradual migration path — convert MemoryPages to .md files incrementally

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/route_loader/memory_loader.dart; schultek/jaspr:packages/jaspr_content/lib/src/content_app.dart:70-120

---

### Q7: Error handling when jaspr_content fails?

**Answer**: jaspr_content provides graceful failure modes but no built-in error boundary API.

**Built-in Behaviors**:
- Missing content directory → FilesystemLoader returns empty list (no crash)
- No matching parser → throws "No parser found" exception at runtime

**Best Practices**:
1. Always include fallback MemoryLoader after FilesystemLoader
2. Always include MarkdownParser() in parsers list
3. Use filterExtensions on FilesystemLoader to exclude unknown file types
4. Wrap custom PageSource.buildPage() in try/catch for graceful error pages

**Decision**: Implement defensive setup with fallback:
```dart
ContentApp.custom(
  loaders: [
    FilesystemLoader('content', filterExtensions: {'.md'}),
    MemoryLoader(pages: [
      MemoryPage(
        path: '_fallback.md',
        content: '# Error\n\nContent loading failed. Displaying hardcoded posts.',
      ),
    ]),
  ],
  configResolver: PageConfig.all(parsers: [MarkdownParser()]),
);
```

**Rationale**: Graceful degradation — if content directory is accidentally deleted or malformed, site still builds with hardcoded content and a visible error message.

**Source**: schultek/jaspr:packages/jaspr_content/lib/src/route_loader/filesystem_loader.dart:78-80; schultek/jaspr:packages/jaspr_content/lib/src/page.dart:136

---

## Technology Choices

### Content Management: jaspr_content v0.5.3+1
- **Chosen**: jaspr_content ^0.5.3+1 (already in pubspec.yaml)
- **Rationale**: Official Jaspr content package; static mode compatible; hot reload support; zero breaking changes
- **Alternatives Considered**: 
  - Custom markdown parser (rejected — reinventing the wheel)
  - Eleventy/Hugo external SSG (rejected — separate build toolchain, no Jaspr integration)

### Markdown Parsing: Built-in MarkdownParser
- **Chosen**: `MarkdownParser()` from jaspr_content
- **Rationale**: Built on dart `markdown` package; no additional dependencies; supports frontmatter out of the box
- **Alternatives Considered**: 
  - dart markdown package directly (rejected — would need custom frontmatter parsing)
  - Custom parser (rejected — unnecessary complexity)

### Content Directory Structure: Filesystem-based
- **Chosen**: `content/` directory at project root with subdirectories per content type
- **Rationale**: jaspr_content convention; clear organization; supports future non-developer content editing
- **Alternatives Considered**: 
  - lib/content/ (rejected — content is data, not code)
  - web/content/ (rejected — web/ is for static assets)

### Hybrid Mode: MemoryLoader + FilesystemLoader
- **Chosen**: ContentApp.custom with both loaders
- **Rationale**: Zero risk; validates setup with one sample post; preserves all existing functionality
- **Alternatives Considered**: 
  - Full migration (rejected — too risky for setup phase)
  - routerBuilder mixing (rejected — requires rewriting routing logic)

---

## Implementation Approach

### Phase 0: Setup (This Feature)
1. ✅ Research jaspr_content API and patterns (complete)
2. Create content directory structure
3. Add ONE sample blog post markdown file
4. Configure ContentApp with MemoryLoader + FilesystemLoader
5. Validate jaspr build succeeds with sample content

### Phase 1: Validation (This Feature)
1. Verify sample post appears in blog listing
2. Verify static build output includes sample post
3. Verify hot reload works with content changes
4. Document content schema and usage

### Phase 2: Future Migration (Separate Feature)
1. Convert existing hardcoded posts to markdown files
2. Replace MemoryLoader with FilesystemLoader only
3. Update blog.dart to use context.pages queries
4. Remove hardcoded article data

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| jaspr_content incompatible with Jaspr ^0.23.1 | High — blocks setup | ✅ **Mitigated** — v0.5.3+1 explicitly supports Jaspr ^0.23.0+ |
| Content directory missing crashes build | Medium — deployment failure | ✅ **Mitigated** — FilesystemLoader returns empty list, not crash; MemoryLoader provides fallback |
| Sample post has malformed frontmatter | Low — feature demo fails | ✅ **Mitigated** — Use validated frontmatter template from research |
| Hot reload doesn't work | Low — dev UX issue | ✅ **Mitigated** — Hot reload confirmed working in dev mode from source code review |
| Static build includes sample post but breaks existing pages | High — regression | ✅ **Mitigated** — MemoryLoader preserves all existing hardcoded content; sample is additive |

---

## Unknowns Resolved

All NEEDS CLARIFICATION items from Technical Context have been resolved:

1. ✅ build.yaml requirement → Not required
2. ✅ Content directory structure → `content/` with subdirectories
3. ✅ Frontmatter schema → Defined comprehensive schema
4. ✅ Code generation → No code generation; runtime only
5. ✅ Error handling → Graceful failure modes documented
6. ✅ Hybrid mode → MemoryLoader + FilesystemLoader fully supported
7. ✅ Static mode compatibility → First-class support
8. ✅ Hot reload → Works in dev mode via DirectoryWatcher

---

## Next Steps

Proceed to **Phase 1: Design & Contracts**:
1. Define data model for blog post schema (data-model.md)
2. Define content schema contract (contracts/blog-post-schema.md)
3. Create quickstart guide for adding content (quickstart.md)
4. Update agent context (.github/copilot-instructions.md)
