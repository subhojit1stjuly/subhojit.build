import 'package:injectable/injectable.dart';
import 'package:subhojit_build/pages/portfolio/data/datasources/featured_projects_datasource.dart';
import 'package:subhojit_build/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

@Injectable(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final FeaturedProjectsDatasource _datasource;

  PortfolioRepositoryImpl({required FeaturedProjectsDatasource datasource}) : _datasource = datasource;

  @override
  List<ProjectDocModel> fetchFeatured() {
    return _datasource.fetch();
  }
}
