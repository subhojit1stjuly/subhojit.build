import 'package:injectable/injectable.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/cureent_blogs_usecase.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/filter_blogs_usecase.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/pagination_usecase.dart';
import 'package:subhojit_build/pages/blog/presentation/controller/blog_list_state.dart';

@singleton
class BlogPageController extends ValueNotifier<BlogListState> {
  final CurrentBlogsUseCase _currentBlogsUseCase;
  final FilterBlogsUsecase _filterBlogsUseCase;
  final PaginationUseCase _paginationUseCase;

  BlogPageController({
    required CurrentBlogsUseCase currentBlogsUseCase,
    required FilterBlogsUsecase filterBlogsUseCase,
    required PaginationUseCase paginationUseCase,
  }) : _paginationUseCase = paginationUseCase,
       _filterBlogsUseCase = filterBlogsUseCase,
       _currentBlogsUseCase = currentBlogsUseCase,
       super(BlogListState.initial()) {
    /// Clear any existing filters and fetch all blogs initially.
    clearFilterAndFetchAll();

    /// Listen to the current blogs stream and update the state accordingly.
    _currentBlogsUseCase.get().listen((data) {
      value = value.copyWith(
        currentBlogs: data.$1,
        isLoading: false,
        totalBlogsCount: data.$2,
      );
      notifyListeners();
    });
  }

  void clearFilterAndFetchAll() {
    _filterBlogsUseCase.call(null);
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
