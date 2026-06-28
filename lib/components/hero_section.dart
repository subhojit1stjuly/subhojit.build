import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

/// Full-viewport hero section — the first thing a visitor sees.
///
/// Layout (centred column):
///   Eyebrow label
///   Large display heading
///   Sub-headline paragraph
///   [View My Work]  [Get in Touch]   ← CTA button row
class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'hero',
      classes: 'hero',
      [
        // Max-width inner column, centred.
        div(classes: 'hero-content', [
          // Eyebrow label — role / specialisation teaser.
          p(classes: 'hero-eyebrow', [
            .text('Senior Software Engineer · Mobile Developer'),
          ]),

          // Primary display heading — largest text on the page.
          h1(classes: 'hero-title', [
            .text('Building '),
            span(classes: 'hero-accent', [.text('High-Performance')]),
            .text(' Apps That Delight.'),
          ]),

          // Sub-headline — one or two lines of context.
          p(classes: 'hero-sub', [
            .text(
              'Specialising in Flutter, Dart, and cross-platform mobile '
              'architecture to craft beautiful, fast experiences on every screen.',
            ),
          ]),

          // CTA button row — primary action + secondary action.
          div(classes: 'hero-cta', [
            a(
              href: '#projects',
              classes: 'btn btn-primary',
              [.text('View My Work')],
            ),
            a(
              href: '#contact',
              classes: 'btn btn-outline',
              [.text('Get in Touch')],
            ),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    // Full-viewport height section with centred flex content.
    css('.hero').styles(
      display: .flex,
      minHeight: 100.vh,
      padding: .symmetric(horizontal: 2.rem, vertical: 6.rem),
      justifyContent: .center,
      alignItems: .center,
      textAlign: TextAlign.center,
      // Subtle radial glow emanating from the centre — purely decorative.
      raw: {
        'background': 'radial-gradient(ellipse 80% 60% at 50% 0%, #0c2d4844 0%, transparent 70%)',
      },
    ),

    // Inner content wrapper: capped width for readability.
    css('.hero-content').styles(
      width: 100.percent,
      maxWidth: 800.px,
    ),

    // Eyebrow: small uppercase accent label above the headline.
    css('.hero-eyebrow').styles(
      color: accentColor,
      fontSize: 0.8125.rem,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      letterSpacing: 0.12.em,
      raw: {'margin-bottom': '1.25rem'},
    ),

    // Display heading.
    css('.hero-title').styles(
      color: textPrimary,
      fontSize: 3.75.rem,
      fontWeight: .w700,
      lineHeight: 1.1.em,
      raw: {'margin-bottom': '1.5rem'},
    ),

    // Accent span inside the heading.
    css('.hero-accent').styles(color: accentColor),

    // Sub-headline paragraph.
    css('.hero-sub').styles(
      maxWidth: 600.px,
      color: textSecondary,
      fontSize: 1.125.rem,
      lineHeight: 1.75.em,
      raw: {
        'margin': '0 auto 2.5rem',
      },
    ),

    // CTA row — centred flex, wraps on very small screens.
    css('.hero-cta').styles(
      display: .flex,
      flexWrap: .wrap,
      justifyContent: .center,
      gap: Gap.all(1.rem),
    ),

    // Shared button base.
    css('.btn').styles(
      display: .inlineFlex,
      padding: .symmetric(horizontal: 1.75.rem, vertical: 0.875.rem),
      radius: BorderRadius.circular(8.px),
      cursor: Cursor.pointer,
      transition: Transition.combine([
        Transition('background-color', duration: Duration(milliseconds: 200), curve: Curve.ease),
        Transition('color', duration: Duration(milliseconds: 200), curve: Curve.ease),
        Transition('box-shadow', duration: Duration(milliseconds: 200), curve: Curve.ease),
      ]),
      justifyContent: .center,
      alignItems: .center,
      fontSize: 1.rem,
      fontWeight: .w600,
    ),

    // Primary filled button — accent background, dark label.
    css('.btn-primary').styles(
      color: bgColor,
      backgroundColor: accentColor,
    ),
    css('.btn-primary:hover').styles(
      shadow: BoxShadow(
        offsetX: 0.px,
        offsetY: 4.px,
        blur: 18.px,
        color: Color('#38BDF855'),
      ),
      backgroundColor: accentHoverColor,
    ),

    // Outline ghost button — transparent fill, accent ring via box-shadow.
    css('.btn-outline').styles(
      shadow: BoxShadow(offsetX: 0.px, offsetY: 0.px, blur: 0.px, spread: 2.px, color: accentColor),
      color: accentColor,
    ),
    css('.btn-outline:hover').styles(
      color: accentHoverColor,
      backgroundColor: Color('#38BDF815'),
    ),

    // Responsive — shrink heading and sub-text on mobile.
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.hero-title').styles(fontSize: 2.375.rem),
      css('.hero-sub').styles(fontSize: 1.rem),
      css('.hero-eyebrow').styles(fontSize: 0.75.rem),
    ]),
  ];
}
