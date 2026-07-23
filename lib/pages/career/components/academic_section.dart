import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/career/components/cert_card.dart';
import 'package:subhojit_build/pages/career/models/certification.dart';

class AcademicSection extends StatelessComponent {
  final List<Certification> certs;
  const AcademicSection({super.key, required this.certs});

  @override
  Component build(BuildContext context) {
    return section(classes: 'academic-section', [
      div(classes: 'academic-inner container', [
        div(classes: 'academic-heading', [
          div(classes: 'heading-bar', []),
          h2(classes: 'academic-title t-headline', [.text('Academic & Validation')]),
        ]),
        div(classes: 'cert-grid', [
          for (final c in certs) CertCard(cert: c),
        ]),
      ]),
    ]);
  }
}
