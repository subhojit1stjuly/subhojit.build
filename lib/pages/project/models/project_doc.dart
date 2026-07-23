import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/theme/colors.dart';

class ProjectDoc {
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final String? repoUrl;
  final String? liveUrl;
  final Color imageColor;
  final bool featured;
  final String readTime; // e.g., '3 min read' or architectural scope
  final String href; // Route path for single project view

  const ProjectDoc({
    required this.title,
    required this.description,
    required this.category,
    this.tags = const [],
    this.repoUrl,
    this.liveUrl,
    required this.imageColor,
    this.featured = false,
    this.readTime = 'Case Study',
    required this.href,
  });
  factory ProjectDoc.fromMap(Map<String, dynamic> map, String slug) {
    return ProjectDoc(
      title: map['title'] ?? '',
      description: map['excerpt'] ?? '',
      category: map['category'] ?? 'Engineering',
      tags: List<String>.from(map['tags'] ?? []),
      repoUrl: map['repoUrl'],
      liveUrl: map['liveUrl'],
      imageColor: Constants.parseProjectColor(map['imageColor']),
      featured: map['featured'] ?? false,
      readTime: map['readMin'] ?? '4 min read',
      href: '/projects/$slug',
    );
  }
}
