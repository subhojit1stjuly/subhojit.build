import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  static const _links = [
    (label: 'GitHub',   href: 'https://github.com/subhojit'),
    (label: 'LinkedIn', href: 'https://linkedin.com/in/subhojit'),
    (label: 'Email',    href: 'mailto:hello@subhojitpramanik.dev'),
  ];

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'footer-rule', []),
      div(classes: 'footer-inner container', [
        p(classes: 'footer-brand', [.text('Subhojit.dev')]),
        nav(classes: 'footer-links', [
          for (final link in _links)
            a(
              href: link.href,
              classes: 'footer-link t-body',
              attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
              [.text(link.label)],
            ),
        ]),
        p(classes: 'footer-copy t-body', [
          .text('\u00a9 ${DateTime.now().year} Subhojit Pramanik'),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.site-footer').styles(
      backgroundColor: surfaceColor,
      padding: .symmetric(vertical: 2.5.rem),
    ),
    css('.footer-rule').styles(
      height: 1.px,
      backgroundColor: outlineVariant,
      raw: {'margin-bottom': '2rem'},
    ),
    css('.footer-inner').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      alignItems: .center,
      flexWrap: .wrap,
      gap: Gap.all(1.rem),
    ),
    css('.footer-brand').styles(
      fontSize: 15.px,
      fontWeight: .w700,
      color: primaryColor,
      raw: {'letter-spacing': '-0.01em'},
    ),
    css('.footer-links').styles(
      display: .flex,
      gap: Gap.all(1.5.rem),
      alignItems: .center,
    ),
    css('.footer-link').styles(
      color: onSurfaceVariant,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
    ),
    css('.footer-link:hover').styles(color: primaryColor),
    css('.footer-copy').styles(color: onSurfaceVariant, fontSize: 13.px),
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.footer-inner').styles(
        flexDirection: .column,
        textAlign: TextAlign.center,
        gap: Gap.all(0.75.rem),
      ),
      css('.footer-links').styles(justifyContent: .center),
    ]),
  ];
}
