import 'dart:io';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';
import 'package:yaml/yaml.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

class ContentService {
  static Future<List<BlogArticle>> getBlogsAsync() async {
    final dir = Directory('content/blogs');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      final frontmatter = loadYaml(parts[1]); // Requires 'yaml' package

      return BlogArticle(
        title: frontmatter['title'] ?? 'Untitled',
        category: frontmatter['category'] ?? 'General',
        excerpt: frontmatter['excerpt'] ?? '',
        readMin: frontmatter['readMin'] ?? '5 min read',
        href: '/blogs/${file.path.split('/').last.replaceAll('.md', '')}',
        imageColor: secondaryContainer,
        featured: frontmatter['featured'] ?? false,
      );
    }).toList();
  }

  static Future<List<ProjectDocs>> getProjectsAsync() async {
    final dir = Directory('content/projects');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      final frontmatter = loadYaml(parts[1]); // Requires 'yaml' package

      return ProjectDocs(
        title: frontmatter['title'] ?? 'Untitled',
        category: frontmatter['category'] ?? 'General',
        excerpt: frontmatter['excerpt'] ?? '',
        readMin: frontmatter['readMin'] ?? '5 min read',
        href: '/projects/${file.path.split('/').last.replaceAll('.md', '')}',
        imageColor: secondaryContainer,
        featured: frontmatter['featured'] ?? false,
      );
    }).toList();
  }
}
