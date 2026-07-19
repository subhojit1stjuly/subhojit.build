# Quickstart: Architecture Refactor

## Overview
This refactor transitions the project to a **Content-First Architecture**, strictly separating data from UI. All content is managed as Markdown files with YAML frontmatter in the `content/` directory. UI components receive data through constructors and do not fetch data themselves.

## Folder Structure
- `content/`: Contains all Markdown content (e.g., `blog/`, `career/`, `projects/`).
- `lib/models/`: Contains Dart data models mapping to the content.
- `lib/components/`: Contains pure, "dumb" presentation UI elements.
- `lib/pages/`: The "glue" layer where data is fetched (via `jaspr_content`) and passed to components.

## Adding Content
To add a new blog post, create a Markdown file in `content/blog/` following the schema:
```markdown
---
title: "My New Post"
date: "2026-07-20"
excerpt: "A brief summary."
tags:
  - "Dart"
  - "Jaspr"
---
Markdown content here...
```

## Creating UI Components
When creating or modifying a UI component in `lib/components/`:
- **DO NOT** hardcode lists or perform content fetching logic.
- **DO** accept typed models via the constructor.

Example:
```dart
import 'package:jaspr/jaspr.dart';
import '../models/article.dart';

class ArticleCard extends StatelessComponent {
  final Article article;

  const ArticleCard({required this.article});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'article-card', [
      h3([text(article.title)]),
      p([text(article.excerpt)]),
    ]);
  }
}
```

## Running the Project
```bash
# Fetch dependencies
dart pub get

# Build the static site
jaspr build

# Serve locally
jaspr serve
```
