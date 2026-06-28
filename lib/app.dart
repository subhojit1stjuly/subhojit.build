import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/footer.dart';
import 'components/navbar.dart';
import 'pages/blog.dart';
import 'pages/career.dart';
import 'pages/home.dart';

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
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        ShellRoute(
          builder: (context, state, child) => PageShell(child: child),
          routes: [
            Route(
              path: '/',
              title: 'Subhojit Pramanik — Senior Software Engineer',
              builder: (context, state) => const Home(),
            ),
            Route(
              path: '/career',
              title: 'Career — Subhojit Pramanik',
              builder: (context, state) => const CareerPage(),
            ),
            Route(
              path: '/blog',
              title: 'Technical Insights — Subhojit Pramanik',
              builder: (context, state) => const BlogPage(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Shared shell rendered around every page: Navbar at top, Footer at bottom.
class PageShell extends StatelessComponent {
  const PageShell({required this.child});

  final Component child;

  @override
  Component build(BuildContext context) {
    return div(classes: 'page', [
      const Navbar(),
      child,
      const Footer(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page').styles(
      display: .flex,
      flexDirection: .column,
      minHeight: 100.vh,
    ),
  ];
}
