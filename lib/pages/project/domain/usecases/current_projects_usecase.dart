import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/usecase.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';
import 'package:subhojit_build/pages/project/domain/repositories/projects_repository.dart';

@injectable
class CurrentProjectsUseCase extends StreamedUseCase<(List<ProjectDocModel>, int)> {
  final ProjectsRepository _repository;

  CurrentProjectsUseCase(this._repository);

  @override
  Stream<(List<ProjectDocModel>, int)> get() {
    return _repository.currentProjects();
  }
}
