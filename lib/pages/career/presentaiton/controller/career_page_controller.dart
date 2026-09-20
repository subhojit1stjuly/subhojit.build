import 'package:injectable/injectable.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/pages/career/data/models/certification_model.dart';
import 'package:subhojit_build/pages/career/data/models/job_experience_model.dart';
import 'package:subhojit_build/pages/career/domain/repositories/career_repository.dart';
import 'package:subhojit_build/pages/career/presentaiton/controller/career_page_state.dart';

@singleton
class CareerPageController extends ValueNotifier<CareerPageState> {
  final CareerRepository _repository;

  CareerPageController({
    required CareerRepository repository,
  }) : _repository = repository,
       super(CareerPageState.initial()) {
    List<JobExperienceModel> jobs = _repository.fetchAllJobs();
    List<CertificationModel> certifications = _repository.fetchAllCertifications();
    value = value.copyWith(
      jobs: jobs,
      certifications: certifications,
      isLoading: false,
    );
    notifyListeners();
  }
}
