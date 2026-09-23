import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/project/domain/repositories/projects_repository.dart';

@injectable
class ProjectPaginationUseCase extends SyncUseCase<void, int> {
  final ProjectsRepository _repository;

  ProjectPaginationUseCase(this._repository);
  @override
  void call(int params) {
    _repository.paginate(params);
  }
}
