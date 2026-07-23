// ── Desktop zigzag entry ───────────────────────────────────────────────────────
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/career/models/job_experience.dart';

class DesktopEntry extends StatelessComponent {
  const DesktopEntry({required this.job, required this.isReversed});
  final JobExperience job;
  final bool isReversed;

  @override
  Component build(BuildContext context) {
    final modClass = isReversed ? 'desktop-entry--reversed' : 'desktop-entry--normal';
    return div(classes: 'desktop-entry $modClass', [
      // Title column
      div(classes: 'desktop-title-col', [
        p(classes: 'desktop-date', [.text(job.period)]),
        p(classes: 'desktop-role', [.text(job.title)]),
        p(classes: 'desktop-company', [.text(job.company)]),
      ]),
      // Centre node
      div(classes: 'desktop-node', [
        div(classes: 'desktop-node-circle', [
          span(classes: 'material-symbols-outlined', [.text('work')]),
        ]),
      ]),
      // Content card
      div(classes: 'desktop-card-col', [
        div(classes: 'desktop-card', [
          p(classes: 'entry-desc', [.text(job.description)]),
        ]),
      ]),
    ]);
  }
}
