import 'package:subhojit_build/core/utils/json_datasource.dart';

abstract class Certification extends JsonSerializable {
  final String title, issuer, date, description, readMin, href;
  final String? credentialId, credentialUrl;
  final String image, type;
  final bool featured;

  const Certification({
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    required this.readMin,
    required this.href,
    this.credentialId,
    this.credentialUrl,
    this.image = '',
    this.type = '',
    this.featured = false,
  });
}
