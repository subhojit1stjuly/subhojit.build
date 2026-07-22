import 'package:jaspr/dom.dart';

class ProjectDocs {
  final String title;
  final String category;
  final String excerpt;
  final String readMin;
  final String href;
  final Color imageColor;
  final bool featured;

  ProjectDocs({
    required this.title,
    required this.category,
    required this.excerpt,
    required this.readMin,
    required this.href,
    required this.imageColor,
    required this.featured,
  });
}
