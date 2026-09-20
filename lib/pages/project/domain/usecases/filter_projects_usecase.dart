import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/project/domain/repositories/projects_repository.dart';

@injectable
class FilterProjectsUseCase extends SyncUseCase<void, FilterParams?> {
  final ProjectsRepository _repository;

  FilterProjectsUseCase(this._repository);

  @override
  void call(FilterParams? params) {
    if (params == null) {
      _repository.clearFilter();
      return;
    }
    _repository.applyFilter(params);
  }
}
