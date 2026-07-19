/// The entrypoint for the **client** environment.
///
/// The [main] method will only be executed on the client when loading the page.
/// To run code on the server during pre-rendering, check the `main.server.dart` file.
library;

// Client-specific Jaspr import.
import 'package:jaspr/client.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.client.options.dart';

void main() {
  // Initializes the client environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultClientOptions,
  );

  // Starts the app.
  //
  // [ClientApp] automatically loads and renders all components annotated with @client.
  //
  // Theme hydration happens automatically through jaspr_content's ThemeToggle component,
  // which is a @client component. The ContentApp wrapper is only needed on the server
  // side for SSR/SSG pre-rendering (see main.server.dart).
  runApp(
    const ClientApp(),
  );
}
