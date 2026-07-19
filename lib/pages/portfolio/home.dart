import 'package:jaspr/jaspr.dart';

import 'components/core_expertise_section.dart';
import 'components/hero_section.dart';
import 'components/projects_section.dart';
import 'models/project.dart';

/// Portfolio home page — Hero, Core Expertise bento grid, Featured Projects.
/// The Navbar and Footer are injected by the [ShellRoute] in app.dart.
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    // TODO: Replace with actual jaspr_content fetching
    final projects = [
      Project(
        id: '1',
        name: 'Flutter E-Commerce Platform',
        description:
            'Production app with real-time inventory, smooth 60fps transitions, and a custom parallax product hero. Serves 200k+ monthly active users.',
        technologies: ['Flutter', 'Riverpod', 'Firebase'],
        externalLink: 'https://github.com/subhojit',
      ),
      Project(
        id: '2',
        name: 'Dart CLI Toolchain',
        description:
            'Developer-productivity CLI automating code-generation, asset optimisation, and release tagging for Flutter mono-repos. Used internally by 3 product teams.',
        technologies: ['Dart', 'CLI', 'GitHub Actions'],
        externalLink: 'https://github.com/subhojit',
      ),
      Project(
        id: '3',
        name: 'State Management Reference',
        description:
            'Opinionated reference implementation comparing Riverpod, Bloc, and Provider across identical feature slices. Onboarding resource for new engineers.',
        technologies: ['Flutter', 'Bloc', 'Riverpod'],
        externalLink: 'https://github.com/subhojit',
      ),
    ];

    return Component.fragment([
      const HeroSection(),
      const CoreExpertiseSection(),
      ProjectsSection(projects: projects),
    ]);
  }
}
