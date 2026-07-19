import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/components/theme_toggle.dart';

import '../constants/theme.dart';

/// Shared top navigation bar — rendered once by the [ShellRoute].
///
/// Mobile  : Fixed top bar — hamburger ☰ | logo | avatar.
///           Tapping ☰ reveals a slide-in NavigationDrawer via CSS :has().
/// Desktop : Horizontal bar — logo left | nav links centre | Resume button right.
///
/// Active link is detected via [RouteState.of(context).location] so the
/// correct nav item is highlighted on every page without any client-side state.
class Navbar extends StatelessComponent {
  final List<({String label, String to})> navItems;

  const Navbar({super.key, required this.navItems});

  @override
  Component build(BuildContext context) {
    // Current route location — used to mark the active nav link.
    final loc = RouteState.maybeOf(context)?.location ?? '/';
    final activeTo = _activePath(loc);

    return Component.fragment([
      // Hidden checkbox — controls drawer open/close via CSS :has() selector.
      input(id: 'nav-toggle', type: InputType.checkbox, classes: 'drawer-toggle'),

      // ── Top app bar ──────────────────────────────────────────────────────
      header(classes: 'topbar', [
        div(classes: 'topbar-left', [
          // Hamburger (mobile only) — label toggles the hidden checkbox.
          label(htmlFor: 'nav-toggle', classes: 'hamburger', [
            span(classes: 'material-symbols-outlined', [.text('menu')]),
          ]),
          // Logo / brand — always navigates to home.
          Link(to: '/', classes: 'topbar-logo', child: .text('Subhojit.dev')),
        ]),

        // Desktop inline nav links.
        nav(classes: 'topbar-nav', [
          for (final item in navItems)
            Link(
              to: item.to,
              classes: item.to == activeTo
                  ? 'topbar-link topbar-link--active'
                  : 'topbar-link',
              child: .text(item.label),
            ),
        ]),

        div(classes: 'topbar-right', [
          ThemeToggle(),
          div(classes: 'topbar-avatar', [.text('SP')]),
          Link(to: '/#contact', classes: 'resume-btn', child: .text('Resume')),
        ]),
      ]),

      // ── Drawer overlay — click to close ──────────────────────────────────
      label(htmlFor: 'nav-toggle', classes: 'drawer-overlay', []),

      // ── Navigation drawer ─────────────────────────────────────────────────
      aside(classes: 'nav-drawer', [
        div(classes: 'drawer-user', [
          div(classes: 'drawer-avatar', [.text('SP')]),
          div([
            p(classes: 'drawer-name', [.text('Subhojit Pramanik')]),
            p(classes: 'drawer-role', [.text('Senior Software Engineer')]),
          ]),
        ]),

        nav(classes: 'drawer-nav', [
          for (final item in navItems)
            Link(
              to: item.to,
              classes: item.to == activeTo
                  ? 'drawer-link drawer-link--active'
                  : 'drawer-link',
              children: [
                span(classes: 'material-symbols-outlined', [
                  .text(_iconFor(item.to)),
                ]),
                span([.text(item.label)]),
              ],
            ),
        ]),

        div(classes: 'drawer-footer', [
          span(classes: 't-label', [.text('v1.0.0')]),
        ]),
      ]),
    ]);
  }

  /// Returns the canonical path to match for active-link detection.
  static String _activePath(String location) {
    if (location.startsWith('/career')) return '/career';
    if (location.startsWith('/blog')) return '/blog';
    return '/';
  }

  static String _iconFor(String to) => switch (to) {
    '/career'  => 'work_history',
    '/blog'    => 'article',
    '/#contact' => 'alternate_email',
    _           => 'folder_open',
  };

  @css
  static List<StyleRule> get styles => [
    // ── Hidden toggle ─────────────────────────────────────────────────────
    css('.drawer-toggle').styles(display: .none),

    // ── Top app bar ───────────────────────────────────────────────────────
    css('.topbar').styles(
      position: .fixed(top: 0.px, left: 0.px, right: 0.px),
      zIndex: ZIndex(50),
      display: .flex,
      alignItems: .center,
      justifyContent: .spaceBetween,
      backgroundColor: surfaceColor,
      height: 64.px,
      padding: .symmetric(horizontal: 1.rem),
      raw: {'border-bottom': '1px solid ${outlineVariant.value}'},
    ),

    css('.topbar-left').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
    ),

    // Hamburger — mobile only, hidden on desktop.
    css('.hamburger').styles(
      display: .flex, alignItems: .center, justifyContent: .center,
      width: 40.px, height: 40.px,
      radius: BorderRadius.circular(99.px),
      color: primaryColor, cursor: Cursor.pointer,
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
    ),
    css('.hamburger:hover').styles(backgroundColor: surfaceContainerHigh),

    css('.topbar-logo').styles(
      fontSize: 18.px, fontWeight: .w700, color: primaryColor,
      raw: {'letter-spacing': '-0.02em'},
    ),
    css('.topbar-logo:hover').styles(color: onPrimaryFixedVariant),

    // Desktop nav — hidden on mobile, shown via media query.
    css('.topbar-nav').styles(
      display: .none, alignItems: .center, gap: Gap.all(0.25.rem),
    ),
    css('.topbar-link').styles(
      fontSize: 14.px, fontWeight: .w500, color: onSurfaceVariant,
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(6.px),
      transition: Transition.combine([
        Transition('color', duration: Duration(milliseconds: 150)),
        Transition('background-color', duration: Duration(milliseconds: 150)),
      ]),
    ),
    css('.topbar-link:hover').styles(color: primaryColor, backgroundColor: surfaceContainerHigh),
    // Active link — subtle underline + primary colour.
    css('.topbar-link--active').styles(
      color: primaryColor, fontWeight: .w600,
      raw: {'border-bottom': '2px solid ${primaryColor.value}', 'border-radius': '0'},
    ),

    css('.topbar-right').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
    ),
    css('.topbar-avatar').styles(
      display: .flex, alignItems: .center, justifyContent: .center,
      width: 32.px, height: 32.px,
      radius: BorderRadius.circular(99.px),
      backgroundColor: primaryContainer, color: onPrimary,
      fontSize: 11.px, fontWeight: .w700, cursor: Cursor.pointer,
    ),
    css('.resume-btn').styles(
      display: .none, alignItems: .center,
      backgroundColor: primaryColor, color: onPrimary,
      fontSize: 13.px, fontWeight: .w600,
      padding: .symmetric(horizontal: 1.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(8.px),
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
    ),
    css('.resume-btn:hover').styles(backgroundColor: onPrimaryFixedVariant),

    // ── Drawer overlay ────────────────────────────────────────────────────
    css('.drawer-overlay').styles(
      position: .fixed(top: 0.px, left: 0.px, right: 0.px, bottom: 0.px),
      zIndex: ZIndex(55),
      opacity: 0,
      raw: {
        'pointer-events': 'none',
        'transition': 'opacity 0.3s ease',
        'background-color': 'rgba(30,31,28,0.4)',
        'backdrop-filter': 'blur(4px)',
      },
    ),

    // ── Navigation drawer ─────────────────────────────────────────────────
    css('.nav-drawer').styles(
      position: .fixed(top: 0.px, left: 0.px, bottom: 0.px),
      zIndex: ZIndex(60),
      width: 300.px,
      backgroundColor: surfaceContainerLow,
      padding: .symmetric(vertical: 1.5.rem),
      display: .flex, flexDirection: .column,
      raw: {
        'border-radius': '0 16px 16px 0',
        'box-shadow': '4px 0 24px rgba(26,28,30,0.12)',
        'transform': 'translateX(-100%)',
        'transition': 'transform 0.3s cubic-bezier(0.4,0,0.2,1)',
      },
    ),

    // CSS :has() — open states when checkbox is checked.
    css('body:has(.drawer-toggle:checked) .nav-drawer').styles(
        raw: {'transform': 'translateX(0)'}),
    css('body:has(.drawer-toggle:checked) .drawer-overlay').styles(
        opacity: 1, raw: {'pointer-events': 'all'}),

    css('.drawer-user').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
      padding: .symmetric(horizontal: 1.5.rem),
      raw: {'margin-bottom': '1.5rem'},
    ),
    css('.drawer-avatar').styles(
      display: .flex, alignItems: .center, justifyContent: .center,
      width: 48.px, height: 48.px,
      radius: BorderRadius.circular(12.px),
      backgroundColor: primaryFixed, color: primaryColor,
      fontSize: 16.px, fontWeight: .w700, raw: {'flex-shrink': '0'},
    ),
    css('.drawer-name').styles(fontSize: 15.px, fontWeight: .w700, color: primaryColor),
    css('.drawer-role').styles(fontSize: 13.px, color: onSurfaceVariant),

    css('.drawer-nav').styles(
      display: .flex, flexDirection: .column, gap: Gap.all(0.25.rem),
      padding: .symmetric(horizontal: 0.5.rem),
      flex: Flex(grow: 1),
    ),
    css('.drawer-link').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(99.px),
      color: onSurfaceVariant, fontSize: 14.px, fontWeight: .w500,
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
    ),
    css('.drawer-link:hover').styles(backgroundColor: surfaceContainerHigh),
    css('.drawer-link--active').styles(
      backgroundColor: secondaryContainer, color: onSecondaryContainer,
    ),

    css('.drawer-footer').styles(
      padding: .symmetric(horizontal: 1.5.rem, vertical: 0.75.rem),
      color: onSurfaceVariant,
    ),

    // ── Desktop overrides (≥ 768 px) ──────────────────────────────────────
    css.media(MediaQuery.screen(minWidth: 768.px), [
      css('.hamburger').styles(display: .none),
      css('.topbar-nav').styles(display: .flex),
      css('.resume-btn').styles(display: .inlineFlex),
      css('.topbar').styles(padding: .symmetric(horizontal: 2.rem)),
    ]),

    // ── Theme toggle focus ────────────────────────────────────────────────
    css('.theme-toggle:focus-visible').styles(
      raw: {'outline': '2px solid ${primaryColor.value}', 'outline-offset': '2px'}
    ),
  ];
}
