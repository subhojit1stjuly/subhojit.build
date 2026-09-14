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
  final List<int?> pages;
  final bool isFirstPage;
  final bool isLastPage;
  final int currentPage;
  final void Function(int pageIndex) onPageChanged;

  const PaginationControls({
    required this.pages,
    required this.isFirstPage,
    required this.isLastPage,
    required this.currentPage,
    required this.onPageChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'blog-pagination', [
      // Previous button
      button(
        classes: 'page-btn page-btn--prev${isFirstPage ? ' page-btn--disabled' : ''}',
        disabled: isFirstPage,
        onClick: isFirstPage ? null : () => onPageChanged(currentPage - 1),
        [
          span(classes: 'material-symbols-outlined', [Component.text('chevron_left')]),
        ],
      ),

      // Page numbers
      for (final pageNum in pages)
        if (pageNum == null)
          // Ellipsis
          span(classes: 'page-ellipsis', [.text('...')])
        else
          button(
            classes: pageNum == (currentPage - 1) ? 'page-btn page-btn--active' : 'page-btn',
            onClick: () => onPageChanged(pageNum - 1),
            [Component.text('$pageNum')],
          ),

      // Next button
      button(
        classes: 'page-btn page-btn--next${isLastPage ? ' page-btn--disabled' : ''}',
        disabled: isLastPage,
        onClick: isLastPage ? null : () => onPageChanged(currentPage + 1),
        [
          span(classes: 'material-symbols-outlined', [Component.text('chevron_right')]),
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
