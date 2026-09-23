import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/components/value_builder.dart';
import 'package:subhojit_build/di/injection.dart';
import 'package:subhojit_build/pages/portfolio/presentation/controller/home_page_controller.dart';
import 'package:subhojit_build/pages/portfolio/presentation/controller/home_page_state.dart';
import '../components/core_expertise_section.dart';
import '../components/hero_section.dart';
import '../components/projects_section.dart';

/// Portfolio home page — Hero, Core Expertise bento grid, Featured Projects.
/// The Navbar and Footer are injected by the [ShellRoute] in app.dart.
@client
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    final HomePageController notifier = getIt<HomePageController>();

    return ValueBuilder<HomePageState>(
      valueNotifier: notifier,
      builder: (context, state) {
        return Component.fragment([
          const HeroSection(),
          const CoreExpertiseSection(),
          ProjectsSection(projects: state.featuredProjects),
        ]);
      },
    );
  }
}
