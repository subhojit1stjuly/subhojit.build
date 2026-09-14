import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/blog/domain/repositories/blog_posts_repository.dart';

@injectable
class PaginationUseCase extends SyncUseCase<void, int> {
  final BlogPostsRepository _repository;

  PaginationUseCase(this._repository);
  @override
  void call(int params) {
    _repository.paginate(params);
  }
}
