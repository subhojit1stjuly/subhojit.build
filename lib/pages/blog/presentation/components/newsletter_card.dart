// ── Newsletter card ───────────────────────────────────────────────────────────
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class NewsletterCard extends StatelessComponent {
  const NewsletterCard();

  @override
  Component build(BuildContext context) {
    return div(classes: 'newsletter-card', [
      p(classes: 'newsletter-title', [.text("The Flutter Engineer's Log")]),
      p(classes: 'newsletter-sub', [
        .text(
          'Bi-weekly deep dives into Flutter architecture and mobile performance. '
          'No fluff — just code and patterns.',
        ),
      ]),
      input(
        type: InputType.email,
        classes: 'newsletter-input',
        attributes: {'placeholder': 'email@example.com'},
      ),
      div(classes: 'newsletter-btn', [.text('Subscribe Now')]),
      p(classes: 'newsletter-note', [.text('Join 2,000+ Flutter engineers. Opt-out anytime.')]),
    ]);
  }
}
