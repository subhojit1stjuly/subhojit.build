import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

abstract class ProjectsRepository {
  /// Returns a stream of the current list of projects, reflecting any applied filters.
  Stream<(List<ProjectDocModel>, int)> currentProjects();

  /// Applies search, sorting, or filtering criteria.
  void applyFilter(FilterParams filter);

  /// Clears any applied filters and resets to all projects.
  void clearFilter();

  /// Paginates the list of blog posts based on the current filter and pagination settings.
  void paginate(int page);
}
