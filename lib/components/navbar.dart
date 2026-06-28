import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

/// Sticky top navigation bar.
///
/// Layout: [Brand Name] ←————————————————→ [About] [Projects] [Contact]
///
/// On narrow screens the links wrap below the brand name thanks to
/// [FlexWrap.wrap] on the inner row — no JavaScript required.
class Navbar extends StatelessComponent {
  const Navbar({super.key});

  @override
  Component build(BuildContext context) {
    return header(
      id: 'top',
      classes: 'navbar',
      [
        // Centred inner row — shares the .container max-width utility.
        div(classes: 'navbar-inner container', [
          // Brand / name — links back to the top of the page.
          a(href: '#', classes: 'navbar-brand', [
            .text('Subhojit Pramanik'),
          ]),

          // Primary navigation links (anchor-based, single-page portfolio).
          nav(classes: 'navbar-links', [
            a(href: '#about', classes: 'nav-link', [.text('About')]),
            a(href: '#projects', classes: 'nav-link', [.text('Projects')]),
            a(href: '#contact', classes: 'nav-link', [.text('Contact')]),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    // Sticky bar — stays at the top while the user scrolls.
    css('.navbar').styles(
      position: .sticky(top: 0.px),
      zIndex: ZIndex(100),
      shadow: BoxShadow(offsetX: 0.px, offsetY: 1.px, blur: 0.px, color: borderColor),
      // Use a box-shadow to paint a 1 px bottom border without Border.only().
      backgroundColor: surfaceColor,
    ),

    // Inner flex row: brand on the left, nav links on the right.
    css('.navbar-inner').styles(
      display: .flex,
      padding: .symmetric(horizontal: 2.rem, vertical: 1.rem),
      flexWrap: .wrap,
      justifyContent: .spaceBetween,
      alignItems: .center,
      gap: Gap.all(0.75.rem),
    ),

    // Brand / logo text.
    css('.navbar-brand').styles(
      transition: Transition(
        'color',
        duration: Duration(milliseconds: 200),
        curve: Curve.ease,
      ),
      color: textPrimary,
      fontSize: 1.125.rem,
      fontWeight: .w700,
    ),
    css('.navbar-brand:hover').styles(color: accentColor),

    // Row of navigation anchors.
    css('.navbar-links').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.25.rem),
    ),

    // Individual nav anchor.
    css('.nav-link').styles(
      padding: .symmetric(horizontal: 0.875.rem, vertical: 0.5.rem),
      transition: Transition(
        'color',
        duration: Duration(milliseconds: 200),
        curve: Curve.ease,
      ),
      color: textSecondary,
      fontSize: 0.9375.rem,
      fontWeight: .w500,
    ),
    css('.nav-link:hover').styles(color: accentColor),

    // Mobile: tighter padding so the bar stays compact on small screens.
    css.media(MediaQuery.screen(maxWidth: 480.px), [
      css('.navbar-inner').styles(
        padding: .symmetric(horizontal: 1.25.rem, vertical: 0.875.rem),
      ),
      css('.nav-link').styles(
        padding: .symmetric(horizontal: 0.625.rem, vertical: 0.375.rem),
        fontSize: 0.875.rem,
      ),
    ]),
  ];
}
