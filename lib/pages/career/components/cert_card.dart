import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/career/models/certification.dart';

class CertCard extends StatelessComponent {
  final Certification cert;
  const CertCard({required this.cert});

  @override
  Component build(BuildContext context) {
    return div(classes: 'cert-card', [
      div(classes: 'cert-icon-wrap', [
        span(classes: 'material-symbols-outlined', [.text(cert.image)]),
      ]),
      p(classes: 'cert-type', [.text(cert.type)]),
      p(classes: 'cert-name', [.text(cert.title)]),
      div(styles: Styles(flex: Flex(grow: 1)), []),
      p(classes: 'cert-meta', [.text(cert.description)]),
      a(href: cert.href, classes: 'cert-link', [
        .text('Verify'),
        span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
      ]),
    ]);
  }
}
