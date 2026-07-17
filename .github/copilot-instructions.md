<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan:
specs/002-content-setup/plan.md

Key context:
- Feature: jaspr_content infrastructure setup with ONE sample blog post
- jaspr_content v0.5.3+1: Runtime-only package, no code generation
- Content directory: content/ with subdirectories (blog/, projects/, career/, certifications/)
- Hybrid mode: MemoryLoader (hardcoded) + FilesystemLoader (sample post)
- Hot reload enabled in dev mode for content file changes
- Static mode: Content files read at build time during `jaspr build`
- Frontmatter schema: See contracts/blog-post-schema.md for required/optional fields
<!-- SPECKIT END -->
