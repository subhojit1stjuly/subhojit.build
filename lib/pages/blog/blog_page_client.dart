import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/blog/blog_view.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

/// Client-side blog page with pagination state.
///
/// This @client component receives article data as serializable Maps
/// and manages pagination state interactively.
@client
class BlogPageClient extends StatefulComponent {
  /// Articles as List<Map> - serializable for @client
  final List<Map<String, dynamic>> articlesData;

  const BlogPageClient({
    required this.articlesData,
    super.key,
  });

  @override
  State<BlogPageClient> createState() => _BlogPageClientState();
}

class _BlogPageClientState extends State<BlogPageClient> {
  int currentPage = 1;
  late List<BlogArticle> articles;

  @override
  void initState() {
    super.initState();
    // Deserialize articles from Map data
    articles = component.articlesData.map((data) => BlogArticle.fromMap(data, data['slug'] ?? '')).toList();
  }

  void _handlePageChange(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Component build(BuildContext context) {
    return BlogView(
      articles: articles,
      currentPage: currentPage,
      onPageChange: _handlePageChange,
    );
  }
}
