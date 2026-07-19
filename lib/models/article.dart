class Article {
  final String id;
  final String title;
  final DateTime date;
  final String excerpt;
  final List<String> tags;
  final String content;

  const Article({
    required this.id,
    required this.title,
    required this.date,
    required this.excerpt,
    required this.tags,
    required this.content,
  });
}
