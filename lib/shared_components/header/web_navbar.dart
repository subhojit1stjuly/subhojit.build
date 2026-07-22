import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/constants.dart';

class WebNavbar extends StatelessComponent {
  const WebNavbar({super.key});

  @override
  Component build(BuildContext context) {
    // Route state is now scoped ONLY to the links
    final loc = RouteState.maybeOf(context)?.location ?? '/';
    final activeTo = Constants.activePath(loc);

    return nav(classes: 'topbar-nav', [
      for (final item in Constants.navItems)
        Link(
          to: item.to,
          classes: item.to == activeTo ? 'topbar-link topbar-link--active' : 'topbar-link',
          child: .text(item.label),
        ),
    ]);
  }
}
