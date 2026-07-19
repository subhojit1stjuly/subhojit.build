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

  static const _navItems = [
    (label: 'Portfolio', to: '/'),
    (label: 'Career',    to: '/career'),
    (label: 'Blog',      to: '/blog'),
    (label: 'Contact',   to: '/#contact'),
  ];

  static const _footerLinks = [
    (label: 'GitHub',   href: 'https://github.com/subhojit'),
    (label: 'LinkedIn', href: 'https://linkedin.com/in/subhojit'),
    (label: 'Email',    href: 'mailto:hello@subhojitpramanik.dev'),
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
      flexDirection: .column,
      minHeight: 100.vh,
    ),
  ];
}
