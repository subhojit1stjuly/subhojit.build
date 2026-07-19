import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/constants/string_constants.dart';

import 'shared_components/footer.dart';
import 'shared_components/navbar.dart';
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
  const App({super.key});

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

  static const _navItems = [
    (label: 'Portfolio', to: RouteConstants.portfolio),
    (label: 'Career', to: RouteConstants.career),
    (label: 'Blog', to: RouteConstants.blogs),
    (label: 'Projects', to: RouteConstants.projects),
  ];

  static const _footerLinks = [
    (label: 'GitHub', href: 'https://github.com/subhojit'),
    (label: 'LinkedIn', href: 'https://linkedin.com/in/subhojit'),
    (label: 'Email', href: 'mailto:hello@subhojitpramanik.dev'),
  ];

  @override
  Component build(BuildContext context) {
    return div(classes: 'page', [
      const Navbar(navItems: _navItems),
      child,
      const Footer(links: _footerLinks),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page').styles(
      display: .flex,
      minHeight: 100.vh,
      flexDirection: .column,
    ),
  ];
}
