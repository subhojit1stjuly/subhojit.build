import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Shimmer extends StatelessComponent {
  final double width;
  final double height;
  final double borderRadius;
  final Spacing margin;

  const Shimmer({
    this.width = 100.0,
    this.height = 100.0,
    this.borderRadius = 0,
    this.margin = const Spacing.fromLTRB(
      Unit.zero,
      Unit.zero,
      Unit.zero,
      Unit.zero,
    ),
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'app-shimmer-effect',
      styles: Styles(
        width: Unit.pixels(width),
        height: Unit.pixels(height),
        margin: margin,
        radius: BorderRadius.all(Radius.circular(Unit.pixels(borderRadius))),
      ),
      [],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.app-shimmer-effect').styles(
      raw: {
        '--shimmer-bg': '#e0e0e0',
        '--shimmer-shine': '#f5f5f5',

        'background-color': 'var(--shimmer-bg)',
        'background-image':
            'linear-gradient(90deg, var(--shimmer-bg) 0px,var(--shimmer-shine) 50%,var(--shimmer-bg) 100%)',
        'background-size': '200% 100%',
        'animation': 'app-shimmer-sweep 1.5s infinite linear',
      },
    ),
    css('@media (prefers-color-scheme: dark)', [
      css('.app-shimmer-effect').styles(
        raw: {
          '--shimmer-bg': '#2a2a2a',
          '--shimmer-shine': '#3f3f3f',
        },
      ),
    ]),
    css.keyframes('app-shimmer-sweep', {
      '0%': Styles(
        backgroundPosition: BackgroundPosition(
          offsetX: Unit.percent(200),
          offsetY: Unit.points(0),
        ),
      ),
      '100%': Styles(
        backgroundPosition: BackgroundPosition(
          offsetX: Unit.percent(-200),
          offsetY: Unit.points(0),
        ),
      ),
    }),
  ];
}
