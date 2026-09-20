import 'package:injectable/injectable.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/project/domain/usecases/current_projects_usecase.dart';
import 'package:subhojit_build/pages/project/domain/usecases/filter_projects_usecase.dart';
import 'package:subhojit_build/pages/project/domain/usecases/project_pagination_usecase.dart';
import 'package:subhojit_build/pages/project/presentation/controller/project_list_state.dart';

@singleton
class ProjectPageController extends ValueNotifier<ProjectListState> {
  final CurrentProjectsUseCase _currentProjectsUseCase;
  final FilterProjectsUseCase _filterProjectsUseCase;
  final ProjectPaginationUseCase _paginationUseCase;

  ProjectPageController({
    required CurrentProjectsUseCase currentProjectsUseCase,
    required FilterProjectsUseCase filterProjectsUseCase,
    required ProjectPaginationUseCase paginationUseCase,
  }) : _paginationUseCase = paginationUseCase,
       _currentProjectsUseCase = currentProjectsUseCase,
       _filterProjectsUseCase = filterProjectsUseCase,
       super(ProjectListState.initial()) {
    clearFilterAndFetchAll();

    _currentProjectsUseCase.get().listen((data) {
      value = value.copyWith(
        currentProjects: data.$1,
        totalProjectsCount: data.$2,
        isLoading: false,
      );
      notifyListeners();
    });
  }

  void clearFilterAndFetchAll() {
    _filterProjectsUseCase.call(null);
  }

  void filterByCategory(String? category) {
    if (category == null) {
      clearFilterAndFetchAll();
      return;
    }
    value = value.copyWith(isLoading: true);
    notifyListeners();
    _filterProjectsUseCase.call(value.currentFilter?.copyWith(category: category));
  }

  void toPage(int pageIndex) {
    print('pageIndex: $pageIndex');
    _applyLoadingState(
      isLoading: true,
      pageIndex: pageIndex,
    );
    _paginationUseCase.call(pageIndex);
  }

  void _applyLoadingState({required bool isLoading, int? pageIndex}) {
    value = value.copyWith(
      isLoading: isLoading,
      currentPageIndex: pageIndex,
    );
    notifyListeners();
  }
}
