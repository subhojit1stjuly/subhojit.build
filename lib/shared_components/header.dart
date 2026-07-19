import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/theme/colors.dart';

class Header extends StatelessComponent {
  final List<({String label, String path})> routes;

  const Header({super.key, required this.routes});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;

    return header([
      nav([
        for (var route in routes)
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: .text(route.label)),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: .flex,
        padding: .all(1.em),
        justifyContent: .center,
      ),
      css('nav', [
        css('&').styles(
          display: .flex,
          height: 3.em,
          radius: .all(.circular(10.px)),
          overflow: .clip,
          justifyContent: .spaceBetween,
          backgroundColor: accentColor,
        ),
        css('a', [
          css('&').styles(
            display: .flex,
            height: 100.percent,
            padding: .symmetric(horizontal: 2.em),
            alignItems: .center,
            color: onPrimary,
            fontWeight: .w700,
            textDecoration: TextDecoration(line: .none),
          ),
          css('&:hover').styles(
            backgroundColor: surfaceContainer,
          ),
        ]),
        css('div.active', [
          css('&').styles(position: .relative()),
          css('&::before').styles(
            content: '',
            display: .block,
            position: .absolute(bottom: 0.5.em, left: 20.px, right: 20.px),
            height: 2.px,
            radius: .circular(1.px),
            backgroundColor: onPrimary,
          ),
        ]),
      ]),
    ]),
  ];
}
