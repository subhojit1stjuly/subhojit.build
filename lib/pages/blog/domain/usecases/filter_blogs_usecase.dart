import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/blog/domain/repositories/blog_posts_repository.dart';

@injectable
class FilterBlogsUsecase extends SyncUseCase<void, FilterParams?> {
  final BlogPostsRepository _blogRepository;

  FilterBlogsUsecase(this._blogRepository);
  @override
  void call(FilterParams? params) {
    if (params == null) {
      _blogRepository.clearFilter();
      return;
    }
    _blogRepository.applyFilter(params);
  }
}
