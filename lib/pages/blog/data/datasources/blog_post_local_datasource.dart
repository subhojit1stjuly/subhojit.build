import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/json_datasource.dart';
import 'package:subhojit_build/generated/meta.g.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';

@lazySingleton
final class BlogPostJsonDatasource extends JsonDatasource<BlogPostModel> {
  BlogPostJsonDatasource();
  @override
  final List<BlogPostModel> allData = List.from(blogs).map((json) => BlogPostModel.fromMap(json)).toList();

  final StreamController<(List<BlogPostModel>, int)> _currentBlogs = StreamController<(List<BlogPostModel>, int)>();

  /// A stream that emits the current list of blog posts(with pagination applied)
  /// along with the total count including the featured blog.
  /// the total count is based on the filters applied.
  Stream<(List<BlogPostModel>, int)> get currentBlogs => _currentBlogs.stream;

  /// Updates the current list of blog posts along with the total count.
  void _updateCurrentBlogs(List<BlogPostModel> blogs, int totalCount) {
    _currentBlogs.add((blogs, totalCount));
  }

  /// Fetches the current list of blog posts based on the provided page index and items per page.
  /// This method applies pagination to the allData list and updates the currentBlogs stream.
  ///TODO: Consider adding filtering logic here if needed in the future.
  void fetchCurrentBlogs({required int pageIndex, required int itemsPerPage}) {
    final start = pageIndex * itemsPerPage;
    final end = start + itemsPerPage;
    final paginatedBlogs = allData.sublist(
      start,
      end > allData.length ? allData.length : end,
    );

    /// currently the total count is simply the length of allData.
    /// This may change in the future if filtering is applied.
    _updateCurrentBlogs(paginatedBlogs, allData.length);
  }

  /// Disposes the stream controller.
  void dispose() {
    _currentBlogs.close();
  }
}
