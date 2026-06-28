import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

/// Footer — copyright notice and social / contact links.
///
/// Layout:
///   Desktop : copyright left, links right (flex row).
///   Mobile  : stacked column, centred.
class Footer extends StatelessComponent {
  const Footer({super.key});

  // ── Social / contact link data ──────────────────────────────
  static const _links = [
    (label: 'GitHub', href: 'https://github.com/subhojit', icon: 'GH'),
    (label: 'LinkedIn', href: 'https://linkedin.com/in/subhojit', icon: 'LI'),
    (label: 'Email', href: 'mailto:hello@subhojitpramanik.dev', icon: '✉'),
  ];

  @override
  Component build(BuildContext context) {
    return footer(
      id: 'contact',
      classes: 'site-footer',
      [
        // Thin accent rule above the footer.
        div(classes: 'footer-rule', []),

        div(classes: 'footer-inner container', [
          // Copyright.
          p(classes: 'footer-copy', [
            .text('© ${DateTime.now().year} Subhojit Pramanik. All rights reserved.'),
          ]),

          // Social links row.
          nav(classes: 'footer-links', [
            for (final link in _links)
              a(
                href: link.href,
                classes: 'footer-link',
                attributes: {
                  'target': '_blank',
                  'rel': 'noopener noreferrer',
                  'aria-label': link.label,
                },
                [
                  span(classes: 'footer-link-icon', [.text(link.icon)]),
                  span(classes: 'footer-link-label', [.text(link.label)]),
                ],
              ),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    // ── Outer footer wrapper ────────────────────────────────────
    css('.site-footer').styles(
      padding: .symmetric(vertical: 3.rem),
      backgroundColor: surfaceColor,
    ),

    // Thin top border (1 px accent rule).
    css('.footer-rule').styles(
      height: 1.px,
      backgroundColor: borderColor,
      raw: {'margin-bottom': '2rem'},
    ),

    // ── Inner row: copyright ←————→ links ───────────────────────
    css('.footer-inner').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      alignItems: .center,
      flexWrap: .wrap,
      gap: Gap.all(1.25.rem),
    ),

    // Copyright text.
    css('.footer-copy').styles(
      fontSize: 0.875.rem,
      color: textSecondary,
    ),

    // Links row.
    css('.footer-links').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(1.5.rem),
    ),

    // Individual footer link.
    css('.footer-link').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.375.rem),
      fontSize: 0.875.rem,
      fontWeight: .w500,
      color: textSecondary,
      transition: Transition('color', duration: Duration(milliseconds: 200), curve: Curve.ease),
    ),
    css('.footer-link:hover').styles(color: accentColor),

    // Icon badge — small rounded chip.
    css('.footer-link-icon').styles(
      display: .inlineFlex,
      alignItems: .center,
      justifyContent: .center,
      width: 28.px,
      height: 28.px,
      fontSize: 0.75.rem,
      fontWeight: .w700,
      color: accentColor,
      backgroundColor: tagBgColor,
      radius: BorderRadius.circular(6.px),
    ),

    // Mobile: stack the footer vertically, centred.
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.footer-inner').styles(
        flexDirection: .column,
        textAlign: TextAlign.center,
      ),
      css('.footer-links').styles(justifyContent: .center),
    ]),
  ];
}
