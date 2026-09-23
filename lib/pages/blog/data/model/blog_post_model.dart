import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:subhojit_build/pages/blog/domain/entities/post.dart';

class BlogPostModel extends Post {
  BlogPostModel({
    required super.category,
    required super.readMin, // not present in project
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.href, // this gets auto genarated
    required super.imageColor,
    required super.featured,
    required super.tags,
    required super.date, // this needsto be added in the project
  });
  factory BlogPostModel.fromMap(Map<String, dynamic> map) {
    return BlogPostModel(
      category: map['category'],
      readMin: map['readMin'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      href: map['href'],
      imageColor: Color(map['imageColor']),
      featured: map['featured'],
      tags: List<String>.from(jsonDecode(map['tags'])),
      date: DateTime.parse(map['date']),
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
      'imageColor': imageColor,
      'featured': featured,
      'tags': tags,
      'date': date.toIso8601String(),
    };
  }
}
