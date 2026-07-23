import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class ProjectPage extends StatelessComponent {
  const ProjectPage({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'project-page', [
      h1(classes: 't-display-large', [.text('Projects')]),
      p(classes: 't-body', [
        .text(
          'Here are some of the projects I have worked on. Click on the project name to view more details.',
        ),
      ]),
      // Add your project cards here
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.project-page').styles(
      padding: .symmetric(vertical: 5.rem),
      raw: {'padding-top': '7rem'},
    ),
  ];
}
