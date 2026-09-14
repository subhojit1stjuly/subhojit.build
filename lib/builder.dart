import 'dart:async';
import 'dart:convert';
import 'package:build/build.dart';
import 'package:glob/glob.dart';

Builder generateMetaBuilder(BuilderOptions options) => GenerateMetaBuilder();

class GenerateMetaBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    'content/posts.cfg': ['lib/generated/meta.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final glob = Glob('content/**.md');
    final assets = await buildStep.findAssets(glob).toList();

    // Group post metadata by top-level folder name (blogs, projects, etc.).
    final Map<String, List<Map<String, dynamic>>> folderGroups = {};
    for (final asset in assets) {
      final content = await buildStep.readAsString(asset);

      final relativePath = asset.path.replaceFirst('content/', '');
      final pathSegments = relativePath.split('/');

      final folder = pathSegments.length > 1 ? pathSegments.first : 'general';
      final slug = relativePath.replaceAll('.md', '');
      final isFeatured = relativePath.contains('featured/');

      final frontmatter = _parseFrontmatter(content);
      frontmatter['featured'] = isFeatured;
      frontmatter['href'] = slug;

      folderGroups.putIfAbsent(folder, () => []).add(frontmatter);
    }

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

    folderGroups.forEach((folderName, items) {
      final validVarName = folderName.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
      final encodedItems = items.map((item) => jsonEncode(item)).join(',\n  ');

      buffer.writeln('const List<Map<String, dynamic>> $validVarName = [');
      buffer.writeln('  $encodedItems');
      buffer.writeln('];\n');
    });

    final outputId = buildStep.allowedOutputs.single;
    await buildStep.writeAsString(outputId, buffer.toString());
  }

  int _estimatedReadTimeMinutes(String fileContent) {
    final wordCount = fileContent.split(RegExp(r'\s+')).length;
    final minutes = (wordCount / 200).ceil();
    return minutes < 1 ? 1 : minutes;
  }

  Map<String, dynamic> _parseFrontmatter(String fileContent) {
    final Map<String, dynamic> frontmatter = {};

    if (!fileContent.startsWith('---')) {
      return {};
    }

    // Find the end of the frontmatter block (the second '---')
    // We skip index 3 to bypass the opening '---'
    final secondDashIndex = fileContent.indexOf('---', 3);
    if (secondDashIndex == -1) {
      return {};
    }

    final frontmatterBlock = fileContent.substring(3, secondDashIndex);
    final body = fileContent.substring(secondDashIndex + 3).trim();
    final readMin = _estimatedReadTimeMinutes(body);

    for (var line in frontmatterBlock.split('\n')) {
      final colonIndex = line.indexOf(':');
      if (colonIndex != -1) {
        final key = line.substring(0, colonIndex).trim();
        final value = line.substring(colonIndex + 1).trim().replaceAll(RegExp("^[\"']|[\"']\$"), '');
        frontmatter[key] = value;
      }
    }
    frontmatter['readMin'] = readMin.toString();

    return frontmatter;
  }
}
