import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/constants.dart';

class MobileNavbar extends StatelessComponent {
  const MobileNavbar({
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Current route location — used to mark the active nav link.
    final loc = RouteState.maybeOf(context)?.location ?? '/';
    final activeTo = Constants.activePath(loc);
    return aside(classes: 'nav-drawer', [
      div(classes: 'drawer-user', [
        div(classes: 'drawer-avatar', [.text('SP')]),
        div([
          p(classes: 'drawer-name', [.text('Subhojit Pramanik')]),
          p(classes: 'drawer-role', [.text('Senior Software Engineer')]),
        ]),
      ]),

      nav(classes: 'drawer-nav', [
        for (final item in Constants.navItems)
          Link(
            to: item.to,
            classes: item.to == activeTo ? 'drawer-link drawer-link--active' : 'drawer-link',
            children: [
              span(classes: 'material-symbols-outlined', [
                .text(Constants.iconFor(item.to)),
              ]),
              span([.text(item.label)]),
            ],
          ),
      ]),

      div(classes: 'drawer-footer', [
        span(classes: 't-label', [.text('v1.0.0')]),
      ]),
    ]);
  }
}
