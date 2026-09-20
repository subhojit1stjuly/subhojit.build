import 'package:injectable/injectable.dart';
import 'package:subhojit_build/pages/career/data/datasources/career_local_datasource.dart';
import 'package:subhojit_build/pages/career/data/models/certification_model.dart';
import 'package:subhojit_build/pages/career/data/models/job_experience_model.dart';
import 'package:subhojit_build/pages/career/domain/repositories/career_repository.dart';

@Injectable(as: CareerRepository)
class CareerRepositoryImpl implements CareerRepository {
  final CareerLocalDatasource _datasource;

  CareerRepositoryImpl({required CareerLocalDatasource datasource}) : _datasource = datasource;

  @override
  List<JobExperienceModel> fetchAllJobs() {
    return _datasource.fetchAllJobs();
  }

  @override
  List<CertificationModel> fetchAllCertifications() {
    return _datasource.fetchAllCertifications();
  }
}
