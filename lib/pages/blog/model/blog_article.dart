// ── Article data ──────────────────────────────────────────────────────────────

import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/shared/model/card_model.dart';

/// Article data class for blog post metadata.
/// Used by both hardcoded articles and jaspr_content MemoryLoader integration.
class BlogArticle extends CardModel {
  BlogArticle({
    required this.category,
    required this.readMin,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.href,
    this.featured = false,
    required this.imageColor,
  });
  final String category, readMin;
  final Color imageColor;
  final bool featured;

  factory BlogArticle.fromMap(Map<String, dynamic> map, String slug) {
    return BlogArticle(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'General',
      readMin: map['readMin'] ?? '5 min read',
      href: '/$slug',
      imageColor: Constants.parseProjectColor(map['imageColor']),
      featured: map['featured'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
