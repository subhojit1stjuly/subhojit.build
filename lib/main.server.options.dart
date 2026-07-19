// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/theme_toggle.dart' as _theme_toggle;
import 'package:subhojit_build/components/career_section.dart'
    as _career_section;
import 'package:subhojit_build/components/core_expertise_section.dart'
    as _core_expertise_section;
import 'package:subhojit_build/components/footer.dart' as _footer;
import 'package:subhojit_build/components/hero_section.dart' as _hero_section;
import 'package:subhojit_build/components/navbar.dart' as _navbar;
import 'package:subhojit_build/components/philosophy_section.dart'
    as _philosophy_section;
import 'package:subhojit_build/components/projects_section.dart'
    as _projects_section;
import 'package:subhojit_build/constants/theme.dart' as _theme;
import 'package:subhojit_build/pages/blog.dart' as _blog;
import 'package:subhojit_build/pages/career.dart' as _career;
import 'package:subhojit_build/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _theme_toggle.ThemeToggle: ClientTarget<_theme_toggle.ThemeToggle>(
      'jaspr_content:theme_toggle',
    ),
  },
  styles: () => [
    ..._theme.styles,
    ..._theme_toggle.ThemeToggleState.styles,
    ..._app.PageShell.styles,
    ..._career_section.CareerSection.styles,
    ..._core_expertise_section.CoreExpertiseSection.styles,
    ..._footer.Footer.styles,
    ..._hero_section.HeroSection.styles,
    ..._navbar.Navbar.styles,
    ..._philosophy_section.PhilosophySection.styles,
    ..._projects_section.ProjectsSection.styles,
    ..._blog.BlogPage.styles,
    ..._career.CareerPage.styles,
  ],
);
