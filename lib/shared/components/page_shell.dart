import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/shared/components/footer.dart';
import 'package:subhojit_build/shared/components/header/header_component.dart';

/// Shared shell rendered around every page: Navbar at top, Footer at bottom.
class PageShell extends StatelessComponent {
  final Component child;
  const PageShell({
    required this.child,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'page', [
      const HeaderComponent(),
      child,
      const Footer(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page').styles(
      display: .flex,
      minHeight: 100.vh,
      flexDirection: .column,
    ),
  ];
}
