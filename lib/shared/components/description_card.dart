// ── Standard article card ─────────────────────────────────────────────────────
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

class DescriptionCard extends StatelessComponent {
  const DescriptionCard({required this.article});
  final BlogArticle article;

  @override
  Component build(BuildContext context) {
    return div(classes: 'common_card', [
      // Image Container
      div(classes: 'common_card-header', [
        img(
          classes: 'common_card-img',
          src: article.imageUrl,
          alt: article.title,
        ),
      ]),
      /*  div(classes: 'common_card-image', styles: Styles(backgroundColor: article.imageColor), [
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
      ]), */
      div(classes: 'common_card-body', [
        div(classes: 'article-meta', [
          span(classes: 'article-category', [.text(article.category)]),
        ]),
        p(classes: 'common_card-title', [.text(article.title)]),
        p(classes: 'common_card-excerpt', [.text(article.description)]),
        div(classes: 'common_card-footer', [
          span(classes: 'common_card-read', [.text(article.readMin)]),
          a(href: article.href, classes: 'common_card-read-btn', [
            .text('Read'),
            span(classes: 'material-symbols-outlined', [.text('open_in_new')]),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.common_card').styles(
      display: .flex,
      radius: BorderRadius.circular(12.px),
      overflow: .clip,
      transition: Transition.combine([
        Transition('transform', duration: Duration(milliseconds: 200)),
        Transition('box-shadow', duration: Duration(milliseconds: 200)),
      ]),
      flexDirection: .column,
      backgroundColor: surfaceContainerLowest,
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.common_card-img').styles(
      width: Unit.percent(100),
      height: Unit.percent(100),
      raw: {'object-fit': 'cover'},
    ),
    css('.common_card:hover').styles(
      raw: {'transform': 'translateY(-2px)', 'box-shadow': '0px 8px 24px rgba(26,28,30,0.10)'},
    ),
    css('.common_card-header').styles(
      display: .flex,
      height: 160.px,
      justifyContent: .center,
      alignItems: .center,
    ),
    css('.common_card-body').styles(
      display: .flex,
      padding: .all(1.25.rem),
      flexDirection: .column,
      gap: Gap.all(0.5.rem),
      flex: Flex(grow: 1),
    ),
    css('.common_card-title').styles(
      color: onSurface,
      fontSize: 16.px,
      fontWeight: .w700,
      raw: {'line-height': '1.4'},
    ),
    css('.common_card-excerpt').styles(
      flex: Flex(grow: 1),
      color: onSurfaceVariant,
      fontSize: 13.px,
      lineHeight: 1.55.em,
    ),
    css('.common_card-footer').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {'margin-top': '0.5rem'},
    ),
    css('.common_card-read').styles(
      color: onSurfaceVariant,
      fontSize: 12.px,
    ),
    css('.common_card-read-btn').styles(
      display: .inlineFlex,
      alignItems: .center,
      gap: Gap.all(0.125.rem),
      color: primaryColor,
      fontSize: 11.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
  ];
}
