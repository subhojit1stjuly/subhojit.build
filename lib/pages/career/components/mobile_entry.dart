import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/career/models/job_experience.dart';

class MobileEntry extends StatelessComponent {
  const MobileEntry({required this.job});
  final JobExperience job;

  @override
  Component build(BuildContext context) {
    return div(classes: 'mobile-entry', [
      div(classes: 'mobile-dot-col', [
        div(classes: 'mobile-dot', [
          span(classes: 'material-symbols-outlined', [.text('work')]),
        ]),
        div(classes: 'mobile-spine', []),
      ]),
      div(classes: 'mobile-content', [
        p(classes: 'entry-date', [.text(job.period)]),
        p(classes: 'entry-role', [.text(job.title)]),
        p(classes: 'entry-company', [.text(job.company)]),
        p(classes: 'entry-desc', [.text(job.description)]),
      ]),
    ]);
  }
}
