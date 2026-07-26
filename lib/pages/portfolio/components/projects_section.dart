import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';
import 'package:subhojit_build/shared/components/post_cards/poject_footer.dart';
import 'package:subhojit_build/shared/components/post_cards/post_card.dart';
import 'package:subhojit_build/shared/model/info_card_model.dart';

class ProjectsSection extends StatelessComponent {
  final List<ProjectDoc> projects;

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
            Link(
              to: RouteConstants.projects, // The separate path route
              classes: 'projects-all-link',
              children: [
                .text('All Projects'),
                span(classes: 'material-symbols-outlined', [.text('chevron_right')]),
              ],
            ),
          ]),

          // Project list
          div(classes: 'projects-list', [
            for (final p in projects.take(3))
              PostCard(
                data: InfoCardModel(
                  title: p.title,
                  description: p.description,
                  imageUrl: p.imageUrl,
                  category: p.category,
                  tags: p.tags,
                ),
                footerComponet: ProjectFooter(
                  liveUrl: p.liveUrl ?? '',
                  repoUrl: p.repoUrl ?? '',
                ),
              ),
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
      flexWrap: .wrap,
      justifyContent: .spaceBetween,
      alignItems: .end,
      gap: Gap.all(1.rem),
      raw: {'margin-bottom': '2.5rem'},
    ),
    css('.projects-eyebrow').styles(color: primaryColor, raw: {'margin-bottom': '0.5rem'}),
    css('.projects-title').styles(color: onSurface),
    css('.projects-all-link').styles(
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      color: primaryColor,
      fontSize: 14.px,
      fontWeight: .w600,
      raw: {'white-space': 'nowrap'},
    ),
    css('.projects-all-link:hover').styles(color: onPrimaryFixedVariant),
    css('.projects-list').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.5.rem),
    ),

    // Card
    css('.project-card').styles(
      display: .flex,
      radius: BorderRadius.circular(16.px),
      overflow: .clip,
      transition: Transition.combine([
        Transition('box-shadow', duration: Duration(milliseconds: 200)),
        Transition('transform', duration: Duration(milliseconds: 200)),
      ]),
      flexDirection: .column,
      backgroundColor: surfaceContainerLowest,
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
      color: onSurface,
      fontSize: 18.px,
      fontWeight: .w700,
      raw: {'margin-bottom': '0.5rem'},
    ),
    css('.project-desc').styles(
      color: onSurfaceVariant,
      fontSize: 14.px,
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
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: onSurfaceVariant,
      fontSize: 11.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainerHigh,
    ),
    css('.project-link').styles(
      display: .inlineFlex,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      gap: Gap.all(0.25.rem),
      color: primaryColor,
      fontSize: 13.px,
      fontWeight: .w600,
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
