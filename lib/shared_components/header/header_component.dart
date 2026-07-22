import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/shared_components/header/mobile_navbar.dart';
import 'package:subhojit_build/shared_components/header/top_appbar.dart';

/// Shared top navigation bar — rendered once by the [ShellRoute].
///
/// Mobile  : Fixed top bar — hamburger ☰ | logo | avatar.
///           Tapping ☰ reveals a slide-in NavigationDrawer via CSS :has().
/// Desktop : Horizontal bar — logo left | nav links centre | Resume button right.
///
/// Active link is detected via [RouteState.of(context).location] so the
/// correct nav item is highlighted on every page without any client-side state.
class HeaderComponent extends StatelessComponent {
  const HeaderComponent({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      // Hidden checkbox — controls drawer open/close via CSS :has() selector.
      input(id: 'nav-toggle', type: InputType.checkbox, classes: 'drawer-toggle'),
      TopAppbar(),
      // ── Drawer overlay — click to close ──────────────────────────────────
      label(htmlFor: 'nav-toggle', classes: 'drawer-overlay', []),
      // ── Mobile Navigation drawer ─────────────────────────────────────────
      MobileNavbar(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    // ── Hidden toggle ─────────────────────────────────────────────────────
    css('.drawer-toggle').styles(display: .none),

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

    // Hamburger — mobile only, hidden on desktop.
    css('.hamburger').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      radius: BorderRadius.circular(99.px),
      cursor: Cursor.pointer,
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
      justifyContent: .center,
      alignItems: .center,
      color: primaryColor,
    ),
    css('.hamburger:hover').styles(backgroundColor: surfaceContainerHigh),

    css('.topbar-logo').styles(
      color: primaryColor,
      fontSize: 18.px,
      fontWeight: .w700,
      raw: {'letter-spacing': '-0.02em'},
    ),
    css('.topbar-logo:hover').styles(color: onPrimaryFixedVariant),

    // Desktop nav — hidden on mobile, shown via media query.
    css('.topbar-nav').styles(
      display: .none,
      alignItems: .center,
      gap: Gap.all(0.25.rem),
    ),
    css('.topbar-link').styles(
      padding: .symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(6.px),
      transition: Transition.combine([
        Transition('color', duration: Duration(milliseconds: 150)),
        Transition('background-color', duration: Duration(milliseconds: 150)),
      ]),
      color: onSurfaceVariant,
      fontSize: 14.px,
      fontWeight: .w500,
    ),
    css('.topbar-link:hover').styles(color: primaryColor, backgroundColor: surfaceContainerHigh),
    // Active link — subtle underline + primary colour.
    css('.topbar-link--active').styles(
      color: primaryColor,
      fontWeight: .w600,
      raw: {'border-bottom': '2px solid ${primaryColor.value}', 'border-radius': '0'},
    ),

    css('.topbar-right').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap.all(0.75.rem),
    ),
    css('.topbar-avatar').styles(
      display: .flex,
      width: 32.px,
      height: 32.px,
      radius: BorderRadius.circular(99.px),
      cursor: Cursor.pointer,
      justifyContent: .center,
      alignItems: .center,
      color: onPrimary,
      fontSize: 11.px,
      fontWeight: .w700,
      backgroundColor: primaryContainer,
    ),
    css('.resume-btn').styles(
      display: .none,
      padding: .symmetric(horizontal: 1.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(8.px),
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      color: onPrimary,
      fontSize: 13.px,
      fontWeight: .w600,
      backgroundColor: primaryColor,
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
      display: .flex,
      position: .fixed(top: 0.px, left: 0.px, bottom: 0.px),
      zIndex: ZIndex(60),
      width: 300.px,
      padding: .symmetric(vertical: 1.5.rem),
      flexDirection: .column,
      backgroundColor: surfaceContainerLow,
      raw: {
        'border-radius': '0 16px 16px 0',
        'box-shadow': '4px 0 24px rgba(26,28,30,0.12)',
        'transform': 'translateX(-100%)',
        'transition': 'transform 0.3s cubic-bezier(0.4,0,0.2,1)',
      },
    ),

    // CSS :has() — open states when checkbox is checked.
    css('body:has(.drawer-toggle:checked) .nav-drawer').styles(raw: {'transform': 'translateX(0)'}),
    css('body:has(.drawer-toggle:checked) .drawer-overlay').styles(opacity: 1, raw: {'pointer-events': 'all'}),

    css('.drawer-user').styles(
      display: .flex,
      padding: .symmetric(horizontal: 1.5.rem),
      alignItems: .center,
      gap: Gap.all(0.75.rem),
      raw: {'margin-bottom': '1.5rem'},
    ),
    css('.drawer-avatar').styles(
      display: .flex,
      width: 48.px,
      height: 48.px,
      radius: BorderRadius.circular(12.px),
      justifyContent: .center,
      alignItems: .center,
      color: primaryColor,
      fontSize: 16.px,
      fontWeight: .w700,
      backgroundColor: primaryFixed,
      raw: {'flex-shrink': '0'},
    ),
    css('.drawer-name').styles(color: primaryColor, fontSize: 15.px, fontWeight: .w700),
    css('.drawer-role').styles(color: onSurfaceVariant, fontSize: 13.px),

    css('.drawer-nav').styles(
      display: .flex,
      padding: .symmetric(horizontal: 0.5.rem),
      flexDirection: .column,
      gap: Gap.all(0.25.rem),
      flex: Flex(grow: 1),
    ),
    css('.drawer-link').styles(
      display: .flex,
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(99.px),
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      gap: Gap.all(0.75.rem),
      color: onSurfaceVariant,
      fontSize: 14.px,
      fontWeight: .w500,
    ),
    css('.drawer-link:hover').styles(backgroundColor: surfaceContainerHigh),
    css('.drawer-link--active').styles(
      color: onSecondaryContainer,
      backgroundColor: secondaryContainer,
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
    css(
      '.theme-toggle:focus-visible',
    ).styles(raw: {'outline': '2px solid ${primaryColor.value}', 'outline-offset': '2px'}),
  ];
}
