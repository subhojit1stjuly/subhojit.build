import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';

/// Article data class for blog post metadata.
/// Used by both hardcoded articles and jaspr_content MemoryLoader integration.
class BlogArticle {
  BlogArticle({
    required this.category,
    required this.readMin,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.href,
    this.featured = false,
    required this.imageColor,
    required this.tags,
  });
  final String category, readMin, title, description, imageUrl, href;
  final Color imageColor;
  final bool featured;
  final List<String> tags;

  factory BlogArticle.fromMap(Map<String, dynamic> map, String slug) {
    return BlogArticle(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'General',
      readMin: map['readMin'] ?? '5 min read',
      href: map['href'] ?? '/$slug',
      imageColor: map['imageColor'] is Color ? map['imageColor'] : Constants.parseProjectColor(map['imageColor']),
      featured: map['featured'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  /// Convert to Map for serialization to @client components
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'readMin': readMin,
      'href': href,
      'imageColor': imageColor.value, // Serialize color as hex string
      'featured': featured,
      'imageUrl': imageUrl,
      'tags': tags,
      'slug': href.replaceAll('/', ''), // Extract slug from href
    };
  }
}
