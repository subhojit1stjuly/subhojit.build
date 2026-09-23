import 'dart:convert';

import 'package:subhojit_build/core/constants/constants.dart';
import 'package:subhojit_build/pages/project/domain/entities/project_post.dart';

class ProjectDocModel extends ProjectPost {
  ProjectDocModel({
    required super.category,
    required super.readMin,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.href,
    super.repoUrl,
    super.liveUrl,
    required super.imageColor,
    required super.featured,
    required super.tags,
  });

  factory ProjectDocModel.fromMap(Map<String, dynamic> map) {
    return ProjectDocModel(
      category: map['category'],
      readMin: map['readMin'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      href: map['href'],
      repoUrl: map['repoUrl'] as String?,
      liveUrl: map['liveUrl'] as String?,
      imageColor: Constants.parseProjectColor(map['imageColor'] as String?),
      featured: map['featured'],
      tags: List<String>.from(jsonDecode(map['tags'])),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'readMin': readMin,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'href': href,
      'repoUrl': repoUrl,
      'liveUrl': liveUrl,
      'imageColor': imageColor,
      'featured': featured,
      'tags': tags,
    };
  }
}
