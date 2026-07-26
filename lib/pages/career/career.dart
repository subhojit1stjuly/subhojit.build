import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/career/components/academic_section.dart';
import 'package:subhojit_build/pages/career/components/career_hero.dart';
import 'package:subhojit_build/pages/career/components/competencies_section.dart';
import 'package:subhojit_build/pages/career/models/certification.dart';

import 'components/career_section.dart';
import 'components/philosophy_section.dart';
import 'models/job_experience.dart';

/// Career & Experience page (/career).
class CareerPage extends StatelessComponent {
  final List<JobExperience> jobs;
  final List<Certification> certificates;
  const CareerPage({
    super.key,
    required this.jobs,
    required this.certificates,
  });

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      const CareerHero(),
      CareerSection(jobs: jobs),
      AcademicSection(certificates: certificates),
      const CompetenciesSection(),
      const PhilosophySection(),
    ]);
  }

  // All CSS for this page (including private sub-components) lives here so
  // the jaspr_builder @css annotation works on a public class.
  @css
  static List<StyleRule> get styles => [
    // ── Career Hero ─────────────────────────────────────────────────────────
    css('.chero-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.chero-inner').styles(
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: Gap.all(1.5.rem),
    ),
    css('.chero-pill').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 1.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
      alignItems: .center,
      gap: Gap.all(0.5.rem),
      backgroundColor: surfaceContainerHigh,
    ),
    css('.chero-pill-icon').styles(color: primaryColor, fontSize: 16.px),
    css('.chero-headline').styles(color: onSurface, raw: {'white-space': 'pre-line'}),
    css('.chero-sub').styles(maxWidth: 600.px, color: onSurfaceVariant),

    // ── Academic & Validation ────────────────────────────────────────────────
    css('.academic-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.academic-heading').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.875.rem),
      raw: {'margin-bottom': '2rem'},
    ),
    css('.heading-bar').styles(
      width: 4.px,
      height: 32.px,
      radius: BorderRadius.circular(2.px),
      backgroundColor: primaryColor,
    ),
    css('.academic-title').styles(color: onSurface),
    css('.cert-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack(TrackSize.fr(1)),
          GridTrack(TrackSize.fr(1)),
          GridTrack(TrackSize.fr(1)),
        ]),
      ),
      gap: Gap.all(1.25.rem),
    ),
    css('.cert-card').styles(
      display: .flex,
      padding: .all(1.5.rem),
      radius: BorderRadius.circular(16.px),
      flexDirection: .column,
      backgroundColor: surfaceContainerLowest,
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.cert-icon-wrap').styles(
      display: .inlineFlex,
      width: 48.px,
      height: 48.px,
      radius: BorderRadius.circular(12.px),
      justifyContent: .center,
      alignItems: .center,
      color: primaryColor,
      backgroundColor: primaryFixed,
      raw: {'margin-bottom': '1rem'},
    ),
    css('.cert-type').styles(
      color: primaryColor,
      fontSize: 11.px,
      fontWeight: .w500,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.06em', 'margin-bottom': '0.375rem'},
    ),
    css('.cert-name').styles(
      color: onSurface,
      fontSize: 15.px,
      fontWeight: .w700,
      raw: {'line-height': '1.4', 'margin-bottom': '0.375rem'},
    ),
    css('.cert-meta').styles(
      color: onSurfaceVariant,
      fontSize: 12.px,
      raw: {'margin-top': 'auto', 'padding-top': '0.75rem', 'margin-bottom': '0.75rem'},
    ),
    css('.cert-link').styles(
      display: .inlineFlex,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      gap: Gap.all(0.25.rem),
      color: primaryColor,
      fontSize: 12.px,
      fontWeight: .w600,
    ),
    css('.cert-link:hover').styles(color: onPrimaryFixedVariant),

    // ── Core Competencies ────────────────────────────────────────────────────
    css('.comp-section').styles(padding: .symmetric(vertical: 5.rem)),
    css('.comp-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack(TrackSize.fr(2)),
          GridTrack(TrackSize.fr(1)),
          GridTrack(TrackSize.fr(1)),
        ]),
      ),
      gap: Gap.all(1.rem),
      raw: {'align-items': 'stretch'},
    ),
    css('.comp-block').styles(
      display: .flex,
      padding: .all(2.rem),
      radius: BorderRadius.circular(20.px),
      flexDirection: .column,
      justifyContent: .center,
    ),
    css('.comp-block--dark').styles(backgroundColor: inverseSurface),
    css('.comp-block--dark .comp-block-label').styles(
      color: inverseOnSurface,
      raw: {'margin-bottom': '1.25rem'},
    ),
    css('.comp-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.5.rem)),
    css('.comp-tag').styles(
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
      color: inverseOnSurface,
      fontSize: 12.px,
      fontWeight: .w500,
      backgroundColor: const Color.variable('--surface-container'),
    ),
    css('.comp-block--purple').styles(
      textAlign: TextAlign.center,
      backgroundColor: primaryContainer,
    ),
    css('.comp-stat-num').styles(
      color: onPrimary.light,
      fontSize: 56.px,
      fontWeight: .w700,
      raw: {'line-height': '1', 'margin-bottom': '0.5rem'},
    ),
    css('.comp-stat-label').styles(color: onPrimary.light),
    css('.comp-block--lavender').styles(
      textAlign: TextAlign.center,
      backgroundColor: primaryFixed,
    ),
    css('.comp-stat-num--dark').styles(color: primaryColor),
    css('.comp-stat-label--dark').styles(color: onPrimaryFixedVariant),

    // ── Responsive overrides ─────────────────────────────────────────────────
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.chero-section').styles(raw: {'padding-top': '6rem'}),
      css('.academic-section').styles(padding: .symmetric(vertical: 3.5.rem)),
      css('.cert-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.comp-section').styles(padding: .symmetric(vertical: 3.5.rem)),
      css('.comp-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
    ]),
    css.media(MediaQuery.screen(minWidth: 480.px, maxWidth: 768.px), [
      css('.cert-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
        ),
      ),
    ]),
  ];
}
