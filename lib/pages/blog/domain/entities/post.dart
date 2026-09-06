import 'package:jaspr/dom.dart';

// so we can have different implementations like PostModel for data handling

abstract class Post {
  final String category, readMin, title, description, imageUrl, href;
  final Color imageColor;
  final bool featured;
  final List<String> tags;
  final DateTime date;

  Post({
    required this.category,
    required this.readMin,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.href,
    required this.imageColor,
    required this.featured,
    required this.tags,
    required this.date,
  });
  bool get isNew => DateTime.now().difference(date).inDays < 7;
}
