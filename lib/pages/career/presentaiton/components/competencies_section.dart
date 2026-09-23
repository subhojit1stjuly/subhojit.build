import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/constants/constants.dart';

class CompetenciesSection extends StatelessComponent {
  const CompetenciesSection();

  @override
  Component build(BuildContext context) {
    return section(classes: 'comp-section', id: 'tech-stack', [
      div(classes: 'comp-inner container', [
        div(classes: 'comp-grid', [
          div(classes: 'comp-block comp-block--dark', [
            p(classes: 'comp-block-label t-label', [.text('Core Competencies')]),
            div(classes: 'comp-tags', [
              for (final s in Constants.compSkills) span(classes: 'comp-tag', [.text(s)]),
            ]),
          ]),
          div(classes: 'comp-block comp-block--purple', [
            p(classes: 'comp-stat-num', [.text('5+')]),
            p(classes: 'comp-stat-label t-label', [.text('Years in Flutter')]),
          ]),
          div(classes: 'comp-block comp-block--lavender', [
            p(classes: 'comp-stat-num comp-stat-num--dark', [.text('40+')]),
            p(classes: 'comp-stat-label comp-stat-label--dark t-label', [.text('Apps Shipped')]),
          ]),
        ]),
      ]),
    ]);
  }
}
