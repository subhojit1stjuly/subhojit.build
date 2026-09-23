import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/blog/data/datasources/blog_post_local_datasource.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';
import 'package:subhojit_build/pages/blog/domain/repositories/blog_posts_repository.dart';

@Injectable(as: BlogPostsRepository)
class BlogPostsRepositoryImpl implements BlogPostsRepository {
  final BlogPostJsonDatasource _datasource;

  BlogPostsRepositoryImpl({
    required BlogPostJsonDatasource datasource,
  }) : _datasource = datasource;
  @override
  Stream<(List<BlogPostModel>, int)> currentBlogs() {
    return _datasource.currentBlogs;
  }

  @override
  void applyFilter(FilterParams filter) {
    // TODO: implement applyFilter
    throw UnimplementedError();
  }

  @override
  void clearFilter() {
    _datasource.fetchCurrentBlogs(
      pageIndex: 0,
      itemsPerPage: Constants.itemsPerPage,
    );
  }

  @override
  void paginate(int page) {
    _datasource.fetchCurrentBlogs(
      pageIndex: page,
      itemsPerPage: Constants.itemsPerPage,
    );
  }
}
