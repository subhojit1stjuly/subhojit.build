// ── Article data ──────────────────────────────────────────────────────────────

import 'package:jaspr/dom.dart';

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
}
