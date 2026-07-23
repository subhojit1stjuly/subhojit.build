import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';

/// Philosophy section — a quote, brief statement, and contact CTA.
class PhilosophySection extends StatelessComponent {
  const PhilosophySection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'contact',
      classes: 'philosophy-section',
      [
        div(classes: 'philosophy-inner container', [
          div(classes: 'philosophy-card tonal-card', [
            // Quote
            div(classes: 'philosophy-quote', [
              span(classes: 'quote-mark', [.text('\u201c')]),
              p(classes: 'quote-text', [
                .text(
                  "Build for the problem of today, but architect "
                  "for the scale of tomorrow.",
                ),
              ]),
            ]),
            p(classes: 'philosophy-body t-body-lg', [
              .text(
                "I believe in simple, human-readable solutions to complex problems. "
                "Over-engineering is a smell. The best mobile app is one that users "
                "never think about because it just works — fast, reliably, and beautifully.",
              ),
            ]),
            // CTA
            div(classes: 'philosophy-cta', [
              p(classes: 'cta-label t-title', [.text("Let\'s Build Something.")]),
              p(classes: 'cta-sub t-body', [
                .text(
                  "Open to senior/lead mobile roles and freelance projects. "
                  "Drop me a message and I\'ll reply within 24 hours.",
                ),
              ]),
              div(classes: 'cta-actions', [
                a(href: 'mailto:hello@subhojitpramanik.dev', classes: 'cta-btn-primary', [.text('Get in Touch')]),
                a(
                  href: 'https://github.com/subhojit',
                  classes: 'cta-btn-ghost',
                  attributes: {'target': '_blank', 'rel': 'noopener'},
                  [.text('View GitHub')],
                ),
              ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.philosophy-section').styles(
      padding: .symmetric(vertical: 5.rem),
      backgroundColor: surfaceContainerLow,
    ),
    css('.philosophy-card').styles(
      display: .flex,
      padding: .all(2.5.rem),
      flexDirection: .column,
      gap: Gap.all(2.rem),
    ),
    // Quote
    css('.philosophy-quote').styles(
      raw: {'border-left': '4px solid ${primaryColor.value}', 'padding-left': '1.25rem'},
    ),
    css('.quote-mark').styles(
      color: primaryColor,
      fontSize: 48.px,
      fontWeight: .w700,
      raw: {'line-height': '1', 'display': 'block', 'margin-bottom': '-0.5rem'},
    ),
    css('.quote-text').styles(
      color: onSurface,
      fontSize: 20.px,
      fontWeight: .w600,
      fontStyle: .italic,
      raw: {'line-height': '1.5'},
    ),
    css('.philosophy-body').styles(color: onSurfaceVariant, lineHeight: 1.7.em),
    // CTA
    css('.philosophy-cta').styles(
      display: .flex,
      padding: .all(1.75.rem),
      radius: BorderRadius.circular(12.px),
      flexDirection: .column,
      gap: Gap.all(0.75.rem),
      backgroundColor: surfaceContainerLowest,
    ),
    css('.cta-label').styles(color: onSurface),
    css('.cta-sub').styles(color: onSurfaceVariant),
    css('.cta-actions').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(0.75.rem), raw: {'margin-top': '0.25rem'}),
    css('.cta-btn-primary').styles(
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
    css('.cta-btn-primary:hover').styles(backgroundColor: onPrimaryFixedVariant),
    css('.cta-btn-ghost').styles(
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
    css('.cta-btn-ghost:hover').styles(backgroundColor: surfaceContainerHighest),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.philosophy-card').styles(padding: .all(1.5.rem)),
    ]),
  ];
}
