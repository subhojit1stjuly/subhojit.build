import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class _Credential {
  const _Credential({required this.type, required this.name, required this.icon, required this.meta});
  final String type, name, icon, meta;
}

const _credentials = [
  _Credential(type: 'Certification', name: 'Google Associate Android Developer', icon: 'android', meta: 'Active since 2022'),
  _Credential(type: 'Certification', name: 'AWS Cloud Practitioner', icon: 'cloud', meta: 'Active since 2023'),
  _Credential(type: 'Specialisation', name: 'Flutter & Dart', icon: 'code', meta: '5+ years'),
  _Credential(type: 'Education', name: 'B.Tech Computer Science', icon: 'school', meta: 'Class of 2019'),
];

const _skills = [
  'Flutter', 'Dart', 'Riverpod', 'Bloc', 'Firebase',
  'REST APIs', 'GraphQL', 'SQLite', 'CI/CD', 'GitHub Actions',
  'Performance Tuning', 'Clean Architecture', 'MVVM', 'TDD', 'Android', 'iOS',
];

class AboutSection extends StatelessComponent {
  const AboutSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'about',
      classes: 'about-section',
      [
        div(classes: 'about-inner container', [
          div(classes: 'about-header', [
            p(classes: 'about-eyebrow t-label', [.text('About Me')]),
            h2(classes: 'about-title t-headline', [
              .text('Crafting Apps with\nPurpose & Precision'),
            ]),
          ]),
          div(classes: 'about-body', [
            div(classes: 'about-bio', [
              p(classes: 'about-bio-text t-body-lg', [
                .text(
                  "I\'m a Senior Software Engineer passionate about building "
                  "mobile experiences that feel native, performant, and "
                  "delightful. I\'ve shipped production Flutter apps reaching "
                  "millions of users across Android and iOS.",
                ),
              ]),
              p(classes: 'about-bio-text t-body-lg', [
                .text(
                  'My focus: mobile architecture (Clean Arch & MVVM), state '
                  'management (Riverpod & Bloc), smooth 60/120 fps animations, '
                  'and developer-experience tooling that helps teams ship faster.',
                ),
              ]),
              div(classes: 'skills-section', [
                p(classes: 'skills-label t-label', [.text('Core Stack')]),
                div(classes: 'skills-wrap', [
                  for (final skill in _skills)
                    span(classes: 'skill-chip', [.text(skill)]),
                ]),
              ]),
            ]),
            div(classes: 'about-credentials', [
              p(classes: 'cred-header t-label', [.text('Validations')]),
              div(classes: 'cred-grid', [
                for (final c in _credentials) _CredentialCard(cred: c),
              ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.about-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.about-header').styles(raw: {'margin-bottom': '3rem'}),
    css('.about-eyebrow').styles(color: primaryColor, raw: {'margin-bottom': '0.5rem'}),
    css('.about-title').styles(color: onSurface, raw: {'white-space': 'pre-line'}),
    css('.about-body').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(3.rem),
      alignItems: .start,
    ),
    css('.about-bio').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 320.px),
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.25.rem),
    ),
    css('.about-bio-text').styles(color: onSurfaceVariant, lineHeight: 1.75.em),
    css('.skills-section').styles(raw: {'margin-top': '0.75rem'}),
    css('.skills-label').styles(color: onSurfaceVariant, raw: {'margin-bottom': '0.75rem'}),
    css('.skills-wrap').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.5.rem)),
    css('.skill-chip').styles(
      display: .inlineFlex,
      fontSize: 12.px,
      fontWeight: .w500,
      color: primaryColor,
      backgroundColor: primaryFixed,
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.375.rem),
      radius: BorderRadius.circular(99.px),
    ),
    css('.about-credentials').styles(flex: Flex(grow: 1, shrink: 1, basis: 280.px)),
    css('.cred-header').styles(color: onSurfaceVariant, raw: {'margin-bottom': '0.75rem'}),
    css('.cred-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(0.75.rem),
    ),
    css('.cred-card').styles(
      backgroundColor: surfaceContainerLowest,
      radius: BorderRadius.circular(12.px),
      padding: .all(1.rem),
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(0.5.rem),
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.cred-icon').styles(
      display: .inlineFlex,
      alignItems: .center,
      justifyContent: .center,
      width: 36.px,
      height: 36.px,
      radius: BorderRadius.circular(8.px),
      backgroundColor: primaryFixed,
      color: primaryColor,
      raw: {'margin-bottom': '0.25rem'},
    ),
    css('.cred-type').styles(fontSize: 10.px, fontWeight: .w500,
        textTransform: TextTransform.upperCase, color: primaryColor,
        raw: {'letter-spacing': '0.06em'}),
    css('.cred-name').styles(fontSize: 13.px, fontWeight: .w600, color: onSurface,
        raw: {'line-height': '1.4'}),
    css('.cred-meta').styles(fontSize: 11.px, color: onSurfaceVariant),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.about-section').styles(padding: .symmetric(vertical: 3.5.rem)),
      css('.about-bio').styles(flex: Flex(grow: 1, shrink: 1, basis: 100.percent)),
      css('.about-credentials').styles(flex: Flex(grow: 1, shrink: 1, basis: 100.percent)),
    ]),
  ];
}

class _CredentialCard extends StatelessComponent {
  const _CredentialCard({required this.cred});
  final _Credential cred;

  @override
  Component build(BuildContext context) {
    return div(classes: 'cred-card', [
      div(classes: 'cred-icon', [
        span(classes: 'material-symbols-outlined', [.text(cred.icon)]),
      ]),
      p(classes: 'cred-type', [.text(cred.type)]),
      p(classes: 'cred-name', [.text(cred.name)]),
      p(classes: 'cred-meta', [.text(cred.meta)]),
    ]);
  }
}
