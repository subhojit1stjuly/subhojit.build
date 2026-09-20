import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/utils/json_datasource.dart';
import 'package:subhojit_build/generated/meta.g.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

@lazySingleton
final class ProjectLocalDatasource extends JsonDatasource<ProjectDocModel> {
  ProjectLocalDatasource();

  @override
  final List<ProjectDocModel> allData = List.from(projects).map((json) => ProjectDocModel.fromMap(json)).toList();

  final StreamController<(List<ProjectDocModel>, int)> _currentProjects =
      StreamController<(List<ProjectDocModel>, int)>();

  /// A stream that emits the current list of projects.
  Stream<(List<ProjectDocModel>, int)> get currentProjects => _currentProjects.stream;

  void _updateCurrentProjects(List<ProjectDocModel> data, int totalCounts) {
    _currentProjects.add((data, data.length));
  }

  /// Fetches the current list of blog posts based on the provided page index and items per page.
  /// This method applies pagination to the allData list and updates the currentBlogs stream.
  ///TODO: Consider adding filtering logic here if needed in the future.
  void fetchProjects({
    int pageIndex = 0,
    int itemsPerPage = Constants.itemsPerPage,
    String? category,
  }) {
    final filtered = category == null ? allData : allData.where((p) => p.category == category).toList();
    final start = pageIndex * itemsPerPage;
    final end = start + itemsPerPage;
    final paginatedProjects = filtered.sublist(
      start,
      end > allData.length ? allData.length : end,
    );

    /// currently the total count is simply the length of allData.
    /// This may change in the future if filtering is applied.
    _updateCurrentProjects(paginatedProjects, filtered.length);
  }

  void dispose() {
    _currentProjects.close();
  }
}
