import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class _Project {
  const _Project({required this.title, required this.desc, required this.category, required this.tags, required this.url, required this.imageColor});
  final String title, desc, category, url, imageColor;
  final List<String> tags;
}

const _projects = [
  _Project(
    title: 'Flutter E-Commerce Platform',
    desc: 'Production app with real-time inventory, smooth 60fps transitions, and a custom parallax product hero. Serves 200k+ monthly active users.',
    category: 'Mobile',
    tags: ['Flutter', 'Riverpod', 'Firebase'],
    url: 'https://github.com/subhojit',
    imageColor: '#d1e6f2',
  ),
  _Project(
    title: 'Dart CLI Toolchain',
    desc: 'Developer-productivity CLI automating code-generation, asset optimisation, and release tagging for Flutter mono-repos. Used internally by 3 product teams.',
    category: 'Tooling',
    tags: ['Dart', 'CLI', 'GitHub Actions'],
    url: 'https://github.com/subhojit',
    imageColor: '#e5deff',
  ),
  _Project(
    title: 'State Management Reference',
    desc: 'Opinionated reference implementation comparing Riverpod, Bloc, and Provider across identical feature slices. Onboarding resource for new engineers.',
    category: 'Open Source',
    tags: ['Flutter', 'Bloc', 'Riverpod'],
    url: 'https://github.com/subhojit',
    imageColor: '#f0eee9',
  ),
];

class ProjectsSection extends StatelessComponent {
  const ProjectsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'projects',
      classes: 'projects-section',
      [
        div(classes: 'projects-inner container', [
          // Section header with "View All" link
          div(classes: 'projects-header', [
            div([
              p(classes: 'projects-eyebrow t-label', [.text('Featured Projects')]),
              h2(classes: 'projects-title t-headline', [.text('What I\'ve Built')]),
            ]),
            a(href: 'https://github.com/subhojit', classes: 'projects-all-link',
                attributes: {'target': '_blank', 'rel': 'noopener'}, [
              .text('All Projects \u2192'),
            ]),
          ]),

          // Project list
          div(classes: 'projects-list', [
            for (final p in _projects) _ProjectCard(project: p),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.projects-section').styles(padding: .symmetric(vertical: 5.rem)),
    css('.projects-header').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      alignItems: .end,
      flexWrap: .wrap,
      gap: Gap.all(1.rem),
      raw: {'margin-bottom': '2.5rem'},
    ),
    css('.projects-eyebrow').styles(color: primaryColor, raw: {'margin-bottom': '0.5rem'}),
    css('.projects-title').styles(color: onSurface),
    css('.projects-all-link').styles(
      fontSize: 14.px,
      fontWeight: .w600,
      color: primaryColor,
      raw: {'white-space': 'nowrap'},
      transition: Transition('color', duration: Duration(milliseconds: 150)),
    ),
    css('.projects-all-link:hover').styles(color: onPrimaryFixedVariant),
    css('.projects-list').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.5.rem),
    ),

    // Card
    css('.project-card').styles(
      backgroundColor: surfaceContainerLowest,
      radius: BorderRadius.circular(16.px),
      overflow: .clip,
      display: .flex,
      flexDirection: .column,
      transition: Transition.combine([
        Transition('box-shadow', duration: Duration(milliseconds: 200)),
        Transition('transform', duration: Duration(milliseconds: 200)),
      ]),
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.project-card:hover').styles(
      raw: {
        'box-shadow': '0px 8px 24px rgba(26,28,30,0.10)',
        'transform': 'translateY(-2px)',
      },
    ),
    css('.project-image').styles(
      height: 180.px,
      display: .flex,
      alignItems: .center,
      justifyContent: .center,
      raw: {'position': 'relative'},
    ),
    css('.project-category-chip').styles(
      position: .absolute(bottom: 12.px, left: 12.px),
      fontSize: 11.px,
      fontWeight: .w600,
      color: primaryColor,
      backgroundColor: primaryFixed,
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
    css('.project-body').styles(padding: .all(1.5.rem)),
    css('.project-title').styles(
      fontSize: 18.px,
      fontWeight: .w700,
      color: onSurface,
      raw: {'margin-bottom': '0.5rem'},
    ),
    css('.project-desc').styles(
      fontSize: 14.px,
      color: onSurfaceVariant,
      lineHeight: 1.6.em,
      raw: {'margin-bottom': '1rem'},
    ),
    css('.project-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.375.rem), raw: {'margin-bottom': '1rem'}),
    css('.project-tag').styles(
      fontSize: 11.px,
      fontWeight: .w500,
      color: onSurfaceVariant,
      backgroundColor: surfaceContainerHigh,
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
    ),
    css('.project-link').styles(
      display: .inlineFlex,
      alignItems: .center,
      fontSize: 13.px,
      fontWeight: .w600,
      color: primaryColor,
      gap: Gap.all(0.25.rem),
      transition: Transition('color', duration: Duration(milliseconds: 150)),
    ),
    css('.project-link:hover').styles(color: onPrimaryFixedVariant),

    // Desktop: two-column card grid
    css.media(MediaQuery.screen(minWidth: 768.px), [
      css('.projects-list').styles(
        display: .grid,
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
        ),
        gap: Gap.all(1.5.rem),
      ),
    ]),
  ];
}

class _ProjectCard extends StatelessComponent {
  const _ProjectCard({required this.project});
  final _Project project;

  @override
  Component build(BuildContext context) {
    return div(classes: 'project-card', [
      // Tonal image placeholder with category chip
      div(classes: 'project-image', styles: Styles(backgroundColor: Color(project.imageColor)), [
        span(classes: 'material-symbols-outlined', styles: Styles(fontSize: 36.px, color: primaryColor), [.text('code')]),
        div(classes: 'project-category-chip', [.text(project.category)]),
      ]),
      div(classes: 'project-body', [
        p(classes: 'project-title', [.text(project.title)]),
        p(classes: 'project-desc', [.text(project.desc)]),
        div(classes: 'project-tags', [
          for (final tag in project.tags) span(classes: 'project-tag', [.text(tag)]),
        ]),
        a(href: project.url, classes: 'project-link',
            attributes: {'target': '_blank', 'rel': 'noopener'}, [
          .text('View Source'),
          span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
        ]),
      ]),
    ]);
  }
}
