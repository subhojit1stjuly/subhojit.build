import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';
import 'package:subhojit_build/shared/components/post_cards/poject_footer.dart';
import 'package:subhojit_build/shared/components/post_cards/post_card.dart';
import 'package:subhojit_build/shared/model/info_card_model.dart';

class ProjectsPage extends StatelessComponent {
  final List<ProjectDoc> projects;
  const ProjectsPage({super.key, required this.projects});

  @override
  Component build(BuildContext context) {
    return section(classes: 'projects-page', [
      div(classes: 'projects-page-inner container', [
        // Page Header[cite: 1]
        div(classes: 'projects-header', [
          h1(classes: 'projects-headline t-headline', [
            .text('Systems & Solutions'),
          ]),
          p(classes: 'projects-sub t-body-lg', [
            .text(
              'A collection of high-performance frameworks, distributed systems, '
              'and open-source tooling built for scalability and developer efficiency.',
            ),
          ]),
        ]),

        // Two-column layout: Main Content (Projects) + Sidebar (Stats)[cite: 1]
        div(classes: 'projects-body', [
          // ── Main Content (Left) ──────────────────────────────────────────
          div(classes: 'projects-main', [
            // Filter Bar
            div(classes: 'filter-bar', [
              button(classes: 'filter-btn filter-btn--active', [.text('All')]),
              button(classes: 'filter-btn', [.text('Flutter')]),
              button(classes: 'filter-btn', [.text('Backend')]),
              button(classes: 'filter-btn', [.text('Infrastructure')]),
              button(classes: 'filter-btn', [.text('Tooling')]),
            ]),

            // Projects Grid[cite: 1]
            div(classes: 'projects-grid', [
              for (final p in projects)
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

            // Pagination[cite: 1]
            div(classes: 'projects-pagination', [
              div(classes: 'page-btn page-btn--prev', [
                span(classes: 'material-symbols-outlined', [.text('chevron_left')]),
              ]),
              div(classes: 'page-btn page-btn--active', [.text('1')]),
              div(classes: 'page-btn', [.text('2')]),
              div(classes: 'page-btn', [.text('3')]),
              div(classes: 'page-btn page-btn--next', [
                span(classes: 'material-symbols-outlined', [.text('chevron_right')]),
              ]),
            ]),
          ]),

          // ── Sidebar (Right) ──────────────────────────────────────────────
          aside(classes: 'projects-sidebar', [
            // GitHub Stats Widget
            div(classes: 'widget-card', [
              h2(classes: 'widget-title', [
                span(classes: 'material-symbols-outlined', [.text('analytics')]),
                .text('GitHub Stats'),
              ]),
              div(classes: 'stat-row', [
                span(classes: 'stat-label', [.text('Contributions')]),
                span(classes: 'stat-value', [.text('2,482')]),
              ]),
              div(classes: 'stat-row', [
                span(classes: 'stat-label', [.text('Repositories')]),
                span(classes: 'stat-value', [.text('48')]),
              ]),
              div(classes: 'stat-row', [
                span(classes: 'stat-label', [.text('Stars Earned')]),
                span(classes: 'stat-value', [.text('1.2k')]),
              ]),
            ]),

            // Tech Stack Widget
            div(classes: 'widget-card', [
              h2(classes: 'widget-title', [
                span(classes: 'material-symbols-outlined', [.text('psychology')]),
                .text('Technical Stack'),
              ]),
              div(classes: 'tech-tags-cloud', [
                for (final tech in [
                  'Dart',
                  'Flutter',
                  'Rust',
                  'Go',
                  'PostgreSQL',
                  'Kubernetes',
                  'WebAssembly',
                  'TypeScript',
                ])
                  span(classes: 'tech-tag', [.text(tech)]),
              ]),
            ]),

            // Milestones Widget
            div(classes: 'widget-card', [
              h2(classes: 'widget-title', [
                span(classes: 'material-symbols-outlined', [.text('stars')]),
                .text('Milestones'),
              ]),
              div(classes: 'milestone-content', [
                span(classes: 'material-symbols-outlined milestone-icon', [.text('pending_actions')]),
                h4(classes: 'milestone-title', [.text('Future Milestones')]),
                p(classes: 'milestone-sub', [
                  .text(
                    'Stay tuned for upcoming certifications and major open-source contributions currently in development.',
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.projects-page').styles(
      padding: .symmetric(vertical: 5.rem),
      raw: {'padding-top': '7rem'},
    ),
    css('.container').styles(
      raw: {'max-width': '1200px', 'margin': '0 auto', 'padding': '0 2rem'},
    ),
    css('.projects-header').styles(raw: {'margin-bottom': '3rem'}),
    css('.projects-headline').styles(
      color: onSurface,
      raw: {'margin-bottom': '0.5rem', 'font-size': '3.5rem', 'font-weight': '600', 'letter-spacing': '-0.02em'},
    ),
    css('.projects-sub').styles(color: onSurfaceVariant, raw: {'max-width': '42rem'}),

    // ── Two-column layout[cite: 1] ──────────────────────────────────────────
    css('.projects-body').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(8)), GridTrack(TrackSize.fr(4))]),
      ),
      gap: Gap.all(3.rem),
      raw: {'align-items': 'start'},
    ),
    css('.projects-main').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(2.rem),
    ),

    // ── Filters ──────────────────────────────────────────────────────────
    css('.filter-bar').styles(
      display: .flex,
      padding: .only(bottom: 1.rem),
      flexWrap: .wrap,
      gap: Gap.all(1.rem),
      raw: {'border-bottom': '1px solid ${outlineVariant.value}'},
    ),
    css('.filter-btn').styles(
      padding: .symmetric(horizontal: 1.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(99.px),
      cursor: Cursor.pointer,
      color: onSurfaceVariant,
      fontSize: 13.px,
      fontWeight: .w600,
      backgroundColor: trasparent,
      raw: {'border': 'none', 'letter-spacing': '0.05em', 'transition': 'all 0.2s'},
    ),
    css('.filter-btn:hover').styles(color: primaryColor),
    css('.filter-btn--active').styles(
      color: onPrimary,
      backgroundColor: primaryColor,
    ),

    // ── Project Grid[cite: 1] ───────────────────────────────────────────────
    css('.projects-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(1.5.rem),
    ),

    // Cards
    css('.bento-card').styles(
      display: .flex,
      radius: BorderRadius.circular(16.px),
      overflow: .clip,
      transition: Transition.combine([
        Transition('transform', duration: Duration(milliseconds: 200)),
        Transition('box-shadow', duration: Duration(milliseconds: 200)),
        Transition('border-color', duration: Duration(milliseconds: 200)),
      ]),
      flexDirection: .column,
      backgroundColor: surfaceContainerLowest,
      raw: {
        'border': '1px solid ${outlineVariant.value}',
      },
    ),
    css('.bento-card:hover').styles(
      raw: {
        'transform': 'translateY(-4px)',
        'box-shadow': '0px 8px 24px rgba(58, 34, 161, 0.12)',
        'border-color': primaryColor.value,
      },
    ),
    css('.card-image-wrap').styles(
      display: .flex,
      position: .relative(),
      height: 200.px,
    ),
    css('.card-image').styles(raw: {'width': '100%', 'height': '100%', 'object-fit': 'cover'}),
    css('.card-badge').styles(
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(99.px),
      fontSize: 10.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'position': 'absolute', 'top': '1rem', 'right': '1rem', 'letter-spacing': '0.1em'},
    ),
    css('.card-body').styles(
      display: .flex,
      padding: .all(1.5.rem),
      flexDirection: .column,
      flex: Flex(grow: 1),
    ),
    css('.card-header').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.5.rem),
      raw: {'margin-bottom': '0.75rem'},
    ),
    css('.card-icon').styles(color: primaryColor, raw: {'font-variation-settings': "'FILL' 1"}),
    css('.card-title').styles(color: onSurface, fontSize: 20.px, fontWeight: .w600, raw: {'margin': '0'}),
    css('.card-desc').styles(
      color: onSurfaceVariant,
      fontSize: 14.px,
      lineHeight: 1.5.em,
      raw: {
        'margin': '0 0 1.5rem 0',
        'display': '-webkit-box',
        '-webkit-line-clamp': '3',
        '-webkit-box-orient': 'vertical',
        'overflow': 'hidden',
      },
    ),
    css('.card-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.5.rem), raw: {'margin-bottom': '1.5rem'}),
    css('.card-tag').styles(
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(99.px),
      color: onSurfaceVariant,
      fontSize: 12.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainer,
    ),
    css('.card-footer').styles(
      display: .flex,
      padding: .only(top: 1.rem),
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {'margin-top': 'auto', 'border-top': '1px solid ${outlineVariant.value}'},
    ),
    css('.card-link').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.25.rem),
      color: primaryColor,
      fontSize: 12.px,
      fontWeight: .w600,
    ),
    css('.card-note').styles(
      color: outlineVariant,
      fontSize: 12.px,
      fontStyle: FontStyle.italic,
    ),

    // ── Pagination[cite: 1] ─────────────────────────────────────────────────
    css('.projects-pagination').styles(
      display: .flex,
      padding: .only(top: 2.rem),
      justifyContent: .center,
      alignItems: .center,
      gap: Gap.all(0.5.rem),
      raw: {'margin-top': '2rem', 'border-top': '1px solid ${outlineVariant.value}'},
    ),
    css('.page-btn').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      radius: BorderRadius.circular(8.px),
      cursor: Cursor.pointer,
      transition: Transition.combine([
        Transition('color', duration: Duration(milliseconds: 150)),
        Transition('background-color', duration: Duration(milliseconds: 150)),
      ]),
      justifyContent: .center,
      alignItems: .center,
      color: onSurfaceVariant,
      fontSize: 14.px,
      fontWeight: .w600,
    ),
    css('.page-btn:hover').styles(backgroundColor: surfaceContainer),
    css('.page-btn--active').styles(color: onPrimary, backgroundColor: primaryColor),

    // ── Sidebar Widgets ──────────────────────────────────────────────────────
    css('.projects-sidebar').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.5.rem),
      raw: {'position': 'sticky', 'top': '5rem'},
    ),
    css('.widget-card').styles(
      padding: .all(1.5.rem),
      radius: BorderRadius.circular(16.px),
      backgroundColor: surfaceContainer,
      raw: {'border': '1px solid ${outlineVariant.value}'},
    ),
    css('.widget-title').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.5.rem),
      color: onSurface,
      fontSize: 18.px,
      fontWeight: .w600,
      raw: {'margin': '0 0 1.5rem 0'},
    ),
    css('.stat-row').styles(
      display: .flex,
      padding: .all(0.75.rem),
      radius: BorderRadius.circular(8.px),
      justifyContent: .spaceBetween,
      alignItems: .center,
      backgroundColor: surfaceContainerLowest,
      raw: {'margin-bottom': '0.75rem'},
    ),
    css('.stat-label').styles(
      color: onSurfaceVariant,
      fontSize: 12.px,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
    css('.stat-value').styles(
      color: primaryColor,
      fontWeight: .w700,
    ),
    css('.tech-tags-cloud').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.5.rem),
    ),
    css('.tech-tag').styles(
      padding: .symmetric(horizontal: 1.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
      color: primaryColor,
      fontSize: 12.px,
      fontWeight: .w600,
      backgroundColor: surfaceContainerLowest,
      raw: {'border': '1px solid ${outlineVariant.value}'},
    ),
    css('.milestone-content').styles(
      display: .flex,
      padding: .symmetric(vertical: 1.rem),
      flexDirection: .column,
      alignItems: .center,
      textAlign: TextAlign.center,
    ),
    css('.milestone-icon').styles(
      color: secondaryColor,
      fontSize: 48.px,
      raw: {'margin-bottom': '1rem', 'font-variation-settings': "'wght' 200"},
    ),
    css('.milestone-title').styles(color: onSurface, fontWeight: .w700, raw: {'margin': '0 0 0.5rem 0'}),
    css('.milestone-sub').styles(color: onSurfaceVariant, fontSize: 13.px, lineHeight: 1.5.em, raw: {'margin': '0'}),

    // ── Mobile Responsiveness[cite: 1] ──────────────────────────────────────
    css.media(MediaQuery.screen(maxWidth: 1024.px), [
      css('.projects-body').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.projects-sidebar').styles(raw: {'position': 'static'}),
    ]),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.projects-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.projects-page').styles(raw: {'padding-top': '6rem'}),
    ]),
  ];
}
