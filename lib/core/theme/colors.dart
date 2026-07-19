import 'package:jaspr/dom.dart';
import 'package:jaspr_content/theme.dart';

// ============================================================
// 1. Theme Configuration — Lumina Design System (Tokens)
// ============================================================

// Backgrounds & Surfaces

final bgColor = ColorToken('bg', Color('#fbf9f4'), dark: Color('#0b0d0e'));
final surfaceColor = ColorToken('surface', Color('#fbf9f4'), dark: Color('#1a1c1e'));
final surfaceContainerLowest = ColorToken('surface-container-lowest', Color('#ffffff'), dark: Color('#0f1113'));
final surfaceContainerLow = ColorToken('surface-container-low', Color('#f5f3ee'), dark: Color('#1f2225'));
final surfaceContainer = ColorToken('surface-container', Color('#f0eee9'), dark: Color('#22252a'));
final surfaceContainerHigh = ColorToken('surface-container-high', Color('#eae8e3'), dark: Color('#2c2f35'));
final surfaceContainerHighest = ColorToken('surface-container-highest', Color('#e4e2dd'), dark: Color('#36393f'));
final surfaceVariant = ColorToken('surface-variant', Color('#e4e2dd'), dark: Color('#36393f'));

// Primary Brand Colors
final primaryColor = ColorToken('primary', Color('#523fb9'), dark: Color('#c8bfff'));
final primaryContainer = ColorToken('primary-container', Color('#6b59d3'), dark: Color('#452fab'));
final onPrimary = ColorToken('on-primary', Color('#ffffff'), dark: Color('#1a1c1e'));
final primaryFixed = ColorToken('primary-fixed', Color('#e5deff'), dark: Color('#2e2548'));
final onPrimaryFixedVariant = ColorToken('on-primary-fixed-variant', Color('#452fab'), dark: Color('#b5a7ff'));
final inversePrimary = ColorToken('inverse-primary', Color('#c8bfff'), dark: Color('#523fb9'));

// Text & Content
final onSurface = ColorToken('on-surface', Color('#1b1c19'), dark: Color('#e4e2dd'));
final onSurfaceVariant = ColorToken('on-surface-variant', Color('#484553'), dark: Color('#c9c4d5'));
final inverseSurface = ColorToken('inverse-surface', Color('#30312e'), dark: Color('#e4e2dd'));
final inverseOnSurface = ColorToken('inverse-on-surface', Color('#f2f1ec'), dark: Color('#1b1c19'));

// Borders & Dividers
final outline = ColorToken('outline', Color('#787585'), dark: Color('#8e8c99'));
final outlineVariant = ColorToken('outline-variant', Color('#c9c4d5'), dark: Color('#484553'));

// Accent & Secondary
final secondaryContainer = ColorToken('secondary-container', Color('#d1e6f2'), dark: Color('#1f3a47'));
final onSecondaryContainer = ColorToken('on-secondary-container', Color('#546771'), dark: Color('#b3d4e5'));

// Backward Compatibility Aliases
final accentColor = primaryColor;
final accentHoverColor = onPrimaryFixedVariant;
final textPrimary = onSurface;
final textSecondary = onSurfaceVariant;
final borderColor = outlineVariant;
final tagBgColor = primaryFixed;
