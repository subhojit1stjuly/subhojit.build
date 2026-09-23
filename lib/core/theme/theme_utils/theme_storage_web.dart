import 'package:web/web.dart' as web;

const _storageKey = 'theme';

bool isDarkTheme() {
  final attr = web.document.documentElement?.getAttribute('data-theme');
  if (attr == 'dark') {
    return true;
  } else if (attr == 'light') {
    return false;
  }
  return web.window.matchMedia('(prefers-color-scheme: dark)').matches;
}

void setTheme(String theme) {
  web.document.documentElement?.setAttribute('data-theme', theme);
  try {
    web.window.localStorage.setItem(_storageKey, theme);
  } catch (_) {}
}
