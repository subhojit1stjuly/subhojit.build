import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';

abstract class BlogPostsRepository {
  /// Returns a stream of the current list of blog posts,
  /// reflecting any applied filters.
  Stream<(List<BlogPostModel>, int)> currentBlogs();

  /// This method will be used for search, sorting, and filtering of blog posts.
  void applyFilter(FilterParams filter);

  /// Clears any applied search, sorting, or filtering criteria.
  void clearFilter();

  /// Paginates the list of blog posts based on the current filter and pagination settings.
  void paginate(int page);
}
