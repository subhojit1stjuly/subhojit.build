import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/theme_toggle.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/shared_components/header/web_navbar.dart';

class TopAppbar extends StatelessComponent {
  const TopAppbar({
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return header(classes: 'topbar', [
      div(classes: 'topbar-left', [
        // Hamburger (mobile only) — label toggles the hidden checkbox.
        label(htmlFor: 'nav-toggle', classes: 'hamburger', [
          span(classes: 'material-symbols-outlined', [.text('menu')]),
        ]),
        // Logo / brand — always navigates to home.
        Link(to: '/', classes: 'topbar-logo', child: .text('Subhojit.dev')),
      ]),

      // Desktop/Web/Tab inline nav links.
      WebNavbar(),

      div(classes: 'topbar-right', [
        const ThemeToggle(),
        const div(classes: 'topbar-avatar', [.text('SP')]),
        const Link(to: '/#contact', classes: 'resume-btn', child: .text('Resume')),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    // ── Top app bar ───────────────────────────────────────────────────────
    css('.topbar').styles(
      display: .flex,
      position: .fixed(top: 0.px, left: 0.px, right: 0.px),
      zIndex: ZIndex(50),
      height: 64.px,
      padding: .symmetric(horizontal: 1.rem),
      justifyContent: .spaceBetween,
      alignItems: .center,
      backgroundColor: surfaceColor,
      raw: {'border-bottom': '1px solid ${outlineVariant.value}'},
    ),

    css('.topbar-left').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.75.rem),
    ),
  ];
}
