import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:subhojit_build/core/constants/route_constants.dart';
import 'package:subhojit_build/core/constants/string_constants.dart';
import 'package:subhojit_build/pages/blog/model/blog_article.dart';
import 'package:subhojit_build/pages/career/models/certification.dart';
import 'package:subhojit_build/pages/career/models/job_experience.dart';
import 'package:subhojit_build/pages/project/models/project_doc.dart';
import 'package:subhojit_build/pages/project/project.dart';
import 'package:subhojit_build/shared/components/page_shell.dart';

import 'shared/components/footer.dart';
import 'pages/blog/blog.dart';
import 'pages/career/career.dart';
import 'pages/portfolio/home.dart';

/// Root application component.
///
/// Uses a [ShellRoute] so the [Navbar] and [Footer] are shared across all three
/// pages without re-mounting. Child pages are swapped in via SPA navigation.
///
/// SSG generates three static HTML files:
///   /index.html          → Portfolio home
///   /career/index.html   → Career & Experience
///   /blog/index.html     → Technical Insights / Blog
class App extends StatelessComponent {
  final List<List<RouteBase>> contentRoutes; // Injected from ContentApp.custom
  final List<BlogArticle> blogList;
  final List<JobExperience> jobs;
  final List<Certification> certificates;
  final List<ProjectDoc> projects;
  const App({
    super.key,
    required this.contentRoutes,
    required this.blogList,
    required this.jobs,
    required this.certificates,
    required this.projects,
  });

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        ShellRoute(
          builder: (context, state, child) => PageShell(child: child),
          routes: [
            Route(
              path: RouteConstants.portfolio,
              title: StringConstants.portfolioTitle,
              builder: (context, state) => Home(
                projects: projects,
              ),
            ),
            Route(
              path: RouteConstants.career,
              title: StringConstants.careerTitle,
              builder: (context, state) => CareerPage(
                jobs: jobs,
                certificates: certificates,
              ),
            ),
            Route(
              path: RouteConstants.blogs,
              title: StringConstants.blogTitle,
              builder: (context, state) => BlogPage(
                articles: blogList,
              ),
            ),
            Route(
              path: RouteConstants.projects,
              title: StringConstants.projectTitle,
              builder: (context, state) => ProjectsPage(
                projects: projects,
              ),
            ),
            ...contentRoutes.expand((e) => e), // Injected from ContentApp.custom
          ],
        ),
      ],
    );
  }
}
