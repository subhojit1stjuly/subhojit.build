import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:subhojit_build/generated/meta.g.dart';
import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

const _featuredCount = 3;

@lazySingleton
final class FeaturedProjectsDatasource {
  FeaturedProjectsDatasource();

  final List<ProjectDocModel> _allFeatured = List.from(projects)
      .where((json) => json['featured'] == true)
      .take(_featuredCount)
      .map((json) => ProjectDocModel.fromMap(json))
      .toList();

  List<ProjectDocModel> fetch() {
    return _allFeatured;
  }
}
