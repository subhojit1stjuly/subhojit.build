import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

// ── Article data ──────────────────────────────────────────────────────────────

/// Article data class for blog post metadata.
/// Used by both hardcoded articles and jaspr_content MemoryLoader integration.
class BlogArticle {
  const BlogArticle({required this.category, required this.readMin, required this.title,
                   required this.excerpt, required this.href, this.featured = false,
                   this.imageColor = '#e5deff'});
  final String category, readMin, title, excerpt, href, imageColor;
  final bool featured;
}

/// Exported for jaspr_content MemoryLoader in main.server.dart.
/// These hardcoded articles serve as fallback during infrastructure validation.
const hardcodedArticles = [
  BlogArticle(
    category: 'Architecture',
    readMin: '12 min read',
    title: 'Clean Architecture in Flutter: A Production Guide',
    excerpt: 'How to structure large Flutter apps with Clean Architecture so '
             'your codebase stays maintainable as the team and feature-set grow.',
    href: '#',
    featured: true,
    imageColor: '#d1e6f2',
  ),
  BlogArticle(
    category: 'Performance',
    readMin: '8 min read',
    title: 'The P99 Problem: Solving Tail Latency in Flutter',
    excerpt: 'Why averages lie and how to hunt down the microscopic jank that '
             'degrades perceived smoothness — even when 95% of frames hit 60fps.',
    href: '#',
    imageColor: '#e5deff',
  ),
  BlogArticle(
    category: 'State Management',
    readMin: '10 min read',
    title: 'Riverpod 3 vs Bloc: When to Use Which',
    excerpt: 'A pragmatic comparison of the two dominant state management '
             'solutions in Flutter, with real-world trade-off examples.',
    href: '#',
    imageColor: '#f0eee9',
  ),
  BlogArticle(
    category: 'DevOps',
    readMin: '15 min read',
    title: 'Automating Flutter Releases with GitHub Actions',
    excerpt: 'End-to-end CI/CD pipeline: build, test, sign, and ship to '
             'both Play Store and App Store in a single workflow file.',
    href: '#',
    imageColor: '#d1e6f2',
  ),
  BlogArticle(
    category: 'Architecture',
    readMin: '9 min read',
    title: 'Offline-First Flutter with CRDTs',
    excerpt: 'Implementing conflict-free replicated data types to give your '
             'app seamless offline sync that just works, even with multiple devices.',
    href: '#',
    imageColor: '#e5deff',
  ),
];

const _taxonomy = [
  (label: 'Architecture',     count: '8'),
  (label: 'Performance',      count: '5'),
  (label: 'State Management', count: '6'),
  (label: 'DevOps / CI/CD',   count: '4'),
  (label: 'UI & Animations',  count: '7'),
];

// ── Blog page ─────────────────────────────────────────────────────────────────

/// Technical Insights blog page (/blog).
///
/// Desktop: 2-column layout — main content (left) + sidebar (right).
/// Mobile:  Single column — newsletter card first, then articles, then pagination.
class BlogPage extends StatelessComponent {
  const BlogPage({super.key});

  @override
  Component build(BuildContext context) {
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
            // Featured article — large card
            _FeaturedArticleCard(article: hardcodedArticles.first),

            // Article grid — 2 × N
            div(classes: 'blog-grid', [
              for (final a in hardcodedArticles.skip(1)) _ArticleCard(article: a),
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
            _NewsletterCard(),

            // Taxonomy
            div(classes: 'taxonomy-card tonal-card', [
              p(classes: 'taxonomy-title t-label', [.text('Taxonomy')]),
              for (final t in _taxonomy)
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
    css('.blog-header').styles(raw: {'margin-bottom': '2.5rem'}),
    css('.blog-headline').styles(color: onSurface, raw: {'margin-bottom': '0.5rem'}),
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
      display: .flex, flexDirection: .column, gap: Gap.all(2.rem),
    ),

    // ── Featured article ──────────────────────────────────────────────────
    css('.featured-card').styles(
      backgroundColor: surfaceContainerLowest,
      radius: BorderRadius.circular(16.px),
      overflow: .clip,
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([GridTrack(TrackSize.fr(1)), GridTrack(TrackSize.fr(1))]),
      ),
      raw: {'box-shadow': '0px 4px 16px rgba(26,28,30,0.06)'},
    ),
    css('.featured-image').styles(
      height: 280.px,
      display: .flex,
      alignItems: .center,
      justifyContent: .center,
    ),
    css('.featured-content').styles(
      padding: .all(1.75.rem),
      display: .flex, flexDirection: .column, justifyContent: .center,
      gap: Gap.all(0.75.rem),
    ),
    css('.article-meta').styles(
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
    ),
    css('.article-category').styles(
      fontSize: 11.px, fontWeight: .w600, color: primaryColor,
      backgroundColor: primaryFixed,
      padding: .symmetric(horizontal: 0.625.rem, vertical: 0.25.rem),
      radius: BorderRadius.circular(4.px),
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.06em'},
    ),
    css('.article-readtime').styles(fontSize: 12.px, color: onSurfaceVariant),
    css('.article-title').styles(
      fontSize: 22.px, fontWeight: .w700, color: onSurface,
      raw: {'line-height': '1.35'},
    ),
    css('.article-excerpt').styles(
      fontSize: 14.px, color: onSurfaceVariant, lineHeight: 1.6.em,
    ),
    css('.article-read-link').styles(
      display: .inlineFlex, alignItems: .center, gap: Gap.all(0.25.rem),
      fontSize: 13.px, fontWeight: .w700, color: primaryColor,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
      transition: Transition('color', duration: Duration(milliseconds: 150)),
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
      backgroundColor: surfaceContainerLowest,
      radius: BorderRadius.circular(12.px),
      overflow: .clip,
      display: .flex, flexDirection: .column,
      raw: {'box-shadow': '0px 2px 8px rgba(26,28,30,0.04)'},
      transition: Transition.combine([
        Transition('transform', duration: Duration(milliseconds: 200)),
        Transition('box-shadow', duration: Duration(milliseconds: 200)),
      ]),
    ),
    css('.article-card:hover').styles(
      raw: {'transform': 'translateY(-2px)',
            'box-shadow': '0px 8px 24px rgba(26,28,30,0.10)'},
    ),
    css('.article-card-image').styles(height: 160.px, display: .flex,
        alignItems: .center, justifyContent: .center),
    css('.article-card-body').styles(
      padding: .all(1.25.rem),
      display: .flex, flexDirection: .column,
      gap: Gap.all(0.5.rem), flex: Flex(grow: 1),
    ),
    css('.article-card-title').styles(
      fontSize: 16.px, fontWeight: .w700, color: onSurface,
      raw: {'line-height': '1.4'},
    ),
    css('.article-card-excerpt').styles(
      fontSize: 13.px, color: onSurfaceVariant, lineHeight: 1.55.em,
      flex: Flex(grow: 1),
    ),
    css('.article-card-footer').styles(
      display: .flex, justifyContent: .spaceBetween, alignItems: .center,
      raw: {'margin-top': '0.5rem'},
    ),
    css('.article-card-read').styles(
      fontSize: 12.px, color: onSurfaceVariant,
    ),
    css('.article-read-btn').styles(
      fontSize: 11.px, fontWeight: .w700, color: primaryColor,
      textTransform: TextTransform.upperCase,
      raw: {'letter-spacing': '0.05em'},
      display: .inlineFlex, alignItems: .center, gap: Gap.all(0.125.rem),
    ),

    // ── Pagination ────────────────────────────────────────────────────────
    css('.blog-pagination').styles(
      display: .flex, justifyContent: .center, alignItems: .center,
      gap: Gap.all(0.375.rem),
    ),
    css('.page-btn').styles(
      display: .flex, alignItems: .center, justifyContent: .center,
      width: 36.px, height: 36.px,
      radius: BorderRadius.circular(99.px),
      fontSize: 14.px, fontWeight: .w500,
      color: onSurfaceVariant,
      backgroundColor: surfaceContainerHigh,
      cursor: Cursor.pointer,
      transition: Transition.combine([
        Transition('color', duration: Duration(milliseconds: 150)),
        Transition('background-color', duration: Duration(milliseconds: 150)),
      ]),
    ),
    css('.page-btn:hover').styles(backgroundColor: surfaceContainerHighest, color: onSurface),
    css('.page-btn--active').styles(backgroundColor: primaryColor, color: onPrimary),

    // ── Sidebar ───────────────────────────────────────────────────────────
    css('.blog-sidebar').styles(
      display: .flex, flexDirection: .column, gap: Gap.all(1.25.rem),
      raw: {'position': 'sticky', 'top': '5rem'},
    ),

    // Newsletter card
    css('.newsletter-card').styles(
      backgroundColor: primaryContainer,
      radius: BorderRadius.circular(16.px),
      padding: .all(1.5.rem),
      display: .flex, flexDirection: .column, gap: Gap.all(0.75.rem),
    ),
    css('.newsletter-title').styles(fontSize: 17.px, fontWeight: .w700, color: onPrimary),
    css('.newsletter-sub').styles(fontSize: 13.px, color: onPrimary, raw: {'opacity': '0.88', 'line-height': '1.5'}),
    css('.newsletter-input').styles(
      backgroundColor: Color('#ffffff25'),
      radius: BorderRadius.circular(8.px),
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      fontSize: 14.px, color: onPrimary,
      raw: {'border': '1px solid rgba(255,255,255,0.3)', 'outline': 'none',
            'width': '100%', 'box-sizing': 'border-box',
            '::placeholder': 'color: rgba(255,255,255,0.6)'},
    ),
    css('.newsletter-btn').styles(
      backgroundColor: surfaceContainerLowest,
      color: primaryColor,
      fontSize: 13.px, fontWeight: .w700,
      padding: .symmetric(horizontal: 1.rem, vertical: 0.75.rem),
      radius: BorderRadius.circular(8.px),
      textAlign: TextAlign.center,
      cursor: Cursor.pointer,
    ),
    css('.newsletter-note').styles(fontSize: 11.px, color: onPrimary, raw: {'opacity': '0.7'}),

    // Taxonomy card
    css('.taxonomy-card').styles(padding: .all(1.25.rem)),
    css('.taxonomy-title').styles(color: onSurfaceVariant, raw: {'margin-bottom': '0.875rem'}),
    css('.taxonomy-row').styles(
      display: .flex, justifyContent: .spaceBetween, alignItems: .center,
      padding: .symmetric(vertical: 0.5.rem),
      raw: {'border-bottom': '1px solid ${outlineVariant.value}'},
    ),
    css('.taxonomy-row:last-child').styles(raw: {'border-bottom': 'none'}),
    css('.taxonomy-label').styles(color: onSurface),
    css('.taxonomy-count').styles(
      color: primaryColor,
      backgroundColor: primaryFixed,
      padding: .symmetric(horizontal: 0.5.rem, vertical: 0.125.rem),
      radius: BorderRadius.circular(4.px),
    ),

    // Author card
    css('.author-card').styles(
      padding: .all(1.25.rem),
      display: .flex, alignItems: .center, gap: Gap.all(0.75.rem),
    ),
    css('.author-avatar').styles(
      width: 44.px, height: 44.px,
      radius: BorderRadius.circular(99.px),
      backgroundColor: primaryContainer, color: onPrimary,
      display: .flex, alignItems: .center, justifyContent: .center,
      fontSize: 14.px, fontWeight: .w700,
      raw: {'flex-shrink': '0'},
    ),
    css('.author-name').styles(fontSize: 14.px, fontWeight: .w700, color: onSurface),
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

// ── Featured article card ─────────────────────────────────────────────────────
class _FeaturedArticleCard extends StatelessComponent {
  const _FeaturedArticleCard({required this.article});
  final BlogArticle article;

  @override
  Component build(BuildContext context) {
    return div(classes: 'featured-card', [
      div(classes: 'featured-image',
          styles: Styles(backgroundColor: Color(article.imageColor)), [
        span(classes: 'material-symbols-outlined',
            styles: Styles(fontSize: 48.px, color: primaryColor), [.text('article')]),
      ]),
      div(classes: 'featured-content', [
        div(classes: 'article-meta', [
          span(classes: 'article-category', [.text(article.category)]),
          span(classes: 'article-readtime', [.text(article.readMin)]),
        ]),
        p(classes: 'article-title', [.text(article.title)]),
        p(classes: 'article-excerpt', [.text(article.excerpt)]),
        a(href: article.href, classes: 'article-read-link', [
          .text('Read Article'),
          span(classes: 'material-symbols-outlined', [.text('arrow_forward')]),
        ]),
      ]),
    ]);
  }
}

// ── Standard article card ─────────────────────────────────────────────────────
class _ArticleCard extends StatelessComponent {
  const _ArticleCard({required this.article});
  final BlogArticle article;

  @override
  Component build(BuildContext context) {
    return div(classes: 'article-card', [
      div(classes: 'article-card-image',
          styles: Styles(backgroundColor: Color(article.imageColor)), [
        span(classes: 'material-symbols-outlined',
            styles: Styles(fontSize: 32.px, color: primaryColor), [.text('article')]),
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

// ── Newsletter card ───────────────────────────────────────────────────────────
class _NewsletterCard extends StatelessComponent {
  const _NewsletterCard();

  @override
  Component build(BuildContext context) {
    return div(classes: 'newsletter-card', [
      p(classes: 'newsletter-title', [.text("The Flutter Engineer's Log")]),
      p(classes: 'newsletter-sub', [
        .text('Bi-weekly deep dives into Flutter architecture and mobile performance. '
              'No fluff — just code and patterns.'),
      ]),
      input(
        type: InputType.email,
        classes: 'newsletter-input',
        attributes: {'placeholder': 'email@example.com'},
      ),
      div(classes: 'newsletter-btn', [.text('Subscribe Now')]),
      p(classes: 'newsletter-note', [.text('Join 2,000+ Flutter engineers. Opt-out anytime.')]),
    ]);
  }
}
