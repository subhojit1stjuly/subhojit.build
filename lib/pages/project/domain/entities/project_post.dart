import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/utils/json_datasource.dart';

abstract class ProjectPost extends JsonSerializable {
  final String category, readMin, title, description, imageUrl, href;
  final String? repoUrl, liveUrl;
  final Color imageColor;
  final bool featured;
  final List<String> tags;

  const ProjectPost({
    required this.category,
    required this.readMin,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.href,
    this.repoUrl,
    this.liveUrl,
    required this.imageColor,
    required this.featured,
    required this.tags,
  });
}
