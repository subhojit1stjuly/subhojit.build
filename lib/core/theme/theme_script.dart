/// Javascript snippet to initialize the theme
/// based on localStorage or OS preference.
const themeInitScript = '''
  (function() {
    try {
      var theme = localStorage.getItem('theme');
      if (theme === 'dark' || theme === 'light') {
        document.documentElement.setAttribute('data-theme', theme);
      } else if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        // Fallback to OS preference on first visit
        document.documentElement.setAttribute('data-theme', 'dark');
      }
    } catch(e) {}
  })();
''';
