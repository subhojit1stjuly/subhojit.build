import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/core_expertise_section.dart';
import '../components/hero_section.dart';
import '../components/projects_section.dart';

/// Portfolio home page — Hero, Core Expertise bento grid, Featured Projects.
/// The Navbar and Footer are injected by the [ShellRoute] in app.dart.
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      const HeroSection(),
      const CoreExpertiseSection(),
      const ProjectsSection(),
    ]);
  }
}
