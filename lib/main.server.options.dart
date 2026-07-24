// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart'
    as _code_block_copy_button;
import 'package:jaspr_content/components/_internal/tab_bar.dart' as _tab_bar;
import 'package:jaspr_content/components/_internal/zoomable_image.dart'
    as _zoomable_image;
import 'package:jaspr_content/components/callout.dart' as _callout;
import 'package:jaspr_content/components/code_block.dart' as _code_block;
import 'package:jaspr_content/components/drop_cap.dart' as _drop_cap;
import 'package:jaspr_content/components/file_tree.dart' as _file_tree;
import 'package:jaspr_content/components/image.dart' as _image;
import 'package:jaspr_content/components/post_break.dart' as _post_break;
import 'package:jaspr_content/components/sidebar_toggle_button.dart'
    as _sidebar_toggle_button;
import 'package:jaspr_content/components/tabs.dart' as _tabs;
import 'package:jaspr_content/components/theme_toggle.dart' as _theme_toggle;
import 'package:subhojit_build/core/theme/theme.dart' as _theme;
import 'package:subhojit_build/pages/blog/blog.dart' as _blog;
import 'package:subhojit_build/pages/career/components/career_section.dart'
    as _career_section;
import 'package:subhojit_build/pages/career/components/philosophy_section.dart'
    as _philosophy_section;
import 'package:subhojit_build/pages/career/career.dart' as _career;
import 'package:subhojit_build/pages/portfolio/components/core_expertise_section.dart'
    as _core_expertise_section;
import 'package:subhojit_build/pages/portfolio/components/hero_section.dart'
    as _hero_section;
import 'package:subhojit_build/pages/portfolio/components/projects_section.dart'
    as _projects_section;
import 'package:subhojit_build/pages/project/project.dart' as _project;
import 'package:subhojit_build/shared/components/header/header_component.dart'
    as _header_component;
import 'package:subhojit_build/shared/components/header/top_appbar.dart'
    as _top_appbar;
import 'package:subhojit_build/shared/components/description_card.dart'
    as _description_card;
import 'package:subhojit_build/shared/components/footer.dart' as _footer;
import 'package:subhojit_build/shared/components/page_shell.dart'
    as _page_shell;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _code_block_copy_button.CodeBlockCopyButton:
        ClientTarget<_code_block_copy_button.CodeBlockCopyButton>(
          'jaspr_content:code_block_copy_button',
        ),
    _tab_bar.TabBar: ClientTarget<_tab_bar.TabBar>(
      'jaspr_content:tab_bar',
      params: __tab_barTabBar,
    ),
    _zoomable_image.ZoomableImage: ClientTarget<_zoomable_image.ZoomableImage>(
      'jaspr_content:zoomable_image',
      params: __zoomable_imageZoomableImage,
    ),
    _sidebar_toggle_button.SidebarToggleButton:
        ClientTarget<_sidebar_toggle_button.SidebarToggleButton>(
          'jaspr_content:sidebar_toggle_button',
        ),
    _theme_toggle.ThemeToggle: ClientTarget<_theme_toggle.ThemeToggle>(
      'jaspr_content:theme_toggle',
    ),
  },
  styles: () => [
    ..._theme.styles,
    ..._callout.Callout.styles,
    ..._code_block.CodeBlock.styles,
    ..._drop_cap.DropCap.styles,
    ..._file_tree.FileTree.styles,
    ..._image.Image.styles,
    ..._post_break.PostBreak.styles,
    ..._tabs.Tabs.styles,
    ..._theme_toggle.ThemeToggleState.styles,
    ..._tab_bar.TabBar.styles,
    ..._zoomable_image.ZoomableImage.styles,
    ..._blog.BlogPage.styles,
    ..._career.CareerPage.styles,
    ..._career_section.CareerSection.styles,
    ..._philosophy_section.PhilosophySection.styles,
    ..._core_expertise_section.CoreExpertiseSection.styles,
    ..._hero_section.HeroSection.styles,
    ..._projects_section.ProjectsSection.styles,
    ..._project.ProjectsPage.styles,
    ..._description_card.DescriptionCard.styles,
    ..._footer.Footer.styles,
    ..._page_shell.PageShell.styles,
    ..._header_component.HeaderComponent.styles,
    ..._top_appbar.TopAppbar.styles,
  ],
);

Map<String, Object?> __tab_barTabBar(_tab_bar.TabBar c) => {
  'initialValue': c.initialValue,
  'items': c.items,
};
Map<String, Object?> __zoomable_imageZoomableImage(
  _zoomable_image.ZoomableImage c,
) => {'src': c.src, 'alt': c.alt, 'caption': c.caption};
