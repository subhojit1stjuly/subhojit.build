import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

// ── Project data ─────────────────────────────────────────────────────────────

class _Project {
  const _Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.sourceUrl,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String sourceUrl;
}

const _projects = [
  _Project(
    title: 'Flutter E-Commerce App',
    description:
        'A production-grade shopping app built with Flutter and Riverpod. '
        'Features real-time inventory sync, smooth page transitions, '
        'and a 60 fps product-detail parallax hero.',
    tags: ['Flutter', 'Riverpod', 'Firebase', 'Dart'],
    sourceUrl: 'https://github.com/subhojit',
  ),
  _Project(
    title: 'Dart CLI Toolchain',
    description:
        'A developer-productivity CLI built in pure Dart. Automates '
        'code-generation, asset optimisation, and release tagging for '
        'multi-module Flutter mono-repos.',
    tags: ['Dart', 'CLI', 'GitHub Actions', 'CI/CD'],
    sourceUrl: 'https://github.com/subhojit',
  ),
  _Project(
    title: 'State Management Demo',
    description:
        'A reference implementation comparing Riverpod, Bloc, and Provider '
        'across identical feature slices — useful for onboarding new '
        'engineers and architecture discussions.',
    tags: ['Flutter', 'Bloc', 'Riverpod', 'Clean Arch'],
    sourceUrl: 'https://github.com/subhojit',
  ),
];

// ── Projects section ──────────────────────────────────────────────────────────

/// Responsive 3-column grid of project cards.
class ProjectsSection extends StatelessComponent {
  const ProjectsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'projects',
      classes: 'projects-section',
      [
        div(classes: 'projects-inner container', [
          div(classes: 'section-heading', [
            h2(classes: 'section-title', [.text('Projects')]),
            div(classes: 'section-divider', []),
          ]),
          div(classes: 'projects-grid', [
            for (final p in _projects) _ProjectCard(project: p),
          ]),
        ]),
      ],
    );
  }

  // All styles for both section AND card live here so @css picks them up.
  @css
  static List<StyleRule> get styles => [
    css('.projects-section').styles(
      padding: .symmetric(vertical: 6.rem),
    ),
    css('.projects-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack(TrackSize.fr(1)),
          GridTrack(TrackSize.fr(1)),
          GridTrack(TrackSize.fr(1)),
        ]),
      ),
      gap: Gap.all(1.75.rem),
    ),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.projects-section').styles(padding: .symmetric(vertical: 4.rem)),
      css('.projects-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
    ]),
    css('.project-card').styles(
      display: .flex,
      flexDirection: .column,
      backgroundColor: surfaceColor,
      border: Border.all(color: borderColor, style: BorderStyle.solid, width: 1.px),
      radius: BorderRadius.circular(12.px),
      padding: .all(1.75.rem),
      transition: Transition.combine([
        Transition('transform',    duration: Duration(milliseconds: 250), curve: Curve.ease),
        Transition('box-shadow',   duration: Duration(milliseconds: 250), curve: Curve.ease),
        Transition('border-color', duration: Duration(milliseconds: 250), curve: Curve.ease),
      ]),
    ),
    css('.project-card:hover').styles(
      shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 30.px, color: Color('#38BDF820')),
      border: Border.all(color: accentColor, style: BorderStyle.solid, width: 1.px),
      raw: {'transform': 'translateY(-4px)'},
    ),
    css('.card-body').styles(flex: Flex(grow: 1)),
    css('.card-title').styles(
      fontSize: 1.25.rem,
      fontWeight: .w700,
      color: textPrimary,
      raw: {'margin-bottom': '0.75rem'},
    ),
    css('.card-desc').styles(
      fontSize: 0.9375.rem,
      lineHeight: 1.7.em,
      color: textSecondary,
      raw: {'margin-bottom': '1.25rem'},
    ),
    css('.card-tags').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.5.rem),
      raw: {'margin-bottom': '1.5rem'},
    ),
    css('.tag').styles(
      display: .inlineFlex,
      fontSize: 0.75.rem,
      fontWeight: .w500,
      color: accentColor,
      backgroundColor: tagBgColor,
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
    ),
    css('.card-link').styles(
      display: .inlineFlex,
      alignItems: .center,
      fontSize: 0.9375.rem,
      fontWeight: .w600,
      color: accentColor,
      transition: Transition('color', duration: Duration(milliseconds: 200), curve: Curve.ease),
    ),
    css('.card-link:hover').styles(color: accentHoverColor),
  ];
}

// ── Card sub-component ────────────────────────────────────────────────────────

/// Styles are declared in [ProjectsSection.styles].
class _ProjectCard extends StatelessComponent {
  const _ProjectCard({required this.project});

  final _Project project;

  @override
  Component build(BuildContext context) {
    return div(classes: 'project-card', [
      div(classes: 'card-body', [
        h3(classes: 'card-title', [.text(project.title)]),
        p(classes: 'card-desc', [.text(project.description)]),
      ]),
      div(classes: 'card-tags', [
        for (final tag in project.tags) span(classes: 'tag', [.text(tag)]),
      ]),
      a(
        href: project.sourceUrl,
        classes: 'card-link',
        attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
        [.text('View Source →')],
      ),
    ]);
  }
}
