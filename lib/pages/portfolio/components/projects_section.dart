import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';

import '../models/project.dart';

class ProjectsSection extends StatelessComponent {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

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
            a(
              href: 'https://github.com/subhojit',
              classes: 'projects-all-link',
              attributes: {'target': '_blank', 'rel': 'noopener'},
              [
                .text('All Projects \u2192'),
              ],
            ),
          ]),

          // Project list
          div(classes: 'projects-list', [
            for (final p in projects) _ProjectCard(project: p),
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
      display: .flex,
      height: 180.px,
      justifyContent: .center,
      alignItems: .center,
      raw: {'position': 'relative'},
    ),
    css('.project-category-chip').styles(
      position: .absolute(bottom: 12.px, left: 12.px),
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: primaryColor,
      fontSize: 11.px,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      backgroundColor: primaryFixed,
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
    css(
      '.project-tags',
    ).styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.375.rem),
      raw: {'margin-bottom': '1rem'},
    ),
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
  final Project project;

  @override
  Component build(BuildContext context) {
    return div(classes: 'project-card', [
      // Tonal image placeholder with category chip
      div(classes: 'project-image', styles: Styles(backgroundColor: secondaryContainer), [
        span(classes: 'material-symbols-outlined', styles: Styles(fontSize: 36.px, color: primaryColor), [
          .text('code'),
        ]),
        div(classes: 'project-category-chip', [.text('Project')]),
      ]),
      div(classes: 'project-body', [
        p(classes: 'project-title', [.text(project.name)]),
        p(classes: 'project-desc', [.text(project.description)]),
        div(classes: 'project-tags', [
          for (final tag in project.technologies) span(classes: 'project-tag', [.text(tag)]),
        ]),
        if (project.externalLink != null)
          a(
            href: project.externalLink!,
            classes: 'project-link',
            attributes: {'target': '_blank', 'rel': 'noopener'},
            [
              .text('View Source'),
              span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
            ],
          ),
      ]),
    ]);
  }
}
