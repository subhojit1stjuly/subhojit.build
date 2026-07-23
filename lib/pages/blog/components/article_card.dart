// ── Standard article card ─────────────────────────────────────────────────────
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

class ArticleCard extends StatelessComponent {
  const ArticleCard({required this.article});
  final BlogArticle article;

  @override
  Component build(BuildContext context) {
    return div(classes: 'article-card', [
      div(classes: 'article-card-image', styles: Styles(backgroundColor: article.imageColor), [
        span(
          classes: 'material-symbols-outlined',
          styles: Styles(
            color: primaryColor,
            fontSize: 32.px,
          ),
          [
            .text('article'),
          ],
        ),
      ]),
      div(classes: 'article-card-body', [
        div(classes: 'article-meta', [
          span(classes: 'article-category', [.text(article.category)]),
        ]),
        p(classes: 'article-card-title', [.text(article.title)]),
        p(classes: 'article-card-excerpt', [.text(article.excerpt)]),
        div(classes: 'article-card-footer', [
          span(classes: 'article-card-read', [.text(article.readMin)]),
          a(href: article.href, classes: 'article-read-btn', [
            .text('Read'),
            span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
          ]),
        ]),
      ]),
    ]);
  }
}
