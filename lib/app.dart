import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/constants/string_constants.dart';
import 'package:subhojit_build/pages/blog/presentation/pages/blogs_page.dart';
import 'package:subhojit_build/pages/project/presentation/pages/project.dart';
import 'package:subhojit_build/core/components/page_shell.dart';

import 'core/components/footer.dart';
import 'pages/career/presentaiton/pages/career.dart';
import 'pages/portfolio/presentation/pages/home.dart';

/// Root application component.
///
/// Uses a [ShellRoute] so the [Navbar] and [Footer] are shared across all three
/// pages without re-mounting. Child pages are swapped in via SPA navigation.
///
/// SSG generates three static HTML files:
///   /index.html          → Portfolio home
///   /career/index.html   → Career & Experience
///   /blog/index.html     → Technical Insights / Blog
class App extends StatelessComponent {
  final List<List<RouteBase>> contentRoutes; // Injected from ContentApp.custom
  const App({
    super.key,
    required this.contentRoutes,
  });

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        ShellRoute(
          builder: (context, state, child) => PageShell(child: child),
          routes: [
            Route(
              path: RouteConstants.portfolio,
              title: StringConstants.portfolioTitle,
              builder: (context, state) => Home(),
            ),
            Route(
              path: RouteConstants.career,
              title: StringConstants.careerTitle,
              builder: (context, state) => CareerPage(),
            ),
            Route(
              path: RouteConstants.blogs,
              title: StringConstants.blogTitle,
              builder: (context, state) => const BlogsPage(),
            ),
            Route(
              path: RouteConstants.projects,
              title: StringConstants.projectTitle,
              builder: (context, state) => ProjectsPage(),
            ),
            ...contentRoutes.expand((e) => e), // Injected from ContentApp.custom
          ],
        ),
      ],
    );
  }
}
