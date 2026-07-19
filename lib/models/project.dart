class Project {
  final String id;
  final String name;
  final String description;
  final List<String> technologies;
  final String? externalLink;
  final String? content;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.technologies,
    this.externalLink,
    this.content,
  });
}
