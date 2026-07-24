class JobExperience {
  final String title;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String> highlights;
  final bool current;
  final String href;

  const JobExperience({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    this.highlights = const [],
    this.current = false,
    required this.href,
  });

  factory JobExperience.fromMap(Map<String, dynamic> map, String slug) {
    return JobExperience(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      period: map['period'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      highlights: List<String>.from(map['highlights'] ?? []),
      current: map['current'] ?? false,
      href: '/$slug',
    );
  }
}
