import 'dart:io';
import 'package:subhojit_build/pages/career/models/certification.dart';
import 'package:subhojit_build/pages/career/models/job_experience.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';
import 'package:yaml/yaml.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';

//TODO(Subhojit): Simplify this service to use a single generic method for reading
//markdown files and parsing frontmatter, instead of having separate methods
//for blogs, projects, careers, and certifications.
class ContentService {
  static Future<List<BlogArticle>> getBlogsAsync() async {
    final dir = Directory('content/blogs');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      // Load and convert YamlMap to Map<String, dynamic>
      final yamlData = loadYaml(parts[1]);
      final frontmatter = Map<String, dynamic>.from(yamlData);

      final slug = file.path.split('/').last.replaceAll('.md', '');

      return BlogArticle.fromMap(frontmatter, slug);
    }).toList();
  }

  /// Fetches and parses all project markdown files from content/projects/
  static Future<List<ProjectDoc>> getProjectsAsync() async {
    final dir = Directory('content/projects');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      // Load and convert YamlMap to Map<String, dynamic>
      final yamlData = loadYaml(parts[1]);
      final frontmatter = Map<String, dynamic>.from(yamlData);

      final slug = file.path.split('/').last.replaceAll('.md', '');

      return ProjectDoc.fromMap(frontmatter, slug);
    }).toList();
  }

  /// Fetches and parses career experience files from content/career/
  static Future<List<JobExperience>> getCareersAsync() async {
    final dir = Directory('content/career');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      // Load and convert YamlMap to Map<String, dynamic>
      final yamlData = loadYaml(parts[1]);
      final frontmatter = Map<String, dynamic>.from(yamlData);

      final slug = file.path.split('/').last.replaceAll('.md', '');

      return JobExperience.fromMap(frontmatter, slug);
    }).toList();
  }

  static Future<List<Certification>> getCertificationsAsync() async {
    final dir = Directory('content/certifications');
    if (!dir.existsSync()) return [];

    return dir.listSync().where((f) => f.path.endsWith('.md')).map((file) {
      final content = File(file.path).readAsStringSync();

      // Split the frontmatter (starts and ends with ---)
      final parts = content.split('---');
      // Load and convert YamlMap to Map<String, dynamic>
      final yamlData = loadYaml(parts[1]);
      final frontmatter = Map<String, dynamic>.from(yamlData);

      final slug = file.path.split('/').last.replaceAll('.md', '');

      return Certification.fromMap(frontmatter, slug);
    }).toList();
  }
}
