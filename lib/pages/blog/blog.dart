import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/constants/dummy_data.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';
import 'package:subhojit_build/pages/blog/blog_page_client.dart';

/// Blog page wrapper component.
///
/// Converts BlogArticle list to serializable Maps and passes to BlogPageClient.
class BlogPage extends StatelessComponent {
  final List<BlogArticle> articles;

  const BlogPage({
    super.key,
    this.articles = const [],
  });

  @override
  Component build(BuildContext context) {
    // Get articles or use fallback
    List<BlogArticle> allArticles = articles.isNotEmpty ? articles : DummyData.hardcodedArticles;

    // Sort by featured first
    allArticles = List.from(allArticles)
      ..sort((a, b) {
        if (a.featured && !b.featured) return -1;
        if (!a.featured && b.featured) return 1;
        return 0;
      });

    // Convert to serializable Maps for @client component
    final articlesData = allArticles.map((a) => a.toMap()).toList();

    return BlogPageClient(articlesData: articlesData);
  }
}
