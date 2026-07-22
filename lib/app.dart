import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/constants/string_constants.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';
import 'package:subhojit_build/pages/project/project.dart';
import 'package:subhojit_build/shared_components/page_shell.dart';

import 'shared_components/footer.dart';
import 'pages/blog/blog.dart';
import 'pages/career/career.dart';
import 'pages/portfolio/home.dart';

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
  final List<BlogArticle> blogList;
  const App({
    super.key,
    required this.contentRoutes,
    required this.blogList,
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
              builder: (context, state) => const Home(),
            ),
            Route(
              path: RouteConstants.career,
              title: StringConstants.careerTitle,
              builder: (context, state) => const CareerPage(),
            ),
            Route(
              path: RouteConstants.blogs,
              title: StringConstants.blogTitle,
              builder: (context, state) => const BlogPage(),
            ),
            Route(
              path: RouteConstants.projects,
              title: StringConstants.projectTitle,
              builder: (context, state) => const BlogPage(),
            ),
            ...contentRoutes.expand((e) => e), // Injected from ContentApp.custom
          ],
        ),
      ],
    );
  }
}
