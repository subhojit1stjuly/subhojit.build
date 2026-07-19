# Quickstart: Adding Content to subhojit.build

**Feature**: 002-content-setup  
**Audience**: Content authors, future maintainers  
**Date**: 2026-07-18

## Overview

This guide shows you how to add new blog posts, projects, career entries, and certifications to the website using the jaspr_content system.

---

## Prerequisites

- Dart SDK ^3.10.0 installed
- Project cloned locally
- Familiarity with Markdown syntax
- Basic understanding of YAML frontmatter

---

## Quick Start: Add a Blog Post in 5 Minutes

### Step 1: Create a New Markdown File

Navigate to the `content/blog/` directory and create a new file with a kebab-case slug:

```bash
content/blog/my-awesome-post.md
```

**File naming rules**:
- Use lowercase letters, numbers, and hyphens only
- No spaces or special characters
- Slug becomes the URL: `/blog/my-awesome-post`

---

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

**Required fields explained**:
- `title`: Your post title (appears as h1 and in listings)
- `date`: Publication date in YYYY-MM-DD format (ISO 8601)
- `excerpt`: Short summary for listing pages (50-300 characters)
- `category`: One of: `Architecture`, `Performance`, `State Management`, `DevOps`, `UI & Animations`, `Testing`, `Web`
- `layout`: Always `blog` for blog posts

---

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

---

### Step 4: Preview Your Post Locally

Run the development server:

```bash
jaspr serve
```

Open your browser to `http://localhost:8080/blog/my-awesome-post`

**Hot reload is enabled** — any changes to your `.md` file will automatically refresh in the browser!

---

### Step 5: Build for Production

When you're ready to deploy:

```bash
jaspr build
```

Your post is now part of the static site in `build/web/blog/my-awesome-post/index.html`

---

## Optional Frontmatter Fields

Enhance your blog post with optional fields:

```yaml
---
title: "My Awesome Blog Post Title"
date: "2026-07-18"
excerpt: "A brief summary of what this post is about."
category: "Architecture"
layout: blog

# Optional fields below:
tags:
  - dart
  - jaspr
  - web
featured: true
readMin: "10 min read"
imageColor: "#d1e6f2"
author: "Subhojit Pramanik"
authorImage: "/assets/avatar.png"
description: "Custom SEO description different from excerpt"
keywords:
  - dart
  - jaspr
  - web framework
image: "/assets/blog/my-post-og.png"
---
```

**Optional fields explained**:
- `tags`: List of tags for filtering (lowercase, kebab-case)
- `featured`: Set to `true` to highlight this post (shown first in listing)
- `readMin`: Reading time estimate (e.g., `"8 min read"`)
- `imageColor`: Hex color for card background in listing (default: `#e5deff`)
- `author`: Override site default author
- `authorImage`: Override site default author avatar
- `description`: Custom SEO meta description (defaults to excerpt)
- `keywords`: SEO keywords list (legacy SEO, optional)
- `image`: Open Graph image for social sharing (1200×630px recommended)

---

## Full Example: Featured Blog Post

```markdown
---
title: "Deep Dive into Jaspr Content Management"
date: "2026-07-18"
excerpt: "Explore how jaspr_content enables content-driven static sites with hot reload, markdown parsing, and flexible frontmatter schemas."
category: "Web"
tags:
  - jaspr
  - content-management
  - static-site
  - markdown
featured: true
readMin: "15 min read"
imageColor: "#e5deff"
author: "Subhojit Pramanik"
authorImage: "/assets/avatar.png"
layout: blog
description: "Complete guide to jaspr_content architecture, static generation pipeline, and content authoring best practices."
keywords:
  - jaspr
  - static site generator
  - markdown
  - dart web
image: "/assets/blog/jaspr-content-deep-dive.png"
---

# Introduction

In this post, we'll explore the jaspr_content package and how it powers static content-driven websites...

## What is jaspr_content?

jaspr_content is a content management system built for Jaspr...

## Setting Up Your First Blog

Here's how to get started...

### Prerequisites

Before diving in, make sure you have...

## Advanced Features

### Hot Reload

One of the best features of jaspr_content...

### Custom Layouts

You can create custom page layouts...

## Conclusion

jaspr_content provides a powerful foundation...
```

---

## Markdown Syntax Reference

### Headings

```markdown
# Heading 1 (h1)
## Heading 2 (h2)
### Heading 3 (h3)
#### Heading 4 (h4)
```

### Text Formatting

```markdown
**Bold text**
*Italic text*
***Bold and italic***
~~Strikethrough~~
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
![Alt text with title](/assets/images/photo.png "Image Title")
```

### Lists

```markdown
- Unordered list item 1
- Unordered list item 2
  - Nested item

1. Ordered list item 1
2. Ordered list item 2
   1. Nested ordered item
```

### Code Blocks

````markdown
```dart
void main() {
  print('Syntax-highlighted Dart code');
}
```

```javascript
console.log('JavaScript example');
```

```
Plain code block without syntax highlighting
```
````

### Blockquotes

```markdown
> This is a blockquote.
> It can span multiple lines.
```

### Horizontal Rule

```markdown
---
```

---

## Common Pitfalls & Troubleshooting

### Problem: Post doesn't appear in listing

**Solution**: Check that:
1. File is in `content/blog/` directory
2. File has `.md` extension
3. Frontmatter has all required fields
4. `layout: blog` is set
5. File doesn't start with `_` or `.` (private files)

---

### Problem: Build fails with YAML parsing error

**Solution**: 
1. Ensure frontmatter is between `---` delimiters
2. Check YAML syntax (proper indentation, no tabs)
3. Strings with colons/special characters need quotes: `title: "Architecture: The Basics"`
4. Lists use proper format:
   ```yaml
   tags:
     - tag1
     - tag2
   ```

---

### Problem: Hot reload doesn't work

**Solution**:
1. Ensure you're running `jaspr serve` (not `jaspr build`)
2. Check that the file is saved
3. Try refreshing the browser manually
4. Check terminal for errors

---

### Problem: Featured post not showing first

**Solution**: 
- Set `featured: true` (boolean, not string `"true"`)
- Check that listing component sorts by featured flag
- Verify no YAML syntax error on the `featured:` line

---

### Problem: Wrong category or tags

**Solution**:
- **Category**: Must be one of predefined categories (see contract)
- **Tags**: Must be list format:
  ```yaml
  tags:
    - dart
    - jaspr
  ```
- **NOT**:
  ```yaml
  tags: dart, jaspr  # ❌ Wrong format
  ```

---

## Content Organization

### Directory Structure

```
content/
├── blog/                    # Blog posts
│   ├── sample-post.md
│   ├── flutter-architecture.md
│   └── index.md            # Optional listing page
├── projects/               # Future: Project case studies
├── career/                 # Future: Career timeline entries
└── certifications/         # Future: Certifications & courses
```

### URL Mapping

| File | URL |
|------|-----|
| `content/blog/my-post.md` | `/blog/my-post` |
| `content/blog/index.md` | `/blog` |
| `content/blog/2026/january-update.md` | `/blog/2026/january-update` |

---

## Advanced: Custom Data Fields

You can add custom fields to frontmatter that aren't part of the official schema:

```yaml
---
title: "My Post"
date: "2026-07-18"
excerpt: "Summary"
category: "Web"
layout: blog

# Custom fields:
series: "Jaspr Mastery"
seriesPart: 1
relatedPosts:
  - /blog/related-post-1
  - /blog/related-post-2
---
```

Access custom fields in components:

```dart
final series = post.data.page['series'] as String?;
final seriesPart = post.data.page['seriesPart'] as int?;
```

⚠️ **Warning**: Custom fields are not validated and may break if you misspell them. Document custom fields if you use them extensively.

---

## Next Steps

- Read `contracts/blog-post-schema.md` for complete field reference
- Read `data-model.md` for runtime representation and querying
- Explore existing posts in `content/blog/` for more examples
- Join the discussion: [GitHub Discussions](https://github.com/subhojit1stjuly/subhojit.build/discussions)

---

## Need Help?

- **Documentation**: See `content/README.md`
- **Schema Reference**: See `specs/002-content-setup/contracts/blog-post-schema.md`
- **Data Model**: See `specs/002-content-setup/data-model.md`
- **Issues**: [GitHub Issues](https://github.com/subhojit1stjuly/subhojit.build/issues)
