import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/pages/blog/data/model/blog_post_model.dart';

class DummyData {
  /// Exported for jaspr_content MemoryLoader in main.server.dart.
  /// These hardcoded articles serve as fallback during infrastructure validation.
  static final hardcodedArticles = [
    BlogPostModel(
      category: 'Architecture',
      readMin: '12 min read',
      title: 'Clean Architecture in Flutter: A Production Guide',
      description:
          'How to structure large Flutter apps with Clean Architecture so '
          'your codebase stays maintainable as the team and feature-set grow.',
      href: '#',
      featured: true,
      imageColor: secondaryContainer,
      imageUrl: '',
      tags: ['flutter', 'architecture', 'clean architecture'],
      date: DateTime.now(),
    ),
    BlogPostModel(
      category: 'Performance',
      readMin: '8 min read',
      title: 'The P99 Problem: Solving Tail Latency in Flutter',
      description:
          'Why averages lie and how to hunt down the microscopic jank that '
          'degrades perceived smoothness — even when 95% of frames hit 60fps.',
      href: '#',
      imageColor: primaryFixed,
      imageUrl: '',
      tags: ['flutter', 'architecture', 'clean architecture'],
      date: DateTime.now(),
      featured: false,
    ),
    BlogPostModel(
      category: 'State Management',
      readMin: '10 min read',
      title: 'Riverpod 3 vs Bloc: When to Use Which',
      description:
          'A pragmatic comparison of the two dominant state management '
          'solutions in Flutter, with real-world trade-off examples.',
      href: '#',
      imageColor: surfaceContainer,
      imageUrl: '',
      tags: ['flutter', 'architecture', 'clean architecture'],
      date: DateTime.now(),
      featured: false,
    ),
    BlogPostModel(
      category: 'DevOps',
      readMin: '15 min read',
      title: 'Automating Flutter Releases with GitHub Actions',
      description:
          'End-to-end CI/CD pipeline: build, test, sign, and ship to '
          'both Play Store and App Store in a single workflow file.',
      href: '#',
      imageColor: secondaryContainer,
      imageUrl: '',
      tags: ['flutter', 'architecture', 'clean architecture'],
      date: DateTime.now(),
      featured: false,
    ),
    BlogPostModel(
      category: 'Architecture',
      readMin: '9 min read',
      title: 'Offline-First Flutter with CRDTs',
      description:
          'Implementing conflict-free replicated data types to give your '
          'app seamless offline sync that just works, even with multiple devices.',
      href: '#',
      imageColor: primaryFixed,
      imageUrl: '',
      tags: ['flutter', 'architecture', 'clean architecture'],
      date: DateTime.now(),
      featured: false,
    ),
  ];
}
