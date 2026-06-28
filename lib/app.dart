import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'pages/home.dart';

/// Root application component.
///
/// Uses [Router] so that `jaspr build` (SSG mode) knows to pre-render the `/`
/// route into a static `index.html` file for GitHub Pages hosting.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        Route(
          path: '/',
          title: 'Subhojit Pramanik — Senior Software Engineer',
          builder: (context, state) => const Home(),
        ),
      ],
    );
  }
}
