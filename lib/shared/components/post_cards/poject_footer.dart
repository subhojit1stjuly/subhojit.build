import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

class ProjectFooter extends StatelessComponent {
  final String liveUrl;
  final String repoUrl;
  const ProjectFooter({
    required this.liveUrl,
    required this.repoUrl,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'common_card-footer', [
      a(href: liveUrl, classes: 'common_card-read-btn', [
        .text('View Code'),
        span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
      ]),
      a(href: repoUrl, classes: 'common_card-read-btn', [
        .text('Live Demo'),
        span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
      ]),
    ]);
  }
}
