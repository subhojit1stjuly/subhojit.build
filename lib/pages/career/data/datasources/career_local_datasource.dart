import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:subhojit_build/generated/meta.g.dart';
import 'package:subhojit_build/pages/career/data/models/certification_model.dart';
import 'package:subhojit_build/pages/career/data/models/job_experience_model.dart';

@lazySingleton
final class CareerLocalDatasource {
  CareerLocalDatasource();

  final List<JobExperienceModel> _allJobs = List.from(career).map((json) => JobExperienceModel.fromMap(json)).toList();

  final List<CertificationModel> _allCertifications = List.from(
    certifications,
  ).map((json) => CertificationModel.fromMap(json)).toList();

  List<JobExperienceModel> fetchAllJobs() {
    return _allJobs;
  }

  List<CertificationModel> fetchAllCertifications() {
    return _allCertifications;
  }
}
