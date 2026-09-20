import 'package:injectable/injectable.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:subhojit_build/pages/portfolio/presentation/controller/home_page_state.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

@singleton
class HomePageController extends ValueNotifier<HomePageState> {
  final PortfolioRepository _repository;

  HomePageController({
    required PortfolioRepository repository,
  }) : _repository = repository,
       super(HomePageState.initial()) {
    List<ProjectDocModel> featuredProjects = List.from(_repository.fetchFeatured());
    value = value.copyWith(
      featuredProjects: featuredProjects,
      isLoading: false,
    );
    notifyListeners();
  }
}
