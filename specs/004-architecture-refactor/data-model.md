# Data Models

The following typed data models will be defined in `lib/models/`. These models map directly to the YAML frontmatter stored in the Markdown files in the `content/` directory.

## 1. Article (`lib/models/article.dart`)
Represents a blog post.

**Fields**:
- `id` (String): Unique identifier (often derived from filename or explicit slug).
- `title` (String): The title of the article.
- `date` (DateTime): The publication date.
- `excerpt` (String): A short summary.
- `tags` (List<String>): Categories or tags.
- `content` (String): The rendered markdown body.

## 2. JobExperience (`lib/models/job_experience.dart`)
Represents a career history entry.

**Fields**:
- `id` (String): Unique identifier.
- `company` (String): The employer name.
- `role` (String): The job title.
- `duration` (String): The time period (e.g., "Jan 2020 - Present").
- `responsibilities` (List<String>): Key achievements or duties.
- `content` (String?): Optional markdown body for additional details.

## 3. Project (`lib/models/project.dart`)
Represents a portfolio project.

**Fields**:
- `id` (String): Unique identifier.
- `name` (String): The project name.
- `description` (String): A brief description of the project.
- `technologies` (List<String>): Tech stack used (e.g., `['Dart', 'Jaspr']`).
- `externalLink` (String?): URL to the live project or repository.
- `content` (String?): Optional markdown body containing extended case study details.
