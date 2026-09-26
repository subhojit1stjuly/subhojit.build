import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/blog/domain/repositories/blog_posts_repository.dart';

@injectable
class GetCategoriesTagsUseCase
    extends
        SyncUseCase<
          (
            Map<String, int> categories,
            Map<String, int> tags,
          ),
          void
        > {
  final BlogPostsRepository _blogRepository;

  GetCategoriesTagsUseCase(this._blogRepository);
  @override
  (
    Map<String, int> categories,
    Map<String, int> tags,
  )
  call(_) {
    return (
      _blogRepository.getCategories(),
      _blogRepository.getTags(),
    );
  }
}
