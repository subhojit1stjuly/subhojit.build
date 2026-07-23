import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/career/components/desktop_entry.dart';
import 'package:subhojit_build/pages/career/components/mobile_entry.dart';
import 'package:subhojit_build/pages/career/models/job_experience.dart';

/// Career timeline section.
///
/// Mobile  : Vertical dot-and-line, left-to-right.
/// Desktop : Zigzag alternating layout — odd entries (title left / content right),
///           even entries (content left / title right) — separated by a dashed
///           central spine with circular icon nodes.
class CareerSection extends StatelessComponent {
  final List<JobExperience> jobs;

  const CareerSection({super.key, required this.jobs});

  @override
  Component build(BuildContext context) {
    return section(classes: 'career-section', [
      div(classes: 'career-inner container', [
        div(classes: 'career-header', [
          p(classes: 'career-eyebrow t-label', [.text('Experience')]),
          h2(classes: 'career-title t-headline', [.text('Professional Journey')]),
        ]),

        // Mobile: dot-and-line timeline
        div(classes: 'career-timeline career-timeline--mobile', [
          for (final job in jobs) MobileEntry(job: job),
        ]),

        // Desktop: zigzag
        div(classes: 'career-timeline career-timeline--desktop', [
          for (int i = 0; i < jobs.length; i++) DesktopEntry(job: jobs[i], isReversed: i.isOdd),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.career-section').styles(padding: .symmetric(vertical: 5.rem)),
    css('.career-header').styles(raw: {'margin-bottom': '3.5rem', 'text-align': 'center'}),
    css('.career-eyebrow').styles(color: primaryColor, raw: {'margin-bottom': '0.5rem'}),
    css('.career-title').styles(color: onSurface),

    // Mobile timeline — shown on all screens < 768px
    css('.career-timeline--mobile').styles(
      display: .flex,
      flexDirection: .column,
      raw: {'gap': '0'},
    ),
    css('.career-timeline--desktop').styles(display: .none),

    // ── Mobile entry ────────────────────────────────────────────────────────
    css('.mobile-entry').styles(
      display: .flex,
      gap: Gap.all(1.5.rem),
      raw: {'padding-bottom': '2.5rem', 'position': 'relative'},
    ),
    css('.mobile-dot-col').styles(
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      raw: {'flex-shrink': '0', 'padding-top': '4px'},
    ),
    css('.mobile-dot').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      radius: BorderRadius.circular(99.px),
      justifyContent: .center,
      alignItems: .center,
      color: primaryColor,
      backgroundColor: primaryFixed,
      raw: {'flex-shrink': '0', 'z-index': '1'},
    ),
    css('.mobile-spine').styles(
      width: 1.px,
      flex: Flex(grow: 1),
      backgroundColor: outlineVariant,
      raw: {'margin-top': '8px'},
    ),
    css('.mobile-entry:last-child .mobile-spine').styles(display: .none),
    css('.mobile-content').styles(flex: Flex(grow: 1), raw: {'padding-top': '4px'}),
    css('.entry-date').styles(
      color: primaryColor,
      fontSize: 12.px,
      fontWeight: .w600,
      raw: {'margin-bottom': '0.25rem', 'letter-spacing': '0.02em'},
    ),
    css('.entry-role').styles(
      color: onSurface,
      fontSize: 20.px,
      fontWeight: .w700,
      raw: {'margin-bottom': '0.125rem'},
    ),
    css('.entry-company').styles(
      color: primaryColor,
      fontSize: 14.px,
      fontWeight: .w500,
      raw: {'margin-bottom': '0.75rem'},
    ),
    css('.entry-desc').styles(
      color: onSurfaceVariant,
      fontSize: 14.px,
      lineHeight: 1.6.em,
      raw: {'margin-bottom': '0.875rem'},
    ),
    css('.entry-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.375.rem)),
    css('.entry-tag').styles(
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: onSurfaceVariant,
      fontSize: 11.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainerHigh,
    ),

    // ── Desktop zigzag ───────────────────────────────────────────────────────
    css.media(MediaQuery.screen(minWidth: 768.px), [
      css('.career-timeline--mobile').styles(display: .none),
      css('.career-timeline--desktop').styles(
        display: .flex,
        flexDirection: .column,
        raw: {'gap': '0', 'position': 'relative'},
      ),

      // Vertical dashed spine down the centre
      css('.career-timeline--desktop::before').styles(
        raw: {
          'content': '""',
          'position': 'absolute',
          'left': '50%',
          'top': '0',
          'bottom': '0',
          'width': '1px',
          'transform': 'translateX(-50%)',
          'background':
              'repeating-linear-gradient(to bottom, ${outlineVariant.value} 0, ${outlineVariant.value} 8px, transparent 8px, transparent 16px)',
        },
      ),

      // Desktop entry — 3-column grid: text | node | card
      css('.desktop-entry').styles(
        display: .grid,
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack(TrackSize.fr(1)),
            GridTrack(TrackSize(80.px)),
            GridTrack(TrackSize.fr(1)),
          ]),
        ),
        gap: Gap.all(0.rem),
        raw: {'margin-bottom': '3rem', 'align-items': 'center'},
      ),

      // Node column (always centre)
      css('.desktop-node').styles(
        display: .flex,
        justifyContent: .center,
        alignItems: .center,
        raw: {'z-index': '1'},
      ),
      css('.desktop-node-circle').styles(
        display: .flex,
        width: 56.px,
        height: 56.px,
        border: Border.all(color: primaryColor, style: BorderStyle.solid, width: 2.px),
        radius: BorderRadius.circular(99.px),
        justifyContent: .center,
        alignItems: .center,
        color: primaryColor,
        backgroundColor: surfaceContainerLowest,
        raw: {'box-shadow': '0 0 0 6px ${primaryFixed.value}'},
      ),

      // Normal entry (odd): title on left, card on right
      css('.desktop-entry--normal .desktop-title-col').styles(
        raw: {'text-align': 'right', 'padding-right': '2rem'},
      ),
      css('.desktop-entry--normal .desktop-card-col').styles(
        raw: {'text-align': 'left', 'padding-left': '2rem'},
      ),

      // Reversed entry (even): card on left, title on right
      css('.desktop-entry--reversed .desktop-title-col').styles(
        raw: {'order': '3', 'text-align': 'left', 'padding-left': '2rem'},
      ),
      css('.desktop-entry--reversed .desktop-node').styles(raw: {'order': '2'}),
      css('.desktop-entry--reversed .desktop-card-col').styles(
        raw: {'order': '1', 'text-align': 'right', 'padding-right': '2rem'},
      ),

      css('.desktop-date').styles(
        color: primaryColor,
        fontSize: 12.px,
        fontWeight: .w700,
        raw: {'letter-spacing': '0.04em', 'margin-bottom': '0.375rem'},
      ),
      css('.desktop-role').styles(
        color: onSurface,
        fontSize: 22.px,
        fontWeight: .w700,
        raw: {'margin-bottom': '0.25rem'},
      ),
      css('.desktop-company').styles(
        color: primaryColor,
        fontSize: 14.px,
        fontWeight: .w500,
      ),

      // Achievement card
      css('.desktop-card').styles(
        padding: .all(1.25.rem),
        radius: BorderRadius.circular(12.px),
        backgroundColor: surfaceContainerLowest,
        raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
      ),
      css('.desktop-card .entry-desc').styles(raw: {'margin-bottom': '0.75rem'}),
    ]),
  ];
}
