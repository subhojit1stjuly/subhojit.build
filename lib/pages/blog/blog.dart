import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/constants/dummy_data.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/shared/components/post_cards/blog_footer.dart';
import 'package:subhojit_build/pages/blog/components/featured_article_card.dart';
import 'package:subhojit_build/pages/blog/components/newsletter_card.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';
import 'package:subhojit_build/shared/components/post_cards/post_card.dart';
import 'package:subhojit_build/shared/model/info_card_model.dart';

/// Technical Insights blog page (/blog).
///
/// Desktop: 2-column layout — main content (left) + sidebar (right).
/// Mobile:  Single column — newsletter card first, then articles, then pagination.
class BlogPage extends StatelessComponent {
  final List<BlogArticle> articles;
  const BlogPage({
    super.key,
    this.articles = const [],
  });

  @override
  Component build(BuildContext context) {
    // Try to get pages from jaspr_content context
    // This only works when rendered inside ContentApp-managed pages
    // 1. Get the content instance;
    List<BlogArticle> displayArticles = DummyData.hardcodedArticles;

    try {
      // 1. Use passed articles if available, otherwise fall back to hardcoded articles
      displayArticles = articles.isNotEmpty ? articles : DummyData.hardcodedArticles;

      // Sort by featured first, then default order
      displayArticles = List.from(displayArticles)
        ..sort((a, b) {
          if (a.featured && !b.featured) return -1;
          if (!a.featured && b.featured) return 1;
          return 0;
        });
      // 1. Use passed articles if available, otherwise fall back to hardcoded articles
    } catch (e) {
      // context.pages not available - using hardcoded articles as fallback
      // This is expected when BlogPage is rendered as a regular route
      print(e);
    }

    return section(classes: 'blog-page', [
      div(classes: 'blog-page-inner container', [
        // Page header
        div(classes: 'blog-header', [
          h1(classes: 'blog-headline t-headline', [.text('Technical Insights')]),
          p(classes: 'blog-sub t-body-lg', [
            .text(
              'Deep dives into Flutter architecture, mobile performance, '
              'and developer tooling.',
            ),
          ]),
        ]),

        // Two-column body: main + sidebar
        div(classes: 'blog-body', [
          // ── Main content (left) ─────────────────────────────────
          div(classes: 'blog-main', [
            // Featured article — large card (first article, preferably featured)
            if (displayArticles.isNotEmpty) FeaturedArticleCard(article: displayArticles.first),

            // Article grid — 2 × N
            div(classes: 'blog-grid', [
              for (final a in displayArticles.skip(1))
                PostCard(
                  data: InfoCardModel(
                    title: a.title,
                    description: a.description,
                    imageUrl: a.imageUrl,
                    category: a.category,
                    tags: a.tags,
                  ),
                  footerComponet: BlogFooter(
                    readMin: a.readMin,
                    href: a.href,
                  ),
                ),
            ]),

            // Pagination
            div(classes: 'blog-pagination', [
              div(classes: 'page-btn page-btn--prev', [
                span(classes: 'material-symbols-outlined', [.text('chevron_left')]),
              ]),
              for (final n in ['1', '2', '3'])
                div(classes: n == '1' ? 'page-btn page-btn--active' : 'page-btn', [
                  .text(n),
                ]),
              div(classes: 'page-btn page-btn--next', [
                span(classes: 'material-symbols-outlined', [.text('chevron_right')]),
              ]),
            ]),
          ]),

          // ── Sidebar (right) ─────────────────────────────────────
          aside(classes: 'blog-sidebar', [
            // Newsletter card
            NewsletterCard(),

            // Taxonomy
            div(classes: 'taxonomy-card tonal-card', [
              p(classes: 'taxonomy-title t-label', [.text('Taxonomy')]),
              for (final t in Constants.taxonomy)
                div(classes: 'taxonomy-row', [
                  span(classes: 'taxonomy-label t-body', [.text(t.label)]),
                  span(classes: 'taxonomy-count t-label', [.text(t.count)]),
                ]),
            ]),

            // Author card
            div(classes: 'author-card tonal-card', [
              div(classes: 'author-avatar', [.text('SP')]),
              div([
                p(classes: 'author-name', [.text('Subhojit Pramanik')]),
                p(classes: 'author-title t-body', [.text('Senior Software Engineer')]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.blog-page').styles(
      padding: .symmetric(vertical: 5.rem),
      raw: {'padding-top': '7rem'},
    ),
    css('.blog-header').styles(raw: {'margin-bottom': '3rem'}),
    css('.blog-headline').styles(
      color: onSurface,
      raw: {'margin-bottom': '1rem', 'font-size': '3rem', 'font-weight': '600', 'letter-spacing': '-0.02em'},
    ),
    css('.blog-sub').styles(color: onSurfaceVariant),

    // ── Two-column layout ─────────────────────────────────────────────────
    css('.blog-body').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(3)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(2.rem),
      raw: {'align-items': 'start'},
    ),
    css('.blog-main').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(2.rem),
    ),

    // ── Featured article ──────────────────────────────────────────────────
    css('.featured-card').styles(
      display: .grid,
      radius: BorderRadius.circular(16.px),
      overflow: .clip,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      backgroundColor: surfaceContainerLowest,
      raw: {'box-shadow': '0px 4px 16px rgba(26,28,30,0.06)'},
    ),
    css('.featured-image').styles(
      display: .flex,
      height: 280.px,
      justifyContent: .center,
      alignItems: .center,
    ),
    css('.featured-content').styles(
      display: .flex,
      padding: .all(1.75.rem),
      flexDirection: .column,
      justifyContent: .center,
      gap: .all(0.75.rem),
    ),
    css('.article-meta').styles(
      display: .flex,
      alignItems: .center,
      gap: .all(0.75.rem),
    ),
    css('.article-category').styles(
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      color: primaryColor,
      fontSize: 11.px,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      backgroundColor: primaryFixed,
      raw: {'letter-spacing': '0.06em'},
    ),
    css('.article-readtime').styles(
      color: onSurfaceVariant,
      fontSize: 12.px,
    ),
    css('.article-title').styles(
      color: onSurface,
      fontSize: 22.px,
      fontWeight: .w700,
      raw: {'line-height': '1.35'},
    ),
    css('.article-excerpt').styles(
      color: onSurfaceVariant,
      fontSize: 14.px,
      lineHeight: 1.6.em,
    ),
    css('.article-read-link').styles(
      display: .inlineFlex,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      gap: Gap.all(0.25.rem),
      color: primaryColor,
      fontSize: 13.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
    css('.article-read-link:hover').styles(color: onPrimaryFixedVariant),

    // ── Article grid ──────────────────────────────────────────────────────
    css('.blog-grid').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      gap: Gap.all(1.25.rem),
    ),
    css('.article-card').styles(
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
    css('.article-card:hover').styles(
      raw: {'transform': 'translateY(-2px)', 'box-shadow': '0px 8px 24px rgba(26,28,30,0.10)'},
    ),
    css('.article-card-image').styles(
      display: .flex,
      height: 160.px,
      justifyContent: .center,
      alignItems: .center,
    ),
    css('.article-card-body').styles(
      display: .flex,
      padding: .all(1.25.rem),
      flexDirection: .column,
      gap: Gap.all(0.5.rem),
      flex: Flex(grow: 1),
    ),
    css('.article-card-title').styles(
      color: onSurface,
      fontSize: 16.px,
      fontWeight: .w700,
      raw: {'line-height': '1.4'},
    ),
    css('.article-card-excerpt').styles(
      flex: Flex(grow: 1),
      color: onSurfaceVariant,
      fontSize: 13.px,
      lineHeight: 1.55.em,
    ),
    css('.article-card-footer').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {'margin-top': '0.5rem'},
    ),
    css('.article-card-read').styles(
      color: onSurfaceVariant,
      fontSize: 12.px,
    ),
    css('.article-read-btn').styles(
      display: .inlineFlex,
      alignItems: .center,
      gap: Gap.all(0.125.rem),
      color: primaryColor,
      fontSize: 11.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),

    // ── Pagination ────────────────────────────────────────────────────────
    css('.blog-pagination').styles(
      display: .flex,
      justifyContent: .center,
      alignItems: .center,
      gap: Gap.all(0.375.rem),
    ),
    css('.page-btn').styles(
      display: .flex,
      width: 36.px,
      height: 36.px,
      radius: BorderRadius.circular(99.px),
      cursor: Cursor.pointer,
      transition: Transition.combine([
        Transition('color', duration: Duration(milliseconds: 150)),
        Transition('background-color', duration: Duration(milliseconds: 150)),
      ]),
      justifyContent: .center,
      alignItems: .center,
      color: onSurfaceVariant,
      fontSize: 14.px,
      fontWeight: .w500,
      backgroundColor: surfaceContainerHigh,
    ),
    css('.page-btn:hover').styles(
      color: onSurface,
      backgroundColor: surfaceContainerHighest,
    ),
    css('.page-btn--active').styles(
      color: onPrimary,
      backgroundColor: primaryColor,
    ),

    // ── Sidebar ───────────────────────────────────────────────────────────
    css('.blog-sidebar').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap.all(1.25.rem),
      raw: {'position': 'sticky', 'top': '5rem'},
    ),

    // Newsletter card
    css('.newsletter-card').styles(
      display: .flex,
      padding: .all(1.5.rem),
      radius: BorderRadius.circular(16.px),
      flexDirection: .column,
      gap: Gap.all(0.75.rem),
      backgroundColor: primaryContainer,
    ),
    css('.newsletter-title').styles(
      color: onPrimary,
      fontSize: 17.px,
      fontWeight: .w700,
    ),
    css('.newsletter-sub').styles(
      color: onPrimary,
      fontSize: 13.px,
      raw: {'opacity': '0.88', 'line-height': '1.5'},
    ),
    css('.newsletter-input').styles(
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      color: onPrimary,
      fontSize: 14.px,
      backgroundColor: const Color.variable('--surface-container'),
      raw: {
        'border': '1px solid rgba(255,255,255,0.3)',
        'outline': 'none',
        'width': '100%',
        'box-sizing': 'border-box',
        '::placeholder': 'color: rgba(255,255,255,0.6)',
      },
    ),
    css('.newsletter-btn').styles(
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      cursor: Cursor.pointer,
      color: primaryColor,
      textAlign: TextAlign.center,
      fontSize: 13.px,
      fontWeight: .w700,
      backgroundColor: surfaceContainerLowest,
    ),
    css('.newsletter-note').styles(
      color: onPrimary,
      fontSize: 11.px,
      raw: {'opacity': '0.7'},
    ),

    // Taxonomy card
    css('.taxonomy-card').styles(padding: .all(1.25.rem)),
    css('.taxonomy-title').styles(color: onSurfaceVariant, raw: {'margin-bottom': '0.875rem'}),
    css('.taxonomy-row').styles(
      display: .flex,
      padding: .symmetric(vertical: 0.5.rem),
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {'border-bottom': '1px solid ${outlineVariant.value}'},
    ),
    css('.taxonomy-row:last-child').styles(raw: {'border-bottom': 'none'}),
    css('.taxonomy-label').styles(color: onSurface),
    css('.taxonomy-count').styles(
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.125.rem),
      radius: BorderRadius.circular(4.px),
      color: primaryColor,
      backgroundColor: primaryFixed,
    ),

    // Author card
    css('.author-card').styles(
      display: .flex,
      padding: .all(1.25.rem),
      alignItems: .center,
      gap: Gap.all(0.75.rem),
    ),
    css('.author-avatar').styles(
      display: .flex,
      width: 44.px,
      height: 44.px,
      radius: BorderRadius.circular(99.px),
      justifyContent: .center,
      alignItems: .center,
      color: onPrimary,
      fontSize: 14.px,
      fontWeight: .w700,
      backgroundColor: primaryContainer,
      raw: {'flex-shrink': '0'},
    ),
    css('.author-name').styles(
      color: onSurface,
      fontSize: 14.px,
      fontWeight: .w700,
    ),
    css('.author-title').styles(color: onSurfaceVariant),

    // ── Mobile: single-column, sidebar stacks below ────────────────────────
    css.media(MediaQuery.screen(maxWidth: 1024.px), [
      css('.blog-body').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.blog-sidebar').styles(raw: {'position': 'static'}),
      css('.featured-card').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
      css('.blog-page').styles(raw: {'padding-top': '6rem'}),
    ]),
    css.media(MediaQuery.screen(maxWidth: 600.px), [
      css('.blog-grid').styles(
        gridTemplate: GridTemplate(
          columns: GridTracks([GridTrack(TrackSize.fr(1))]),
        ),
      ),
    ]),
  ];
}
