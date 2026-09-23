import 'package:subhojit_build/pages/career/data/models/certification_model.dart';
import 'package:subhojit_build/pages/career/data/models/job_experience_model.dart';

abstract class CareerRepository {
  /// Fetches all job experiences.
  List<JobExperienceModel> fetchAllJobs();

  /// Fetches all certifications.
  List<CertificationModel> fetchAllCertifications();
}
