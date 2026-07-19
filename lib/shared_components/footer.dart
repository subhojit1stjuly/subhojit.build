import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';

class Footer extends StatelessComponent {
  final List<({String label, String href})> links;

  const Footer({super.key, required this.links});

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'footer-rule', []),
      div(classes: 'footer-inner container', [
        p(classes: 'footer-brand', [.text('Subhojit.dev')]),
        nav(classes: 'footer-links', [
          for (final link in links)
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
      padding: .symmetric(vertical: 2.5.rem),
      backgroundColor: surfaceColor,
    ),
    css('.footer-rule').styles(
      height: 1.px,
      backgroundColor: outlineVariant,
      raw: {'margin-bottom': '2rem'},
    ),
    css('.footer-inner').styles(
      display: .flex,
      flexWrap: .wrap,
      justifyContent: .spaceBetween,
      alignItems: .center,
      gap: Gap.all(1.rem),
    ),
    css('.footer-brand').styles(
      color: primaryColor,
      fontSize: 15.px,
      fontWeight: .w700,
      raw: {'letter-spacing': '-0.01em'},
    ),
    css('.footer-links').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(1.5.rem),
    ),
    css('.footer-link').styles(
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      color: onSurfaceVariant,
    ),
    css('.footer-link:hover').styles(color: primaryColor),
    css('.footer-copy').styles(color: onSurfaceVariant, fontSize: 13.px),
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.footer-inner').styles(
        flexDirection: .column,
        gap: Gap.all(0.75.rem),
        textAlign: TextAlign.center,
      ),
      css('.footer-links').styles(justifyContent: .center),
    ]),
  ];
}
