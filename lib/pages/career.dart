import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/career_section.dart';
import '../components/philosophy_section.dart';
import '../constants/theme.dart';
import '../models/job_experience.dart';

/// Career & Experience page (/career).
class CareerPage extends StatelessComponent {
  const CareerPage({super.key});

  @override
  Component build(BuildContext context) {
    // TODO: Fetch from jaspr_content
    final jobs = [
      JobExperience(
        id: '1',
        duration: 'Jan 2022 — Present',
        role: 'Senior Software Engineer',
        company: 'Fintech Startup (Mobile Lead)',
        responsibilities: [
          'Led mobile architecture migration to Clean Architecture with Riverpod. Reduced app startup time by 40% and achieved 99.9% crash-free sessions for 500k+ active users across Android and iOS.',
        ],
      ),
      JobExperience(
        id: '2',
        duration: 'Mar 2020 — Dec 2021',
        role: 'Flutter Developer',
        company: 'Product Agency',
        responsibilities: [
          'Built 8 cross-platform apps from 0 to 1. Implemented complex custom UI components and animations. Integrated native SDKs via platform channels on both Android and iOS.',
        ],
      ),
      JobExperience(
        id: '3',
        duration: 'Jun 2019 — Feb 2020',
        role: 'Android Developer',
        company: 'Mobile-First Startup',
        responsibilities: [
          'Developed native Android features in Kotlin. Migrated existing Java codebase to Kotlin and introduced MVVM architecture for the core app used by 100k+ users.',
        ],
      ),
    ];

    return Component.fragment([
      const _CareerHero(),
      CareerSection(jobs: jobs),
      const _AcademicSection(),
      const _CompetenciesSection(),
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
      raw: {
        'padding-top': '8rem',
        'text-align': 'center',
        'background': 'linear-gradient(to bottom, ${surfaceContainerLow.value}, ${surfaceColor.value})',
      },
    ),
    css('.chero-inner').styles(
      display: .flex, flexDirection: .column,
      alignItems: .center, gap: Gap.all(1.5.rem),
    ),
    css('.chero-pill').styles(
      display: .inlineFlex, alignItems: .center, gap: Gap.all(0.5.rem),
      padding: .symmetric(horizontal: 1.rem, vertical: 0.375.rem),
      backgroundColor: surfaceContainerHigh,
      radius: BorderRadius.circular(99.px),
    ),
    css('.chero-pill-icon').styles(fontSize: 16.px, color: primaryColor),
    css('.chero-headline').styles(color: onSurface, raw: {'white-space': 'pre-line'}),
    css('.chero-sub').styles(color: onSurfaceVariant, maxWidth: 600.px),

    // ── Academic & Validation ────────────────────────────────────────────────
    css('.academic-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.academic-heading').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.875.rem),
      raw: {'margin-bottom': '2rem'},
    ),
    css('.heading-bar').styles(
      width: 4.px, height: 32.px, backgroundColor: primaryColor,
      radius: BorderRadius.circular(2.px),
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
      backgroundColor: surfaceContainerLowest,
      radius: BorderRadius.circular(16.px),
      padding: .all(1.5.rem),
      display: .flex, flexDirection: .column,
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.cert-icon-wrap').styles(
      display: .inlineFlex, alignItems: .center, justifyContent: .center,
      width: 48.px, height: 48.px,
      radius: BorderRadius.circular(12.px),
      backgroundColor: primaryFixed, color: primaryColor,
      raw: {'margin-bottom': '1rem'},
    ),
    css('.cert-type').styles(
      fontSize: 11.px, fontWeight: .w500, color: primaryColor,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.06em', 'margin-bottom': '0.375rem'},
    ),
    css('.cert-name').styles(
      fontSize: 15.px, fontWeight: .w700, color: onSurface,
      raw: {'line-height': '1.4', 'margin-bottom': '0.375rem'},
    ),
    css('.cert-meta').styles(
      fontSize: 12.px, color: onSurfaceVariant,
      raw: {'margin-top': 'auto', 'padding-top': '0.75rem', 'margin-bottom': '0.75rem'},
    ),
    css('.cert-link').styles(
      display: .inlineFlex, alignItems: .center, gap: Gap.all(0.25.rem),
      fontSize: 12.px, fontWeight: .w600, color: primaryColor,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
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
      radius: BorderRadius.circular(20.px),
      padding: .all(2.rem),
      display: .flex, flexDirection: .column, justifyContent: .center,
    ),
    css('.comp-block--dark').styles(backgroundColor: inverseSurface),
    css('.comp-block--dark .comp-block-label').styles(
      color: inverseOnSurface, raw: {'margin-bottom': '1.25rem'},
    ),
    css('.comp-tags').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.5.rem)),
    css('.comp-tag').styles(
      fontSize: 12.px, fontWeight: .w500, color: inverseOnSurface,
      backgroundColor: Color('#ffffff20'),
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
    ),
    css('.comp-block--purple').styles(
      backgroundColor: primaryContainer, textAlign: TextAlign.center,
    ),
    css('.comp-stat-num').styles(
      fontSize: 56.px, fontWeight: .w700, color: onPrimary,
      raw: {'line-height': '1', 'margin-bottom': '0.5rem'},
    ),
    css('.comp-stat-label').styles(color: onPrimary),
    css('.comp-block--lavender').styles(
      backgroundColor: primaryFixed, textAlign: TextAlign.center,
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

// ── Private sub-components (no @css — styles live in CareerPage above) ────────

class _CareerHero extends StatelessComponent {
  const _CareerHero();

  @override
  Component build(BuildContext context) {
    return section(classes: 'chero-section', [
      div(classes: 'chero-inner container', [
        div(classes: 'chero-pill', [
          span(classes: 'material-symbols-outlined chero-pill-icon', [.text('verified')]),
          span(classes: 't-label', [.text('Executive Experience')]),
        ]),
        h1(classes: 'chero-headline t-display', [
          .text('Sculpting Apps\nat Scale.'),
        ]),
        p(classes: 'chero-sub t-body-lg', [
          .text(
            'Over 5 years crafting high-performance Flutter applications, '
            'leading mobile engineering teams, and driving product quality '
            'for fintech and consumer-tech companies.',
          ),
        ]),
      ]),
    ]);
  }
}

// ── Certification data ────────────────────────────────────────────────────────

class _Cert {
  const _Cert({required this.icon, required this.type, required this.name,
               required this.meta, required this.link});
  final String icon, type, name, meta, link;
}

const _certs = [
  _Cert(icon: 'cloud', type: 'Certification',
        name: 'AWS Cloud Practitioner', meta: 'Credential #CLP-2023', link: '#'),
  _Cert(icon: 'school', type: 'Education',
        name: 'B.Tech Computer Science', meta: 'Class of 2019', link: '#'),
  _Cert(icon: 'verified_user', type: 'Certification',
        name: 'Google Associate Android Dev', meta: 'Active since 2022', link: '#'),
];

class _AcademicSection extends StatelessComponent {
  const _AcademicSection();

  @override
  Component build(BuildContext context) {
    return section(classes: 'academic-section', [
      div(classes: 'academic-inner container', [
        div(classes: 'academic-heading', [
          div(classes: 'heading-bar', []),
          h2(classes: 'academic-title t-headline', [.text('Academic & Validation')]),
        ]),
        div(classes: 'cert-grid', [
          for (final c in _certs) _CertCard(cert: c),
        ]),
      ]),
    ]);
  }
}

class _CertCard extends StatelessComponent {
  const _CertCard({required this.cert});
  final _Cert cert;

  @override
  Component build(BuildContext context) {
    return div(classes: 'cert-card', [
      div(classes: 'cert-icon-wrap', [
        span(classes: 'material-symbols-outlined', [.text(cert.icon)]),
      ]),
      p(classes: 'cert-type', [.text(cert.type)]),
      p(classes: 'cert-name', [.text(cert.name)]),
      div(styles: Styles(flex: Flex(grow: 1)), []),
      p(classes: 'cert-meta', [.text(cert.meta)]),
      a(href: cert.link, classes: 'cert-link', [
        .text('Verify'),
        span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
      ]),
    ]);
  }
}

// ── Competencies section ──────────────────────────────────────────────────────

const _compSkills = [
  'Flutter', 'Dart', 'State Management', 'Firebase',
  'Mobile Architecture', 'CI/CD', 'Performance Tuning',
];

class _CompetenciesSection extends StatelessComponent {
  const _CompetenciesSection();

  @override
  Component build(BuildContext context) {
    return section(classes: 'comp-section', [
      div(classes: 'comp-inner container', [
        div(classes: 'comp-grid', [
          div(classes: 'comp-block comp-block--dark', [
            p(classes: 'comp-block-label t-label', [.text('Core Competencies')]),
            div(classes: 'comp-tags', [
              for (final s in _compSkills) span(classes: 'comp-tag', [.text(s)]),
            ]),
          ]),
          div(classes: 'comp-block comp-block--purple', [
            p(classes: 'comp-stat-num', [.text('5+')]),
            p(classes: 'comp-stat-label t-label', [.text('Years in Flutter')]),
          ]),
          div(classes: 'comp-block comp-block--lavender', [
            p(classes: 'comp-stat-num comp-stat-num--dark', [.text('40+')]),
            p(classes: 'comp-stat-label comp-stat-label--dark t-label', [.text('Apps Shipped')]),
          ]),
        ]),
      ]),
    ]);
  }
}
