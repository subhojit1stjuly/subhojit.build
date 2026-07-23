import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/constants/string_constants.dart';
import 'package:subhojit_build/core/theme/colors.dart';

class Constants {
  static const footerLinks = [
    (label: StringConstants.gitHub, href: 'https://github.com/subhojit1stjuly'),
    (label: StringConstants.linkedIn, href: 'https://www.linkedin.com/in/subhojit-pramanik-033789126/'),
    (label: StringConstants.email, href: 'mailto:subhojit1stjuly@gmail.com'),
  ];
  static const navItems = [
    (label: StringConstants.portfolio, to: RouteConstants.portfolio),
    (label: StringConstants.career, to: RouteConstants.career),
    (label: StringConstants.blog, to: RouteConstants.blogs),
    (label: StringConstants.project, to: RouteConstants.projects),
  ];
  static const taxonomy = [
    (label: 'Architecture', count: '8'),
    (label: 'Performance', count: '5'),
    (label: 'State Management', count: '6'),
    (label: 'DevOps / CI/CD', count: '4'),
    (label: 'UI & Animations', count: '7'),
  ];
  static const compSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST APIs',
    'GraphQL',
    'Git & GitHub',
    'CI/CD',
    'Agile Methodologies',
  ];

  /// Returns the canonical path to match for active-link detection.
  static String activePath(String location) {
    if (location.startsWith(RouteConstants.career)) return RouteConstants.career;
    if (location.startsWith(RouteConstants.blogs)) return RouteConstants.blogs;
    if (location.startsWith(RouteConstants.projects)) return RouteConstants.projects;
    return '/';
  }

  static String iconFor(String to) => switch (to) {
    RouteConstants.career => 'work_history',
    RouteConstants.blogs => 'article',
    RouteConstants.projects => 'projects',
    _ => 'folder_open',
  };

  static Color parseProjectColor(String? colorStr) {
    switch (colorStr) {
      case 'primaryFixed':
        return primaryFixed;
      case 'secondaryContainer':
        return secondaryContainer;
      case 'surfaceContainer':
        return surfaceContainer;
      default:
        return surfaceContainer;
    }
  }
}
