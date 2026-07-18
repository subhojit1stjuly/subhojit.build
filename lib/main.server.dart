/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/server.dart';

// Imports the [App] component.
import 'app.dart';
// Import theme configuration
import 'constants/theme.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  //
  // Theme CSS variables from appTheme.styles are injected first, followed by
  // global Lumina styles from theme.dart styles getter.
  runApp(
    Document(
      title: 'Subhojit Pramanik — Senior Software Engineer',
      styles: [
        ...appTheme.styles,  // Theme CSS variables (:root with --tokens)
        ...styles,            // Global Lumina styles (typography, utilities, etc.)
      ],
      body: App(),
    ),
  );
}
