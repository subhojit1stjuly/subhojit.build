// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:subhojit_build/components/about_section.dart' as _about_section;
import 'package:subhojit_build/components/footer.dart' as _footer;
import 'package:subhojit_build/components/hero_section.dart' as _hero_section;
import 'package:subhojit_build/components/navbar.dart' as _navbar;
import 'package:subhojit_build/components/projects_section.dart'
    as _projects_section;
import 'package:subhojit_build/constants/theme.dart' as _theme;
import 'package:subhojit_build/pages/home.dart' as _home;

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
  styles: () => [
    ..._theme.styles,
    ..._about_section.AboutSection.styles,
    ..._footer.Footer.styles,
    ..._hero_section.HeroSection.styles,
    ..._navbar.Navbar.styles,
    ..._projects_section.ProjectsSection.styles,
    ..._home.Home.styles,
  ],
);
