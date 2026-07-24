import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

class BlogFooter extends StatelessComponent {
  final String readMin;
  final String href;
  const BlogFooter({
    required this.readMin,
    required this.href,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'common_card-footer', [
      span(classes: 'common_card-read', [.text(readMin)]),
      a(href: href, classes: 'common_card-read-btn', [
        .text('Read'),
        span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
      ]),
    ]);
  }
}
