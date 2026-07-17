# Content Authoring Guide

Welcome to the content directory for subhojit.build! This guide will help you add and edit blog posts, projects, career entries, and certifications.

## Quick Start: Add a Blog Post in 5 Minutes

### Step 1: Create a New Markdown File

Navigate to `content/blog/` and create a file with a kebab-case slug:

```
content/blog/my-awesome-post.md
```

**File naming rules**:
- Lowercase letters, numbers, and hyphens only
- No spaces or special characters
- Slug becomes the URL: `/blog/my-awesome-post`

### Step 2: Add Frontmatter

At the top of your file, add YAML frontmatter between `---` delimiters:

```yaml
---
title: "My Awesome Blog Post Title"
date: "2026-07-18"
excerpt: "A brief summary of what this post is about. Keep it between 50-300 characters."
category: "Architecture"
layout: blog
---
```

**Required fields**:
- `title`: Post title (appears as h1 and in listings)
- `date`: Publication date in YYYY-MM-DD format (ISO 8601)
- `excerpt`: Short summary for listing pages (50-300 characters)
- `category`: One of: `Architecture`, `Performance`, `State Management`, `DevOps`, `UI & Animations`, `Testing`, `Web`
- `layout`: Always `blog` for blog posts

### Step 3: Write Your Content

After the closing `---`, write your blog post in Markdown:

````markdown
---
title: "My Awesome Blog Post Title"
date: "2026-07-18"
excerpt: "A brief summary of what this post is about."
category: "Architecture"
layout: blog
---

# Introduction

Welcome to my blog post! This is where your content starts.

## Section 1: Main Topic

Your content here with **bold** and *italic* text.

## Section 2: Code Examples

```dart
void main() {
  print('Hello, Jaspr!');
}
```

## Conclusion

Thanks for reading!
````

### Step 4: Preview Locally

Run the development server:

```bash
jaspr serve
```

Open `http://localhost:8080/blog/my-awesome-post` in your browser.

**Hot reload is enabled** — changes to your `.md` file automatically refresh!

### Step 5: Build for Production

```bash
jaspr build
```

Your post is now in `build/web/blog/my-awesome-post/index.html`

## Optional Frontmatter Fields

```yaml
tags:
  - dart
  - jaspr
  - web
featured: true
readMin: "10 min read"
imageColor: "#d1e6f2"
author: "Subhojit Pramanik"
authorImage: "/assets/avatar.png"
description: "Custom SEO description"
keywords:
  - dart
  - jaspr
image: "/assets/blog/og-image.png"
```

## Markdown Syntax Reference

### Headings

```markdown
# Heading 1
## Heading 2
### Heading 3
```

### Text Formatting

```markdown
**Bold**
*Italic*
***Bold and italic***
`Inline code`
```

### Links

```markdown
[Link text](https://example.com)
[Relative link](/blog/other-post)
```

### Images

```markdown
![Alt text](/assets/images/photo.png)
```

### Lists

```markdown
- Item 1
- Item 2
  - Nested item

1. Numbered item 1
2. Numbered item 2
```

### Code Blocks

````markdown
```dart
void main() {
  print('Syntax-highlighted Dart code');
}
```
````

## Common Issues

### Post doesn't appear

- Check file is in `content/blog/`
- Verify `.md` extension
- Ensure all required frontmatter fields present
- Verify `layout: blog` is set

### Build fails with YAML error

- Ensure frontmatter between `---` delimiters
- Check YAML syntax (proper indentation, no tabs)
- Quote strings with special characters: `title: "Architecture: Basics"`

### Hot reload doesn't work

- Ensure running `jaspr serve` (not `jaspr build`)
- Check file is saved
- Try manual browser refresh

## Content Organization

```
content/
├── blog/              # Blog posts
│   ├── sample-post.md
│   └── index.md      # Optional listing page
├── projects/         # Future: Project case studies
├── career/           # Future: Career timeline
└── certifications/   # Future: Certifications
```

## Complete Schema Reference

For the full frontmatter schema specification, see:
- [Blog Post Schema Contract](../specs/002-content-setup/contracts/blog-post-schema.md)
- [Data Model Documentation](../specs/002-content-setup/data-model.md)

## Getting Help

- **Quickstart Guide**: [specs/002-content-setup/quickstart.md](../specs/002-content-setup/quickstart.md)
- **GitHub Issues**: [subhojit1stjuly/subhojit.build/issues](https://github.com/subhojit1stjuly/subhojit.build/issues)
