// ── Article data ──────────────────────────────────────────────────────────────

import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';

/// Article data class for blog post metadata.
/// Used by both hardcoded articles and jaspr_content MemoryLoader integration.
class BlogArticle {
  const BlogArticle({
    required this.category,
    required this.readMin,
    required this.title,
    required this.excerpt,
    required this.href,
    this.featured = false,
    required this.imageColor,
  });
  final String category, readMin, title, excerpt, href;
  final Color imageColor;
  final bool featured;

  factory BlogArticle.fromMap(Map<String, dynamic> map, String slug) {
    return BlogArticle(
      title: map['title'] ?? '',
      excerpt: map['excerpt'] ?? '',
      category: map['category'] ?? 'General',
      readMin: map['readMin'] ?? '5 min read',
      href: '/blogs/$slug',
      imageColor: Constants.parseProjectColor(map['imageColor']),
      featured: map['featured'] ?? false,
    );
  }
}
