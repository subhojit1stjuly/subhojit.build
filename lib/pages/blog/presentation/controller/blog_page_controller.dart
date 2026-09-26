import 'package:injectable/injectable.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/cureent_blogs_usecase.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/filter_blogs_usecase.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/blog_pagination_usecase.dart';
import 'package:subhojit_build/pages/blog/domain/usecases/get_categories_tags_usecase.dart';
import 'package:subhojit_build/pages/blog/presentation/controller/blog_list_state.dart';

@singleton
class BlogPageController extends ValueNotifier<BlogListState> {
  final CurrentBlogsUseCase _currentBlogsUseCase;
  final FilterBlogsUsecase _filterBlogsUseCase;
  final BlogsPaginationUseCase _paginationUseCase;
  final GetCategoriesTagsUseCase _getCategoriesTagsUseCase;

  BlogPageController({
    required CurrentBlogsUseCase currentBlogsUseCase,
    required FilterBlogsUsecase filterBlogsUseCase,
    required BlogsPaginationUseCase paginationUseCase,
    required GetCategoriesTagsUseCase getCategoriesTagsUseCase,
  }) : _paginationUseCase = paginationUseCase,
       _filterBlogsUseCase = filterBlogsUseCase,
       _currentBlogsUseCase = currentBlogsUseCase,
       _getCategoriesTagsUseCase = getCategoriesTagsUseCase,
       super(BlogListState.initial()) {
    /// Clear any existing filters and fetch all blogs initially.
    _getBloggingCategoriesAndTags();
    _clearFilterAndFetchAll();

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

  void _clearFilterAndFetchAll() {
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

  void _getBloggingCategoriesAndTags() {
    final (Map<String, int> categories, Map<String, int> tags) = _getCategoriesTagsUseCase(null);
    value = value.copyWith(
      categories: categories,
      tags: tags,
    );
    notifyListeners();
  }
}
