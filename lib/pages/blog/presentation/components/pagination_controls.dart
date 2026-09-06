import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';

/// Pagination controls presentational component.
///
/// Features:
/// - Page number buttons with active state
/// - Previous/Next navigation
/// - Ellipsis for large page counts (1 ... 5 6 7 ... 20)
/// - Disabled state for prev/next at boundaries
///
/// This is NOT a @client component - it's rendered by the @client BlogPage.
class PaginationControls extends StatelessComponent {
  final int totalPages;
  final int currentPage;
  final void Function(int) onPageChange;

  const PaginationControls({
    required this.totalPages,
    required this.currentPage,
    required this.onPageChange,
    super.key,
  });

  /// Generates list of page numbers to display with ellipsis logic.
  ///
  /// Examples:
  /// - Total 5 pages: [1, 2, 3, 4, 5]
  /// - Total 10, current 1: [1, 2, 3, null, 10] (null = ellipsis)
  /// - Total 10, current 5: [1, null, 4, 5, 6, null, 10]
  /// - Total 10, current 10: [1, null, 8, 9, 10]
  List<int?> _getPageNumbers() {
    if (totalPages <= 7) {
      return List.generate(totalPages, (i) => i + 1);
    }

    final current = currentPage;
    final pages = <int?>[];

    // Always show first page
    pages.add(1);

    if (current <= 3) {
      // Near start: 1 2 3 4 ... 10
      pages.addAll([2, 3, 4, null, totalPages]);
    } else if (current >= totalPages - 2) {
      // Near end: 1 ... 7 8 9 10
      pages.addAll([
        null,
        totalPages - 3,
        totalPages - 2,
        totalPages - 1,
        totalPages,
      ]);
    } else {
      // Middle: 1 ... 5 6 7 ... 10
      pages.addAll([
        null,
        current - 1,
        current,
        current + 1,
        null,
        totalPages,
      ]);
    }

    return pages;
  }

  @override
  Component build(BuildContext context) {
    final pages = _getPageNumbers();
    final isFirstPage = currentPage == 1;
    final isLastPage = currentPage == totalPages;

    return div(classes: 'blog-pagination', [
      // Previous button
      div(
        classes: 'page-btn page-btn--prev${isFirstPage ? ' page-btn--disabled' : ''}',
        events: isFirstPage
            ? {}
            : {
                'click': (e) => onPageChange(currentPage - 1),
              },
        [
          span(classes: 'material-symbols-outlined', [.text('chevron_left')]),
        ],
      ),

      // Page numbers
      for (final pageNum in pages)
        if (pageNum == null)
          // Ellipsis
          span(classes: 'page-ellipsis', [.text('...')])
        else
          div(
            classes: pageNum == currentPage ? 'page-btn page-btn--active' : 'page-btn',
            events: {
              'click': (e) => onPageChange(pageNum),
            },
            [.text('$pageNum')],
          ),

      // Next button
      div(
        classes: 'page-btn page-btn--next${isLastPage ? ' page-btn--disabled' : ''}',
        events: isLastPage
            ? {}
            : {
                'click': (e) => onPageChange(currentPage + 1),
              },
        [
          span(classes: 'material-symbols-outlined', [.text('chevron_right')]),
        ],
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page-btn--disabled').styles(
      opacity: 0.4,
      cursor: Cursor.notAllowed,
      raw: {'pointer-events': 'none'},
    ),
    css('.page-ellipsis').styles(
      display: .flex,
      width: 36.px,
      justifyContent: .center,
      alignItems: .center,
      color: onSurfaceVariant,
      fontSize: 14.px,
    ),
  ];
}
