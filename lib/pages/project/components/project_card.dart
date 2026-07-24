import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';

class ProjectCard extends StatelessComponent {
  const ProjectCard({required this.project});
  final ProjectDoc project;

  @override
  Component build(BuildContext context) {
    return div(classes: 'project-card', [
      div(classes: 'project-card-image', styles: Styles(backgroundColor: project.imageColor), [
        span(
          classes: 'material-symbols-outlined',
          styles: Styles(color: primaryColor, fontSize: 32.px),
          [.text(project.imageURL)],
        ),
      ]),
      div(classes: 'project-card-body', [
        div(classes: 'project-tags', [
          for (final tag in project.tags) span(classes: 'project-tag', [.text(tag)]),
        ]),
        p(classes: 'project-card-title', [.text(project.title)]),
        p(classes: 'project-card-excerpt', [.text(project.description)]),
        div(classes: 'project-card-footer', [
          if (project.repoUrl != null)
            a(href: project.repoUrl!, classes: 'project-link-btn', [
              .text('Code'),
              span(classes: 'material-symbols-outlined', styles: Styles(fontSize: 14.px), [.text('code')]),
            ]),
          if (project.liveUrl != null)
            a(href: project.liveUrl!, classes: 'project-link-btn', [
              .text('Demo'),
              span(classes: 'material-symbols-outlined', styles: Styles(fontSize: 14.px), [.text('open_in_new')]),
            ]),
        ]),
      ]),
    ]);
  }
}
