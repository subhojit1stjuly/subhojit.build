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
    return div(classes: 'pagination', [
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
            classes: 'page-btn ${pageNum != (currentPage + 1) ? 'page-btn page-btn--active' : ''}',
            disabled: pageNum != (currentPage + 1),
            onClick: () => pageNum != (currentPage + 1) ? onPageChanged(pageNum - 1) : null,
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
    // ── Pagination ────────────────────────────────────────────────────────
    css('.pagination').styles(
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
