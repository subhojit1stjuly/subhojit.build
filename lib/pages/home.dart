import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/about_section.dart';
import '../components/footer.dart';
import '../components/hero_section.dart';
import '../components/navbar.dart';
import '../components/projects_section.dart';

/// Root page component — assembles every section of the portfolio.
///
/// Rendered as static HTML during `jaspr build` (SSG mode).
/// No @client annotation needed: the portfolio has no client-side state.
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    // A simple column: sticky navbar, then each full-width section, then footer.
    return div(classes: 'page', [
      const Navbar(),
      const HeroSection(),
      const AboutSection(),
      const ProjectsSection(),
      const Footer(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    // The page wrapper is a flex column that fills at least the viewport height.
    css('.page').styles(
      display: .flex,
      flexDirection: .column,
      minHeight: 100.vh,
    ),

    // Smooth anchor scrolling — pairs nicely with the sticky navbar.
    css('html').styles(raw: {'scroll-behavior': 'smooth'}),

    // Give anchor targets a scroll-margin so the sticky navbar doesn't overlap.
    css('#about, #projects, #contact').styles(
      raw: {'scroll-margin-top': '5rem'},
    ),
  ];
}
