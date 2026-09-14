// scroll_web.dart
import 'dart:js_interop';

@JS('window.scrollTo')
external void jsScrollTo(JSObject options);

void nativeScrollToTop() {
  final scrollOptions = {'top': 0, 'behavior': 'smooth'}.jsify() as JSObject;

  jsScrollTo(scrollOptions);
}
