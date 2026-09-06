import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/shared/model/info_card_model.dart';

class PostCard extends StatelessComponent {
  const PostCard({
    required this.data,
    required this.footerComponet,
  });
  final InfoCardModel data;
  final Component footerComponet;

  @override
  Component build(BuildContext context) {
    return div(classes: 'common_card', [
      div(classes: 'project-image', styles: Styles(backgroundColor: Color.variable('--secondary-container')), [
        // Image Container
        img(
          classes: 'common_card-img',
          src: data.imageUrl,
          alt: data.title,
        ),
        div(classes: 'common_card-category-chip', [.text(data.category)]),
      ]),
      // Image Container
      /* div(classes: 'common_card-header', [
        img(
          classes: 'common_card-img',
          src: data.imageUrl,
          alt: data.title,
        ),
      ]), */
      div(classes: 'common_card-body', [
        p(classes: 'common_card-title', [.text(data.title)]),
        p(classes: 'common_card-excerpt', [.text(data.description)]),
        div(classes: 'project-tags', [
          for (final tag in data.tags) span(classes: 'common_card-tag', [.text(tag)]),
        ]),
        footerComponet,
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
      backgroundColor: Color.variable('--surface-container-lowest'),
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
    ),
    css('.common_card-img').styles(
      display: .flex,
      height: 180.px,
      justifyContent: .center,
      alignItems: .center,
      raw: {'position': 'relative', 'object-fit': 'cover'},
    ),
    css('.common_card-category-chip').styles(
      position: .absolute(bottom: 12.px, left: 12.px),
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: Color.variable('--primary'),
      fontSize: 11.px,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      backgroundColor: Color.variable('--primary-fixed'),
      raw: {'letter-spacing': '0.05em'},
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
      color: Color.variable('--on-surface'),
      fontSize: 16.px,
      fontWeight: .w700,
      raw: {'line-height': '1.4'},
    ),
    css('.common_card-excerpt').styles(
      flex: Flex(grow: 1),
      color: Color.variable('--on-surface-variant'),
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
      color: Color.variable('--on-surface-variant'),
      fontSize: 12.px,
    ),
    css('.common_card-read-btn').styles(
      display: .inlineFlex,
      alignItems: .center,
      gap: Gap.all(0.125.rem),
      color: Color.variable('--primary'),
      fontSize: 11.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
    css('.common_card-tags').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(0.375.rem),
      raw: {'margin-bottom': '1rem'},
    ),
    css('.common_card-tag').styles(
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(8.px),
      color: Color.variable('--on-surface'),
      fontSize: 11.px,
      fontWeight: .w500,
      backgroundColor: Color.variable('--surface-container-high'),
    ),
  ];
}
