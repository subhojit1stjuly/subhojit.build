import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/components/shimmer.dart';

class BlogListShimmer extends StatelessComponent {
  const BlogListShimmer({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      attributes: {
        'style':
            'padding: 16px; border: 1px solid #e0e0e0; border-radius: 8px; display: flex; gap: 16px; max-width: 400px;',
      },
      [
        // Circular Avatar Shimmer
        Shimmer(
          width: 50,
          height: 50,
          borderRadius: 25,
        ),

        // Text Lines Shimmer Column
        div(
          attributes: {'style': 'flex: 1; display: flex; flex-direction: column; justify-content: center;'},
          [
            Shimmer(
              width: 60,
              height: 16,
              margin: Spacing.fromLTRB(
                Unit.zero,
                Unit.zero,
                Unit.zero,
                Unit.pixels(10),
              ),
            ),
            Shimmer(width: 90, height: 14),
          ],
        ),
      ],
    );
  }
}
