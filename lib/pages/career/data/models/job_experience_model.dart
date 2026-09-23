import 'package:subhojit_build/pages/career/domain/entities/job_experience.dart';

class JobExperienceModel extends JobExperience {
  JobExperienceModel({
    required super.title,
    required super.company,
    required super.period,
    required super.location,
    required super.description,
    required super.readMin,
    required super.href,
    super.highlights,
    super.current,
    super.featured,
  });

  factory JobExperienceModel.fromMap(Map<String, dynamic> map) {
    // meta.g.dart stores highlights as "" and current as "true"/"false" strings
    final rawHighlights = map['highlights'];
    final highlights = rawHighlights is List ? List<String>.from(rawHighlights) : <String>[];

    return JobExperienceModel(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      period: map['period'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      readMin: map['readMin']?.toString() ?? '',
      href: map['href'] ?? '',
      highlights: highlights,
      current: map['current']?.toString() == 'true',
      featured: map['featured'] == true,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'period': period,
      'location': location,
      'description': description,
      'readMin': readMin,
      'href': href,
      'highlights': highlights,
      'current': current,
      'featured': featured,
    };
  }
}
