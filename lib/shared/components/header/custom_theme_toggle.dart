import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:subhojit_build/core/theme/colors.dart';
import 'package:subhojit_build/core/utils/theme_storage.dart' as theme_storage;

@client
class CustomThemeToggle extends StatelessComponent {
  const CustomThemeToggle({super.key});

  void _toggle() {
    final currentTheme = !theme_storage.isDarkTheme();
    final newThemeMode = currentTheme ? 'dark' : 'light';

    theme_storage.setTheme(newThemeMode);
  }

  @override
  Component build(BuildContext context) {
    return button(
      attributes: {
        'aria-label': 'Toggle theme',
        'type': 'button',
      },
      onClick: _toggle,
      classes: 'theme-toggle-btn',
      [
        span(
          classes: 'theme-toggle__icon theme-toggle__icon--sun material-symbols-outlined',
          [.text('light_mode')],
        ),
        span(
          classes: 'theme-toggle__icon theme-toggle__icon--moon material-symbols-outlined',
          [.text('dark_mode')],
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.theme-toggle-btn').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      border: Border.none,
      radius: BorderRadius.circular(99.px),
      cursor: Cursor.pointer,
      transition: Transition('background-color', duration: Duration(milliseconds: 150)),
      justifyContent: .center,
      alignItems: .center,
      color: onSurfaceVariant,
      backgroundColor: Color('#00000000'),
    ),
    css('.theme-toggle-btn:hover').styles(
      backgroundColor: surfaceContainerHigh,
    ),

    // Default (Light Mode): Show Sun, Hide Moon
    css('.theme-toggle__icon.theme-toggle__icon--sun').styles(display: .block),
    css('.theme-toggle__icon.theme-toggle__icon--moon').styles(display: .none),

    // Dark Mode: Show Moon, Hide Sun
    css('[data-theme="dark"] .theme-toggle__icon.theme-toggle__icon--sun').styles(display: .none),
    css('[data-theme="dark"] .theme-toggle__icon.theme-toggle__icon--moon').styles(display: .block),
  ];
}
