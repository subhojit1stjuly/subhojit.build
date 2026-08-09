/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/dom.dart';
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
import 'package:subhojit_build/core/services/content_service.dart';
import 'package:subhojit_build/core/theme/theme.dart' as theme;
import 'package:subhojit_build/core/utils.dart' as utils;

// Imports the [App] component.
import 'app.dart';

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
  final jobs = await ContentService.getCareersAsync();
  final certificates = await ContentService.getCertificationsAsync();
  final projects = await ContentService.getProjectsAsync();

  // Starts the app with jaspr_content integration.
  //
  // Hybrid mode: FilesystemLoader loads new content from content/ directory,
  // MemoryLoader preserves existing hardcoded blog posts as fallback.
  // This provides zero-risk migration path and graceful degradation.
  runApp(
    Document(
      title: 'Subhojit Build',
      styles: theme.styles,
      head: [script(content: utils.themeInitScript)],
      body: ContentApp.custom(
        loaders: [
          // Primary: Load content from filesystem
          FilesystemLoader('content'),

          // Fallback: Existing hardcoded blog posts as MemoryPages
          // MemoryLoader(pages: _createMemoryPagesFromHardcodedArticles()),
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
          theme: theme.appTheme,
        ),
        routerBuilder: (contentRoutes) {
          return App(
            contentRoutes: contentRoutes,
            blogList: blogList,
            jobs: jobs,
            certificates: certificates,
            projects: projects,
          );
        },
      ),
    ),
  );
}
