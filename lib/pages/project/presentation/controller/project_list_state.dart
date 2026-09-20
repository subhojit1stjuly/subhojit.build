import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/core/utils/filter_params.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

class ProjectListState {
  final List<ProjectDocModel> currentProjects;
  final bool isLoading;
  final FilterParams? currentFilter;
  final int currentPageIndex;
  final int totalProjectsCount;

  int get totalPages => (totalProjectsCount / Constants.itemsPerPage).ceil();

  /// Generates list of page numbers to display with ellipsis logic.
  ///
  /// Examples:
  /// - Total 5 pages: [1, 2, 3, 4, 5]
  /// - Total 10, current 1: [1, 2, 3, null, 10] (null = ellipsis)
  /// - Total 10, current 5: [1, null, 4, 5, 6, null, 10]
  /// - Total 10, current 10: [1, null, 8, 9, 10]
  /// Returns a list of page numbers with `null` representing ellipsis.
  List<int?> get getPageNumbers {
    if (totalPages <= 7) {
      return List.generate(totalPages, (i) => i + 1);
    }

    final current = currentPageIndex;
    final pages = <int?>[];

    // Always show first page
    pages.add(1);

    if (current <= 3) {
      // Near start: 1 2 3 4 ... 10
      pages.addAll([2, 3, 4, null, totalPages]);
    } else if (current >= totalPages - 2) {
      // Near end: 1 ... 7 8 9 10
      pages.addAll([
        null,
        totalPages - 3,
        totalPages - 2,
        totalPages - 1,
        totalPages,
      ]);
    } else {
      // Middle: 1 ... 5 6 7 ... 10
      pages.addAll([
        null,
        current - 1,
        current,
        current + 1,
        null,
        totalPages,
      ]);
    }

    return pages;
  }

  const ProjectListState({
    required this.currentProjects,
    required this.isLoading,
    this.currentFilter,
    required this.currentPageIndex,
    required this.totalProjectsCount,
  });

  ProjectListState.initial({
    this.currentProjects = const [],
    this.isLoading = true,
    this.currentFilter,
    this.currentPageIndex = 0,
    this.totalProjectsCount = 0,
  });

  ProjectListState copyWith({
    List<ProjectDocModel>? currentProjects,
    bool isLoading = false,
    FilterParams? currentFilter,
    int? currentPageIndex,
    int? totalProjectsCount,
  }) {
    return ProjectListState(
      currentProjects: currentProjects ?? this.currentProjects,
      isLoading: isLoading,
      currentFilter: currentFilter ?? this.currentFilter,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      totalProjectsCount: totalProjectsCount ?? this.totalProjectsCount,
    );
  }
}
