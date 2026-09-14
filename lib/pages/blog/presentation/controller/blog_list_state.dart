import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';

class BlogListState {
  /// currentBlogs holds the list of blog posts for the current page.
  /// which is for the current page only.
  final List<BlogPostModel> currentBlogs;
  final bool isLoading;
  final int currentPageIndex;
  final FilterParams? currentFilter;
  final int totalBlogsCount;

  /// cheks if featuredblog exists.
  bool get _hasFeaturedBlog => currentBlogs.isNotEmpty && currentBlogs.first.featured == true;

  /// The featured blog can be found only at the first position of the current blogs list.
  /// if the BlogPostModel is having featured set to true.
  BlogPostModel? get featuredBlog => currentBlogs.isNotEmpty
      ? _hasFeaturedBlog
            ? currentBlogs.first
            : null
      : null;

  /// The articles to be displayed in the grid, excluding the featured blog.
  List<BlogPostModel> get displayArticles => _hasFeaturedBlog ? currentBlogs.skip(1).toList() : currentBlogs.toList();

  int get totalPages => (totalBlogsCount / Constants.itemsPerPage).ceil();

  /// Generates list of page numbers to display with ellipsis logic.
  ///
  /// Examples:
  /// - Total 5 pages: [1, 2, 3, 4, 5]
  /// - Total 10, current 1: [1, 2, 3, null, 10] (null = ellipsis)
  /// - Total 10, current 5: [1, null, 4, 5, 6, null, 10]
  /// - Total 10, current 10: [1, null, 8, 9, 10]
  /// Returns a list of page numbers with `null` representing ellipsis.
  List<int?> get getPageNumbers {
    if (totalPages <= 7) {
      return List.generate(totalPages, (i) => i + 1);
    }

    final current = currentPageIndex;
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

  BlogListState({
    required this.currentBlogs,
    required this.isLoading,
    required this.currentPageIndex,
    required this.currentFilter,
    required this.totalBlogsCount,
  });
  BlogListState.initial({
    this.currentBlogs = const [],
    this.isLoading = true,
    this.currentPageIndex = 0,
    this.currentFilter,
    this.totalBlogsCount = 0,
  });

  BlogListState copyWith({
    List<BlogPostModel>? currentBlogs,
    bool isLoading = false,
    int? currentPageIndex,
    FilterParams? currentFilter,
    int? totalBlogsCount,
  }) {
    return BlogListState(
      currentBlogs: currentBlogs ?? this.currentBlogs,
      isLoading: isLoading,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      currentFilter: currentFilter ?? this.currentFilter,
      totalBlogsCount: totalBlogsCount ?? this.totalBlogsCount,
    );
  }
}
