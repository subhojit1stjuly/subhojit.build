import 'package:subhojit_build/pages/career/data/models/certification_model.dart';
import 'package:subhojit_build/pages/career/data/models/job_experience_model.dart';

class CareerPageState {
  final List<JobExperienceModel> jobs;
  final List<CertificationModel> certifications;
  final bool isLoading;

  const CareerPageState({
    required this.jobs,
    required this.certifications,
    required this.isLoading,
  });

  CareerPageState.initial({
    this.jobs = const [],
    this.certifications = const [],
    this.isLoading = true,
  });

  CareerPageState copyWith({
    List<JobExperienceModel>? jobs,
    List<CertificationModel>? certifications,
    bool isLoading = false,
  }) {
    return CareerPageState(
      jobs: jobs ?? this.jobs,
      certifications: certifications ?? this.certifications,
      isLoading: isLoading,
    );
  }
}
