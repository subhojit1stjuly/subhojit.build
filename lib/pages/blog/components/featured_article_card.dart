// ── Featured article card ─────────────────────────────────────────────────────
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

class FeaturedArticleCard extends StatelessComponent {
  const FeaturedArticleCard({required this.article});
  final BlogArticle article;

  @override
  Component build(BuildContext context) {
    return div(classes: 'featured-card', [
      div(classes: 'featured-image', styles: Styles(backgroundColor: article.imageColor), [
        span(
          classes: 'material-symbols-outlined',
          styles: Styles(
            color: primaryColor,
            fontSize: 48.px,
          ),
          [
            .text('article'),
          ],
        ),
      ]),
      div(classes: 'featured-content', [
        div(classes: 'article-meta', [
          span(classes: 'article-category', [.text(article.category)]),
          span(classes: 'article-readtime', [.text(article.readMin)]),
        ]),
        p(classes: 'article-title', [.text(article.title)]),
        p(classes: 'article-excerpt', [.text(article.description)]),
        a(href: article.href, classes: 'article-read-link', [
          .text('Read Article'),
          span(classes: 'material-symbols-outlined', [.text('arrow_forward')]),
        ]),
      ]),
    ]);
  }
}
