import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

// Flat list of technical skills to render as badge chips.
const _skills = [
  'Flutter',
  'Dart',
  'Riverpod',
  'Bloc',
  'Firebase',
  'REST APIs',
  'GraphQL',
  'SQLite',
  'CI/CD',
  'GitHub Actions',
  'Performance Tuning',
  'Clean Architecture',
  'MVVM',
  'TDD',
  'Android',
  'iOS',
];

/// About section — two-column layout on desktop, single column on mobile.
///
/// Left column  : Bio paragraph + professional summary.
/// Right column : Skill badge grid.
class AboutSection extends StatelessComponent {
  const AboutSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'about',
      classes: 'about-section',
      [
        div(classes: 'about-inner container', [
          // ── Section heading ──────────────────────────────────
          div(classes: 'section-heading', [
            h2(classes: 'section-title', [.text('About Me')]),
            div(classes: 'section-divider', []),
          ]),

          // ── Two-column body ───────────────────────────────────
          div(classes: 'about-body', [
            // Left: bio copy.
            div(classes: 'about-bio', [
              p(classes: 'bio-text', [
                .text(
                  'I\'m a Senior Software Engineer with a passion for building '
                  'mobile experiences that feel native, performant, and '
                  'delightful. I\'ve shipped production Flutter apps to '
                  'millions of users across Android and iOS.',
                ),
              ]),
              p(classes: 'bio-text', [
                .text(
                  'My focus areas include mobile architecture (Clean '
                  'Architecture & MVVM), state management (Riverpod & Bloc), '
                  'smooth 60/120 fps animations, and developer-experience '
                  'tooling that helps teams move faster.',
                ),
              ]),
              p(classes: 'bio-text', [
                .text(
                  'When I\'m not pushing pixels, I\'m contributing to open-source, '
                  'writing dev articles, or exploring the latest Dart language '
                  'features.',
                ),
              ]),
            ]),

            // Right: skill badges.
            div(classes: 'about-skills', [
              h3(classes: 'skills-heading', [.text('Core Stack')]),
              div(classes: 'skills-grid', [
                for (final skill in _skills) span(classes: 'skill-badge', [.text(skill)]),
              ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    // Section outer wrapper — generous vertical breathing room.
    css('.about-section').styles(
      padding: .symmetric(vertical: 6.rem),
    ),

    // ── Section heading ──────────────────────────────────────────
    css('.section-heading').styles(
      raw: {'margin-bottom': '3.5rem'},
    ),

    css('.section-title').styles(
      color: textPrimary,
      fontSize: 2.25.rem,
      fontWeight: .w700,
      raw: {'margin-bottom': '0.75rem'},
    ),

    // Short accent underline beneath the section title.
    css('.section-divider').styles(
      width: 48.px,
      height: 4.px,
      radius: BorderRadius.circular(2.px),
      backgroundColor: accentColor,
    ),

    // ── Two-column body ──────────────────────────────────────────
    // On desktop: side-by-side flex row.
    // On mobile : stacks via flex-wrap.
    css('.about-body').styles(
      display: .flex,
      flexWrap: .wrap,
      alignItems: .start,
      gap: Gap.all(4.rem),
    ),

    // ── Bio column ───────────────────────────────────────────────
    css('.about-bio').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 300.px),
    ),

    css('.bio-text').styles(
      color: textSecondary,
      fontSize: 1.0625.rem,
      lineHeight: 1.75.em,
      raw: {'margin-bottom': '1.25rem'},
    ),
    css('.bio-text:last-child').styles(raw: {'margin-bottom': '0'}),

    // ── Skills column ─────────────────────────────────────────────
    css('.about-skills').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 280.px),
    ),

    css('.skills-heading').styles(
      color: textSecondary,
      fontSize: 1.rem,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      letterSpacing: 0.08.em,
      raw: {'margin-bottom': '1.25rem'},
    ),

    // Wrap-flex grid of badge chips.
    css('.skills-grid').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.625.rem),
    ),

    // Individual skill badge.
    css('.skill-badge').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 0.875.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
      alignItems: .center,
      color: accentColor,
      fontSize: 0.8125.rem,
      fontWeight: .w500,
      backgroundColor: tagBgColor,
    ),

    // Mobile: let columns stack full-width.
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.about-section').styles(padding: .symmetric(vertical: 4.rem)),
      css('.about-body').styles(gap: Gap.all(2.5.rem)),
      css('.about-bio').styles(flex: Flex(grow: 1, shrink: 1, basis: 100.percent)),
      css('.about-skills').styles(flex: Flex(grow: 1, shrink: 1, basis: 100.percent)),
    ]),
  ];
}
