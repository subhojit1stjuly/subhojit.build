import 'package:subhojit_build/pages/project/data/models/prodec_doc_model.dart';

class HomePageState {
  final List<ProjectDocModel> featuredProjects;
  final bool isLoading;

  const HomePageState({
    required this.featuredProjects,
    required this.isLoading,
  });

  HomePageState.initial({
    this.featuredProjects = const [],
    this.isLoading = true,
  });

  HomePageState copyWith({
    List<ProjectDocModel>? featuredProjects,
    bool isLoading = false,
  }) {
    return HomePageState(
      featuredProjects: featuredProjects ?? this.featuredProjects,
      isLoading: isLoading,
    );
  }
}
