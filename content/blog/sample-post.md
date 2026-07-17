---
title: "Welcome to jaspr_content: Infrastructure Setup Complete"
date: "2026-07-18"
excerpt: "This sample post validates that jaspr_content is properly configured and can load blog content from Markdown files with frontmatter."
category: "Web"
tags:
  - jaspr
  - dart
  - content-management
  - static-site
featured: true
readMin: "5 min read"
imageColor: "#d1e6f2"
layout: blog
description: "Sample blog post demonstrating jaspr_content infrastructure setup with Markdown parsing, frontmatter extraction, and static site generation."
keywords:
  - jaspr
  - jaspr_content
  - dart web framework
  - static site generator
---

# Welcome to jaspr_content

This is a sample blog post that validates the jaspr_content infrastructure setup for the subhojit.build portfolio website.

## What This Post Demonstrates

This post proves that:

1. **Markdown files** are successfully loaded from the `content/blog/` directory
2. **Frontmatter parsing** extracts metadata (title, date, category, tags, etc.)
3. **Static site generation** works correctly with `jaspr build`
4. **Hot reload** enables live content updates during development
5. **Hybrid mode** allows mixing file-based content with existing hardcoded posts

## Technical Implementation

The jaspr_content package provides:

- **FilesystemLoader**: Reads `.md` files from the content directory
- **MemoryLoader**: Preserves existing hardcoded blog posts as fallback
- **MarkdownParser**: Parses frontmatter and converts Markdown to HTML
- **ContentApp**: Integrates content loading into the Jaspr app lifecycle

## Architecture Benefits

By externalizing content to Markdown files:

- ✅ Content updates don't require code redeployment
- ✅ Non-developers can edit content using any text editor
- ✅ Version control tracks content changes separately from code
- ✅ Hot reload provides instant feedback during content editing

## Next Steps

With the infrastructure validated, the next phase will:

1. Migrate existing hardcoded blog posts to Markdown files
2. Remove MemoryLoader dependency
3. Implement dynamic blog listing using `context.pages`
4. Add category filtering and tag-based navigation

## Code Example

Here's how the sample post is loaded:

```dart
ContentApp.custom(
  loaders: [
    FilesystemLoader('content'),  // Loads this file
    MemoryLoader(pages: [         // Fallback for existing posts
      // ... existing hardcoded articles
    ]),
  ],
  eagerlyLoadAllPages: true,
  configResolver: PageConfig.all(parsers: [MarkdownParser()]),
)
```

## Conclusion

If you're reading this post on the live site, it means the jaspr_content infrastructure is working correctly! 🎉

The hybrid approach (filesystem + memory) provides a safe migration path from hardcoded content to file-based content management.
