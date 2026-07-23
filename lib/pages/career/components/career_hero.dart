// ── Private sub-components (no @css — styles live in CareerPage above) ────────

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CareerHero extends StatelessComponent {
  const CareerHero();

  @override
  Component build(BuildContext context) {
    return section(classes: 'chero-section', [
      div(classes: 'chero-inner container', [
        div(classes: 'chero-pill', [
          span(classes: 'material-symbols-outlined chero-pill-icon', [.text('verified')]),
          span(classes: 't-label', [.text('Executive Experience')]),
        ]),
        h1(classes: 'chero-headline t-display', [
          .text('Sculpting Apps\nat Scale.'),
        ]),
        p(classes: 'chero-sub t-body-lg', [
          .text(
            'Over 5 years crafting high-performance Flutter applications, '
            'leading mobile engineering teams, and driving product quality '
            'for fintech and consumer-tech companies.',
          ),
        ]),
      ]),
    ]);
  }
}
