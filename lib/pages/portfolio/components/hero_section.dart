import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/theme/colors.dart';

/// Hero section — the first thing a visitor sees.
///
/// Mobile  : Single column — status pill → headline → sub → CTAs → stats card.
/// Desktop : Two-column — left (text + CTAs) | right (floating stats card).
class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'hero',
      classes: 'hero-section',
      [
        div(classes: 'hero-inner container', [
          // ── Left / text column ─────────────────────────────
          div(classes: 'hero-text', [
            // Status pill with animated dot
            div(classes: 'status-pill', [
              span(classes: 'status-dot pulse-dot', []),
              span(classes: 't-label', [.text('Available for opportunities')]),
            ]),

            // Primary headline
            h1(classes: 'hero-headline t-display', [
              .text('Building Apps\nPeople '),
              span(classes: 'hero-headline--accent', [.text('Love.')]),
            ]),

            // Sub-headline
            p(classes: 'hero-sub t-body-lg', [
              .text(
                'Senior Software Engineer specialising in Flutter, Dart, '
                'and cross-platform mobile architecture. I craft '
                'high-performance experiences that feel native on every screen.',
              ),
            ]),

            // CTA row
            div(classes: 'hero-cta', [
              a(
                href: '#projects',
                classes: 'btn-primary',
                [
                  .text('View Projects'),
                  span(classes: 'material-symbols-outlined', [.text('chevron_right')]),
                ],
              ),
              a(
                href: '${RouteConstants.career}/#tech-stack',
                classes: 'btn-ghost',
                [.text('Technical Stack')],
              ),
            ]),
          ]),

          // ── Right / stats card column ───────────────────────
          div(classes: 'hero-card-col', [
            div(classes: 'hero-stats-card tonal-card', [
              // Headline metric
              div(classes: 'stats-header', [
                p(classes: 'stats-label t-label', [.text('Apps Shipped')]),
                p(classes: 'stats-number', [
                  span(classes: 'stats-big', [.text('40+')]),
                ]),
              ]),

              // Progress bar (uptime / quality proxy)
              div(classes: 'stats-bar-wrap', [
                div(classes: 'stats-bar-label', [
                  span(classes: 't-body', [.text('Crash-free rate')]),
                  span(classes: 't-body stats-bar-pct', [.text('99.9%')]),
                ]),
                div(classes: 'stats-bar-track', [
                  div(classes: 'stats-bar-fill', []),
                ]),
              ]),

              // 2-col stat grid
              div(classes: 'stats-grid', [
                _statCell('5+ yrs', 'Flutter'),
                _statCell('60fps', 'Target'),
                _statCell('\u2248 1M+', 'Users Reached'),
                _statCell('4.8★', 'Avg Rating'),
              ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  static Component _statCell(String value, String label) {
    return div(classes: 'stat-cell', [
      p(classes: 'stat-value', [.text(value)]),
      p(classes: 'stat-label t-label', [.text(label)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    // ── Section wrapper ─────────────────────────────────────────────────────
    css('.hero-section').styles(
      padding: .symmetric(vertical: 5.rem),
      raw: {'padding-top': '8rem'}, // account for fixed topbar
    ),

    // Two-column layout on desktop
    css('.hero-inner').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(3.rem),
      flexWrap: .wrap,
    ),

    // ── Left column ─────────────────────────────────────────────────────────
    css('.hero-text').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.5.rem),
      flex: Flex(grow: 1, shrink: 1, basis: 300.px),
    ),

    // Status pill
    css('.status-pill').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
      alignItems: .center,
      gap: Gap.all(0.5.rem),
      backgroundColor: surfaceContainerHigh,
      raw: {'display': 'inline-flex'},
    ),
    css('.status-dot').styles(
      width: 8.px,
      height: 8.px,
      radius: BorderRadius.circular(99.px),
      backgroundColor: primaryColor,
    ),

    // Headline
    css('.hero-headline').styles(
      color: onSurface,
      raw: {'white-space': 'pre-line'},
    ),
    css('.hero-headline--accent').styles(
      color: primaryColor,
      fontStyle: .italic,
    ),

    // Sub-headline
    css('.hero-sub').styles(
      maxWidth: 520.px,
      color: onSurfaceVariant,
    ),

    // CTA row
    css('.hero-cta').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.75.rem),
    ),

    // Primary button
    css('.btn-primary').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 1.25.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      transition: Transition('background-color', duration: Duration(milliseconds: 200)),
      alignItems: .center,
      color: onPrimary,
      fontSize: 14.px,
      fontWeight: .w600,
      backgroundColor: primaryColor,
    ),
    css('.btn-primary:hover').styles(backgroundColor: onPrimaryFixedVariant),

    // Ghost / outline button
    css('.btn-ghost').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 1.25.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      transition: Transition('background-color', duration: Duration(milliseconds: 200)),
      alignItems: .center,
      color: onSurface,
      fontSize: 14.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainerHigh,
    ),
    css('.btn-ghost:hover').styles(backgroundColor: surfaceContainerHighest),

    // ── Right / stats card column ────────────────────────────────────────────
    css('.hero-card-col').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 280.px),
    ),

    css('.hero-stats-card').styles(
      display: .flex,
      padding: .all(1.5.rem),
      flexDirection: .column,
      gap: Gap.all(1.25.rem),
      backgroundColor: surfaceContainerLowest,
      raw: {'box-shadow': '0px 8px 32px rgba(26,28,30,0.08)'},
    ),

    // Headline metric
    css('.stats-header').styles(raw: {'border-bottom': '1px solid ${outlineVariant.value}', 'padding-bottom': '1rem'}),
    css('.stats-label').styles(color: onSurfaceVariant, raw: {'margin-bottom': '0.25rem'}),
    css('.stats-big').styles(
      color: onSurface,
      fontSize: 36.px,
      fontWeight: .w700,
      raw: {'letter-spacing': '-0.02em'},
    ),

    // Progress bar
    css('.stats-bar-label').styles(display: .flex, justifyContent: .spaceBetween, raw: {'margin-bottom': '0.5rem'}),
    css('.stats-bar-pct').styles(color: primaryColor, fontWeight: .w600),
    css('.stats-bar-track').styles(
      height: 4.px,
      radius: BorderRadius.circular(99.px),
      overflow: .clip,
      backgroundColor: surfaceContainerHighest,
    ),
    css('.stats-bar-fill').styles(
      height: 4.px,
      radius: BorderRadius.circular(99.px),
      backgroundColor: primaryColor,
      raw: {'width': '99.9%'},
    ),

    // 2-col stat grid
    css('.stats-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(0.75.rem),
    ),
    css('.stat-cell').styles(
      padding: .all(0.75.rem),
      radius: BorderRadius.circular(8.px),
      backgroundColor: surfaceContainerLow,
    ),
    css('.stat-value').styles(fontSize: 18.px, fontWeight: .w700, color: onSurface),
    css('.stat-label').styles(color: onSurfaceVariant, raw: {'margin-top': '0.125rem'}),

    // ── Responsive ──────────────────────────────────────────────────────────
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.hero-section').styles(raw: {'padding-top': '5.5rem', 'padding-bottom': '3rem'}),
      css('.hero-card-col').styles(flex: Flex(grow: 1, shrink: 1, basis: 100.percent)),
    ]),
  ];
}
