/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/callout.dart';
import 'package:jaspr_content/components/code_block.dart';
import 'package:jaspr_content/components/drop_cap.dart';
import 'package:jaspr_content/components/file_tree.dart';
import 'package:jaspr_content/components/header.dart';
import 'package:jaspr_content/components/image.dart';
import 'package:jaspr_content/components/post_break.dart';
import 'package:jaspr_content/components/tabs.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:subhojit_build/core/constants/dummy_data.dart';
import 'package:subhojit_build/core/services/content_service.dart';
import 'package:subhojit_build/core/theme/theme.dart';

// Imports the [App] component.
import 'app.dart';
import 'pages/blog/blog.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() async {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );
  // 2. Load your data BEFORE calling runApp
  // This happens once when the server starts
  final blogList = await ContentService.getBlogsAsync();

  // Starts the app with jaspr_content integration.
  //
  // Hybrid mode: FilesystemLoader loads new content from content/ directory,
  // MemoryLoader preserves existing hardcoded blog posts as fallback.
  // This provides zero-risk migration path and graceful degradation.
  runApp(
    ContentApp.custom(
      loaders: [
        // Primary: Load content from filesystem
        FilesystemLoader('content'),

        // Fallback: Existing hardcoded blog posts as MemoryPages
        MemoryLoader(pages: _createMemoryPagesFromHardcodedArticles()),
      ],
      eagerlyLoadAllPages: true,
      configResolver: PageConfig.all(
        parsers: [MarkdownParser()],
        layouts: [
          BlogLayout(
            header: Header(
              title: 'Jaspr Blog',
              logo: 'https://raw.githubusercontent.com/schultek/jaspr/refs/heads/main/assets/logo.png',
            ),
          ),
          DocsLayout(),
        ],
        components: [
          DropCap(),
          PostBreak(),
          Callout(),
          CodeBlock(),
          Image(),
          Tabs(),
          FileTree(),
        ],
        extensions: [
          TableOfContentsExtension(),
          HeadingAnchorsExtension(),
        ],
        theme: appTheme,
      ),
      routerBuilder: (contentRoutes) {
        return App(
          contentRoutes: contentRoutes,
          blogList: blogList,
        );
      },
    ),
  );
}

/// Convert existing hardcoded _Article objects to MemoryPages for backward compatibility.
/// This ensures all existing blog posts remain functional during infrastructure validation.
List<MemoryPage> _createMemoryPagesFromHardcodedArticles() {
  return DummyData.hardcodedArticles.map((art) {
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
