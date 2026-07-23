class Certification {
  final String title;
  final String issuer;
  final String date;
  final String? credentialId;
  final String? credentialUrl;
  final String description;
  final String href;
  final String image;
  final String type;

  const Certification({
    required this.title,
    required this.issuer,
    required this.date,
    this.credentialId,
    this.credentialUrl,
    required this.description,
    required this.href,
    this.image = '',
    this.type = '',
  });

  factory Certification.fromMap(Map<String, dynamic> map, String slug) {
    return Certification(
      title: map['title'] ?? '',
      issuer: map['issuer'] ?? '',
      date: map['date'] ?? '',
      credentialId: map['credentialId'],
      credentialUrl: map['credentialUrl'],
      description: map['description'] ?? '',
      href: '/certifications/$slug',
      image: map['image'] ?? '',
      type: map['type'] ?? '',
    );
  }
}
