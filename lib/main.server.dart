/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:subhojit_build/constants/theme.dart';

// Imports the [App] component.
import 'app.dart';
import 'pages/blog.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  // Starts the app with jaspr_content integration.
  //
  // Hybrid mode: FilesystemLoader loads new content from content/ directory,
  // MemoryLoader preserves existing hardcoded blog posts as fallback.
  // This provides zero-risk migration path and graceful degradation.
  runApp(
    Document(
      title: 'Subhojit Pramanik — Senior Software Engineer',
      styles: [],
      body: ContentApp.custom(
        loaders: [
          // Primary: Load content from filesystem
          FilesystemLoader('content'),

          // Fallback: Existing hardcoded blog posts as MemoryPages
          MemoryLoader(pages: _createMemoryPagesFromHardcodedArticles()),
        ],
        eagerlyLoadAllPages: true,
        configResolver: PageConfig.all(parsers: [MarkdownParser()], theme: appTheme),
        routerBuilder: (contentRoutes) {
          // Return the existing App with jaspr_content routes available
          return App();
        },
      ),
    ),
  );
}

/// Convert existing hardcoded _Article objects to MemoryPages for backward compatibility.
/// This ensures all existing blog posts remain functional during infrastructure validation.
List<MemoryPage> _createMemoryPagesFromHardcodedArticles() {
  return hardcodedArticles.map((art) {
    // Generate slug from title
    final slug = art.title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

    // Convert article to frontmatter + markdown content
    final frontmatter = {
      'title': art.title,
      'date': '2026-01-01', // Placeholder date for hardcoded articles
      'excerpt': art.excerpt,
      'category': art.category,
      'tags': [art.category.toLowerCase()],
      'featured': art.featured,
      'readMin': art.readMin,
      'imageColor': art.imageColor.value,
      'layout': 'blog',
    };

    // Simple markdown content as placeholder
    final content =
        '''
# ${art.title}

${art.excerpt}

*This is a legacy hardcoded article. Content migration pending.*
''';

    return MemoryPage(
      path: 'blog/$slug.md',
      content: content,
      initialData: {'page': frontmatter},
    );
  }).toList();
}
