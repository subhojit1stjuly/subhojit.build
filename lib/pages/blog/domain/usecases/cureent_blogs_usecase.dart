import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';
import 'package:subhojit_build/pages/blog/domain/repositories/blog_posts_repository.dart';

@injectable
class CurrentBlogsUseCase extends StreamedUseCase<(List<BlogPostModel>, int)> {
  final BlogPostsRepository _repository;

  CurrentBlogsUseCase(this._repository);
  @override
  Stream<(List<BlogPostModel>, int)> get() {
    return _repository.currentBlogs();
  }
}
