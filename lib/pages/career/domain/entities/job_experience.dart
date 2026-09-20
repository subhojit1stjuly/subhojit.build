import 'package:subhojit_build/core/utils/json_datasource.dart';

abstract class JobExperience extends JsonSerializable {
  final String title, company, period, location, description, readMin, href;
  final List<String> highlights;
  final bool current;
  final bool featured;

  const JobExperience({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    required this.readMin,
    required this.href,
    this.highlights = const [],
    this.current = false,
    this.featured = false,
  });
}
