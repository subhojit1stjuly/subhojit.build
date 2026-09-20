import 'package:subhojit_build/pages/career/domain/entities/certification.dart';

class CertificationModel extends Certification {
  CertificationModel({
    required super.title,
    required super.issuer,
    required super.date,
    required super.description,
    required super.readMin,
    required super.href,
    super.credentialId,
    super.credentialUrl,
    super.image,
    super.type,
    super.featured,
  });

  factory CertificationModel.fromMap(Map<String, dynamic> map) {
    return CertificationModel(
      title: map['title'] ?? '',
      issuer: map['issuer'] ?? '',
      date: map['date']?.toString() ?? '',
      description: map['description'] ?? '',
      readMin: map['readMin']?.toString() ?? '',
      href: map['href'] ?? '',
      credentialId: map['credentialId'] as String?,
      credentialUrl: map['credentialUrl'] as String?,
      image: map['image'] ?? '',
      type: map['type'] ?? '',
      featured: map['featured'] == true,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'issuer': issuer,
      'date': date,
      'description': description,
      'readMin': readMin,
      'href': href,
      'credentialId': credentialId,
      'credentialUrl': credentialUrl,
      'image': image,
      'type': type,
      'featured': featured,
    };
  }
}
