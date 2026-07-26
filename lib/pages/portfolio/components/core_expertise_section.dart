import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';

/// Core Expertise bento-grid section on the home page.
///
/// Desktop layout (2-row bento):
///   Row 1: [Large card — Flutter Architecture] | [Tall card — Performance]
///   Row 2: [Full-width card — Mobile CI/CD  with 2 sub-columns]
///
/// Mobile: single-column stack.
class CoreExpertiseSection extends StatelessComponent {
  const CoreExpertiseSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'expertise-section', [
      div(classes: 'expertise-inner container', [
        // Section header
        div(classes: 'expertise-header', [
          p(classes: 'expertise-eyebrow t-label', [.text('Specialisation')]),
          h2(classes: 'expertise-title t-headline', [.text('Core Expertise')]),
          p(classes: 'expertise-sub t-body-lg', [
            .text('Specialized domains in modern mobile engineering.'),
          ]),
        ]),

        // Bento grid
        div(classes: 'expertise-grid', [
          // ── Row 1 ──────────────────────────────────────────────
          // Large card — Flutter Architecture
          div(classes: 'expertise-card expertise-card--large', [
            div(classes: 'card-content', [
              h3(classes: 'card-title t-title', [.text('Flutter Architecture')]),
              p(classes: 'card-desc t-body', [
                .text(
                  'Building production-grade apps with Clean Architecture '
                  'and MVVM. Offline-first sync engines using CRDTs and '
                  'sophisticated local caching strategies.',
                ),
              ]),
              div(classes: 'card-tags', [
                for (final tag in ['Clean Arch', 'MVVM', 'Riverpod', 'Offline-First'])
                  span(classes: 'card-tag', [.text(tag)]),
              ]),
            ]),
            // Decorative icon block
            div(classes: 'card-icon-block', [
              span(classes: 'material-symbols-outlined card-icon', [.text('flutter_dash')]),
            ]),
          ]),

          // Small card — Performance
          div(classes: 'expertise-card expertise-card--small', [
            div(classes: 'card-icon-sm-wrap', [
              span(classes: 'material-symbols-outlined card-icon-sm', [.text('speed')]),
            ]),
            h3(classes: 'card-title t-title', [.text('60fps Performance')]),
            p(classes: 'card-desc t-body', [
              .text(
                'Frame-level profiling and optimization. Custom render '
                'objects, shader pre-compilation, and image pipeline tuning.',
              ),
            ]),
            ul(classes: 'card-bullet-list', [
              li([.text('Jank-free animations')]),
              li([.text('Memory profiling')]),
              li([.text('App size reduction')]),
            ]),
          ]),

          // ── Row 2 — Wide card with 2 sub-columns ───────────────
          div(classes: 'expertise-card expertise-card--wide', [
            // Left sub-column: main content
            div(classes: 'wide-card-main', [
              div(classes: 'card-icon-sm-wrap', [
                span(classes: 'material-symbols-outlined card-icon-sm', [.text('deployed_code')]),
              ]),
              h3(classes: 'card-title t-title', [.text('Mobile CI/CD & DevOps')]),
              p(classes: 'card-desc t-body', [
                .text(
                  'End-to-end automated pipelines for Flutter apps across '
                  'Android and iOS. Fastlane, GitHub Actions, code signing, '
                  'and store delivery fully automated.',
                ),
              ]),
            ]),
            // Right sub-columns
            div(classes: 'wide-card-sub', [
              div(classes: 'sub-card', [
                p(classes: 'sub-card-label t-label', [.text('Delivery')]),
                p(classes: 'sub-card-body t-body', [
                  .text('Automated builds to Play Store and App Store in under 15 minutes.'),
                ]),
              ]),
              div(classes: 'sub-card', [
                p(classes: 'sub-card-label t-label', [.text('Testing')]),
                p(classes: 'sub-card-body t-body', [
                  .text('Unit, widget, and integration tests with 90%+ coverage enforced in CI.'),
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
    css('.expertise-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.expertise-header').styles(raw: {'margin-bottom': '2.5rem'}),
    css('.expertise-eyebrow').styles(color: primaryColor, raw: {'margin-bottom': '0.5rem'}),
    css('.expertise-title').styles(color: onSurface, raw: {'margin-bottom': '0.5rem'}),
    css('.expertise-sub').styles(color: onSurfaceVariant),

    // ── Bento grid ─────────────────────────────────────────────────────────
    // Desktop: 2 equal columns.
    // Large card spans col 1; small card spans col 2.
    // Wide card spans both columns.
    css('.expertise-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(2)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(1.rem),
    ),

    // Large card — row 1, col 1
    css('.expertise-card--large').styles(
      raw: {'grid-column': '1 / 2', 'grid-row': '1 / 2'},
    ),
    // Small card — row 1, col 2
    css('.expertise-card--small').styles(
      raw: {'grid-column': '2 / 3', 'grid-row': '1 / 2'},
    ),
    // Wide card — row 2, both columns
    css('.expertise-card--wide').styles(
      raw: {
        'grid-column': '1 / 3',
        'grid-row': '2 / 3',
        'display': 'grid',
        'grid-template-columns': '1fr 1fr',
        'gap': '2rem',
      },
    ),

    // ── Card base ──────────────────────────────────────────────────────────
    css('.expertise-card').styles(
      padding: .all(1.75.rem),
      radius: BorderRadius.circular(16.px),
      backgroundColor: surfaceContainerLowest,
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),

    // Large card inner layout — text left, icon right
    css('.expertise-card--large').styles(
      display: .flex,
      gap: Gap.all(1.5.rem),
    ),
    css('.card-content').styles(flex: Flex(grow: 1)),

    // Decorative icon block (large card)
    css('.card-icon-block').styles(
      display: .flex,
      width: 80.px,
      height: 80.px,
      radius: BorderRadius.circular(16.px),
      justifyContent: .center,
      alignItems: .center,
      backgroundColor: primaryFixed,
      raw: {'flex-shrink': '0', 'align-self': 'center'},
    ),
    css('.card-icon').styles(color: primaryColor, fontSize: 40.px),

    // Small card icon
    css('.card-icon-sm-wrap').styles(
      display: .inlineFlex,
      width: 44.px,
      height: 44.px,
      radius: BorderRadius.circular(12.px),
      justifyContent: .center,
      alignItems: .center,
      backgroundColor: primaryFixed,
      raw: {'margin-bottom': '1rem'},
    ),
    css('.card-icon-sm').styles(color: primaryColor, fontSize: 22.px),

    // Card typography
    css('.card-title').styles(color: onSurface, raw: {'margin-bottom': '0.625rem'}),
    css('.card-desc').styles(color: onSurfaceVariant, lineHeight: 1.6.em),

    // Tags
    css('.card-tags').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.5.rem),
      raw: {'margin-top': '1rem'},
    ),
    css('.card-tag').styles(
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: onSurfaceVariant,
      fontSize: 12.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainerHigh,
    ),

    // Bullet list
    css('.card-bullet-list').styles(
      color: onSurfaceVariant,
      fontSize: 13.px,
      raw: {'margin-top': '0.875rem', 'padding-left': '1.25rem', 'line-height': '1.8'},
    ),
    css('.wide-card-sub').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.rem),
    ),
    // Wide card sub-columns
    css('.sub-card').styles(
      padding: .all(1.25.rem),
      radius: BorderRadius.circular(12.px),
      backgroundColor: surfaceContainerLow,
    ),
    css('.sub-card-label').styles(
      color: primaryColor,
      raw: {'margin-bottom': '0.5rem'},
    ),
    css('.sub-card-body').styles(color: onSurfaceVariant, lineHeight: 1.55.em),

    // ── Mobile: single column ──────────────────────────────────────────────
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.expertise-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.expertise-card--large').styles(
        raw: {'grid-column': '1', 'grid-row': 'auto'},
      ),
      css('.expertise-card--small').styles(
        raw: {'grid-column': '1', 'grid-row': 'auto'},
      ),
      css('.expertise-card--wide').styles(
        raw: {'grid-column': '1', 'grid-row': 'auto', 'grid-template-columns': '1fr', 'gap': '1rem'},
      ),
      css('.expertise-section').styles(padding: .symmetric(vertical: 3.5.rem)),
    ]),
  ];
}
