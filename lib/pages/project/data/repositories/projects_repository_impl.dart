import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/project/data/datasources/project_local_datasource.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';
import 'package:subhojit_build/pages/project/domain/repositories/projects_repository.dart';

@Injectable(as: ProjectsRepository)
class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectLocalDatasource _datasource;

  ProjectsRepositoryImpl({required ProjectLocalDatasource datasource}) : _datasource = datasource;

  @override
  Stream<(List<ProjectDocModel>, int)> currentProjects() {
    return _datasource.currentProjects;
  }

  @override
  void applyFilter(FilterParams filter) {
    _datasource.fetchProjects(
      category: filter.category,
    );
  }

  @override
  void clearFilter() {
    _datasource.fetchProjects();
  }

  // TODO : in future there might be a single method for applying, clearing, and paginating filters.
  @override
  void paginate(int page) {
    _datasource.fetchProjects(pageIndex: page);
  }
}
