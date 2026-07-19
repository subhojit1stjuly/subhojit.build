class JobExperience {
  final String id;
  final String company;
  final String role;
  final String duration;
  final List<String> responsibilities;
  final String? content;

  const JobExperience({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.responsibilities,
    this.content,
  });
}
