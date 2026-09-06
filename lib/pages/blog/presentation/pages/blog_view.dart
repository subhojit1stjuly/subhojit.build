import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_article.dart';
import 'package:subhojit_build/pages/blog/presentation/components/featured_article_card.dart';
import 'package:subhojit_build/pages/blog/presentation/components/newsletter_card.dart';
import 'package:subhojit_build/pages/blog/presentation/components/pagination_controls.dart';
import 'package:subhojit_build/shared/components/post_cards/post_card.dart';
import 'package:subhojit_build/shared/components/post_cards/blog_footer.dart';
import 'package:subhojit_build/shared/model/info_card_model.dart';

/// Blog page view component - pure presentation without state.
///
/// Receives paginated articles and renders the blog layout.
class BlogView extends StatelessComponent {
  final List<BlogArticle> articles;
  final int currentPage;
  final void Function(int) onPageChange;

  static const int articlesPerPage = 7; // 1 featured + 6 grid

  const BlogView({
    required this.articles,
    required this.currentPage,
    required this.onPageChange,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Calculate pagination
    final totalPages = (articles.length / articlesPerPage).ceil();
    final startIndex = (currentPage - 1) * articlesPerPage;
    final endIndex = (startIndex + articlesPerPage).clamp(0, articles.length);
    final displayArticles = articles.sublist(startIndex, endIndex);

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

            // Pagination - Client-side interactive controls
            if (totalPages > 1)
              PaginationControls(
                totalPages: totalPages,
                currentPage: currentPage,
                onPageChange: onPageChange,
              ),
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
      color: Color.variable('--on-surface'),
      raw: {'margin-bottom': '1rem', 'font-size': '3rem', 'font-weight': '600', 'letter-spacing': '-0.02em'},
    ),
    css('.blog-sub').styles(color: Color.variable('--on-surface-variant')),

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
      backgroundColor: Color.variable('--surface-container-lowest'),
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
      color: Color.variable('--primary'),
      fontSize: 11.px,
      fontWeight: .w600,
      textTransform: TextTransform.upperCase,
      backgroundColor: Color.variable('--primary-fixed'),
      raw: {'letter-spacing': '0.06em'},
    ),
    css('.article-readtime').styles(
      color: Color.variable('--on-surface-variant'),
      fontSize: 12.px,
    ),
    css('.article-title').styles(
      color: Color.variable('--on-surface'),
      fontSize: 22.px,
      fontWeight: .w700,
      raw: {'line-height': '1.35'},
    ),
    css('.article-excerpt').styles(
      color: Color.variable('--on-surface-variant'),
      fontSize: 14.px,
      lineHeight: 1.6.em,
    ),
    css('.article-read-link').styles(
      display: .inlineFlex,
      transition: Transition('color', duration: Duration(milliseconds: 150)),
      alignItems: .center,
      gap: Gap.all(0.25.rem),
      color: Color.variable('--primary'),
      fontSize: 13.px,
      fontWeight: .w700,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
    ),
    css('.article-read-link:hover').styles(color: Color.variable('--on-primary-fixed-variant')),

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
      backgroundColor: Color.variable('--surface-container-lowest'),
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
      color: Color.variable('--on-surface'),
      fontSize: 16.px,
      fontWeight: .w700,
      raw: {'line-height': '1.4'},
    ),
    css('.article-card-excerpt').styles(
      flex: Flex(grow: 1),
      color: Color.variable('--on-surface-variant'),
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
      color: Color.variable('--on-surface-variant'),
      fontSize: 12.px,
    ),
    css('.article-read-btn').styles(
      display: .inlineFlex,
      alignItems: .center,
      gap: Gap.all(0.125.rem),
      color: Color.variable('--primary'),
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
      color: Color.variable('--on-surface-variant'),
      fontSize: 14.px,
      fontWeight: .w500,
      backgroundColor: Color.variable('--surface-container-high'),
    ),
    css('.page-btn:hover').styles(
      color: Color.variable('--on-surface'),
      backgroundColor: Color.variable('--surface-container-highest'),
    ),
    css('.page-btn--active').styles(
      color: Color.variable('--on-primary'),
      backgroundColor: Color.variable('--primary'),
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
      backgroundColor: Color.variable('--primary-container'),
    ),
    css('.newsletter-title').styles(
      color: Color.variable('--on-primary'),
      fontSize: 17.px,
      fontWeight: .w700,
    ),
    css('.newsletter-sub').styles(
      color: Color.variable('--on-primary'),
      fontSize: 13.px,
      raw: {'opacity': '0.88', 'line-height': '1.5'},
    ),
    css('.newsletter-input').styles(
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      color: Color.variable('--on-primary'),
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
      color: Color.variable('--primary'),
      textAlign: TextAlign.center,
      fontSize: 13.px,
      fontWeight: .w700,
      backgroundColor: Color.variable('--surface-container-lowest'),
    ),
    css('.newsletter-note').styles(
      color: Color.variable('--on-primary'),
      fontSize: 11.px,
      raw: {'opacity': '0.7'},
    ),

    // Taxonomy card
    css('.taxonomy-card').styles(padding: .all(1.25.rem)),
    css('.taxonomy-title').styles(color: Color.variable('--on-surface-variant'), raw: {'margin-bottom': '0.875rem'}),
    css('.taxonomy-row').styles(
      display: .flex,
      padding: .symmetric(vertical: 0.5.rem),
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {'border-bottom': '1px solid var(--outline-variant)'},
    ),
    css('.taxonomy-row:last-child').styles(raw: {'border-bottom': 'none'}),
    css('.taxonomy-label').styles(color: Color.variable('--on-surface')),
    css('.taxonomy-count').styles(
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.125.rem),
      radius: BorderRadius.circular(4.px),
      color: Color.variable('--primary'),
      backgroundColor: Color.variable('--primary-fixed'),
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
      color: Color.variable('--on-primary'),
      fontSize: 14.px,
      fontWeight: .w700,
      backgroundColor: Color.variable('--primary-container'),
      raw: {'flex-shrink': '0'},
    ),
    css('.author-name').styles(
      color: Color.variable('--on-surface'),
      fontSize: 14.px,
      fontWeight: .w700,
    ),
    css('.author-title').styles(color: Color.variable('--on-surface-variant')),

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
