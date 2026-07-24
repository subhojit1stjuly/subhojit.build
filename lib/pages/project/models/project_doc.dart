import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';

class ProjectDoc {
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final String? repoUrl;
  final String? liveUrl;
  final Color imageColor;
  final bool featured;
  final String href; // Route path for single project view
  final String imageUrl; // Placeholder for image URL or icon name

  const ProjectDoc({
    required this.title,
    required this.description,
    required this.category,
    this.tags = const [],
    this.repoUrl,
    this.liveUrl,
    required this.imageColor,
    this.featured = false,
    required this.href,
    required this.imageUrl,
  });
  factory ProjectDoc.fromMap(Map<String, dynamic> map, String slug) {
    return ProjectDoc(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'Engineering',
      tags: List<String>.from(map['tags'] ?? []),
      repoUrl: map['repoUrl'],
      liveUrl: map['liveUrl'],
      imageColor: Constants.parseProjectColor(map['imageColor']),
      featured: map['featured'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      href: '/$slug',
    );
  }
}
