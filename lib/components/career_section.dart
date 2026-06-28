import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class _Job {
  const _Job({required this.date, required this.role, required this.company,
               required this.desc, required this.tags, required this.icon});
  final String date, role, company, desc, icon;
  final List<String> tags;
}

const _jobs = [
  _Job(
    date: 'Jan 2022 — Present',
    role: 'Senior Software Engineer',
    company: 'Fintech Startup (Mobile Lead)',
    desc: 'Led mobile architecture migration to Clean Architecture with Riverpod. '
          'Reduced app startup time by 40% and achieved 99.9% crash-free sessions '
          'for 500k+ active users across Android and iOS.',
    tags: ['Flutter', 'Riverpod', 'Firebase', 'CI/CD'],
    icon: 'person',
  ),
  _Job(
    date: 'Mar 2020 — Dec 2021',
    role: 'Flutter Developer',
    company: 'Product Agency',
    desc: 'Built 8 cross-platform apps from 0 to 1. Implemented complex custom '
          'UI components and animations. Integrated native SDKs via platform '
          'channels on both Android and iOS.',
    tags: ['Flutter', 'Dart', 'Bloc', 'Platform Channels'],
    icon: 'code',
  ),
  _Job(
    date: 'Jun 2019 — Feb 2020',
    role: 'Android Developer',
    company: 'Mobile-First Startup',
    desc: 'Developed native Android features in Kotlin. Migrated existing Java '
          'codebase to Kotlin and introduced MVVM architecture for the core app '
          'used by 100k+ users.',
    tags: ['Android', 'Kotlin', 'MVVM', 'Jetpack'],
    icon: 'android',
  ),
];

/// Career timeline section.
///
/// Mobile  : Vertical dot-and-line, left-to-right.
/// Desktop : Zigzag alternating layout — odd entries (title left / content right),
///           even entries (content left / title right) — separated by a dashed
///           central spine with circular icon nodes.
class CareerSection extends StatelessComponent {
  const CareerSection({super.key});

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
          for (final job in _jobs) _MobileEntry(job: job),
        ]),

        // Desktop: zigzag
        div(classes: 'career-timeline career-timeline--desktop', [
          for (int i = 0; i < _jobs.length; i++)
            _DesktopEntry(job: _jobs[i], isReversed: i.isOdd),
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
      display: .flex, flexDirection: .column, raw: {'gap': '0'},
    ),
    css('.career-timeline--desktop').styles(display: .none),

    // ── Mobile entry ────────────────────────────────────────────────────────
    css('.mobile-entry').styles(
      display: .flex, gap: Gap.all(1.5.rem),
      raw: {'padding-bottom': '2.5rem', 'position': 'relative'},
    ),
    css('.mobile-dot-col').styles(
      display: .flex, flexDirection: .column, alignItems: .center,
      raw: {'flex-shrink': '0', 'padding-top': '4px'},
    ),
    css('.mobile-dot').styles(
      width: 40.px, height: 40.px,
      radius: BorderRadius.circular(99.px),
      backgroundColor: primaryFixed,
      display: .flex, alignItems: .center, justifyContent: .center,
      color: primaryColor,
      raw: {'flex-shrink': '0', 'z-index': '1'},
    ),
    css('.mobile-spine').styles(
      width: 1.px, backgroundColor: outlineVariant,
      flex: Flex(grow: 1),
      raw: {'margin-top': '8px'},
    ),
    css('.mobile-entry:last-child .mobile-spine').styles(display: .none),
    css('.mobile-content').styles(flex: Flex(grow: 1), raw: {'padding-top': '4px'}),
    css('.entry-date').styles(
      fontSize: 12.px, fontWeight: .w600, color: primaryColor,
      raw: {'margin-bottom': '0.25rem', 'letter-spacing': '0.02em'},
    ),
    css('.entry-role').styles(
      fontSize: 20.px, fontWeight: .w700, color: onSurface,
      raw: {'margin-bottom': '0.125rem'},
    ),
    css('.entry-company').styles(
      fontSize: 14.px, color: primaryColor, fontWeight: .w500,
      raw: {'margin-bottom': '0.75rem'},
    ),
    css('.entry-desc').styles(
      fontSize: 14.px, color: onSurfaceVariant, lineHeight: 1.6.em,
      raw: {'margin-bottom': '0.875rem'},
    ),
    css('.entry-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.375.rem)),
    css('.entry-tag').styles(
      fontSize: 11.px, fontWeight: .w500, color: onSurfaceVariant,
      backgroundColor: surfaceContainerHigh,
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
    ),

    // ── Desktop zigzag ───────────────────────────────────────────────────────
    css.media(MediaQuery.screen(minWidth: 768.px), [
      css('.career-timeline--mobile').styles(display: .none),
      css('.career-timeline--desktop').styles(
        display: .flex, flexDirection: .column,
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
          'background': 'repeating-linear-gradient(to bottom, ${outlineVariant.value} 0, ${outlineVariant.value} 8px, transparent 8px, transparent 16px)',
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
        display: .flex, alignItems: .center, justifyContent: .center,
        raw: {'z-index': '1'},
      ),
      css('.desktop-node-circle').styles(
        width: 56.px, height: 56.px,
        radius: BorderRadius.circular(99.px),
        backgroundColor: surfaceContainerLowest,
        border: Border.all(color: primaryColor, style: BorderStyle.solid, width: 2.px),
        display: .flex, alignItems: .center, justifyContent: .center,
        color: primaryColor,
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
        fontSize: 12.px, fontWeight: .w700, color: primaryColor,
        raw: {'letter-spacing': '0.04em', 'margin-bottom': '0.375rem'},
      ),
      css('.desktop-role').styles(
        fontSize: 22.px, fontWeight: .w700, color: onSurface,
        raw: {'margin-bottom': '0.25rem'},
      ),
      css('.desktop-company').styles(
        fontSize: 14.px, color: primaryColor, fontWeight: .w500,
      ),

      // Achievement card
      css('.desktop-card').styles(
        backgroundColor: surfaceContainerLowest,
        radius: BorderRadius.circular(12.px),
        padding: .all(1.25.rem),
        raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
      ),
      css('.desktop-card .entry-desc').styles(raw: {'margin-bottom': '0.75rem'}),
    ]),
  ];
}

// ── Mobile entry ──────────────────────────────────────────────────────────────
class _MobileEntry extends StatelessComponent {
  const _MobileEntry({required this.job});
  final _Job job;

  @override
  Component build(BuildContext context) {
    return div(classes: 'mobile-entry', [
      div(classes: 'mobile-dot-col', [
        div(classes: 'mobile-dot', [
          span(classes: 'material-symbols-outlined', [.text(job.icon)]),
        ]),
        div(classes: 'mobile-spine', []),
      ]),
      div(classes: 'mobile-content', [
        p(classes: 'entry-date', [.text(job.date)]),
        p(classes: 'entry-role', [.text(job.role)]),
        p(classes: 'entry-company', [.text(job.company)]),
        p(classes: 'entry-desc', [.text(job.desc)]),
        div(classes: 'entry-tags', [
          for (final tag in job.tags) span(classes: 'entry-tag', [.text(tag)]),
        ]),
      ]),
    ]);
  }
}

// ── Desktop zigzag entry ───────────────────────────────────────────────────────
class _DesktopEntry extends StatelessComponent {
  const _DesktopEntry({required this.job, required this.isReversed});
  final _Job job;
  final bool isReversed;

  @override
  Component build(BuildContext context) {
    final modClass = isReversed ? 'desktop-entry--reversed' : 'desktop-entry--normal';
    return div(classes: 'desktop-entry $modClass', [
      // Title column
      div(classes: 'desktop-title-col', [
        p(classes: 'desktop-date', [.text(job.date)]),
        p(classes: 'desktop-role', [.text(job.role)]),
        p(classes: 'desktop-company', [.text(job.company)]),
      ]),
      // Centre node
      div(classes: 'desktop-node', [
        div(classes: 'desktop-node-circle', [
          span(classes: 'material-symbols-outlined', [.text(job.icon)]),
        ]),
      ]),
      // Content card
      div(classes: 'desktop-card-col', [
        div(classes: 'desktop-card', [
          p(classes: 'entry-desc', [.text(job.desc)]),
          div(classes: 'entry-tags', [
            for (final tag in job.tags) span(classes: 'entry-tag', [.text(tag)]),
          ]),
        ]),
      ]),
    ]);
  }
}
