// 1. Create a centralized typography blueprint
import 'package:jaspr/dom.dart';

abstract class LuminaTypography {
  static final display = Styles(
    fontSize: 57.px,
    fontWeight: .w600,
    raw: {'line-height': '64px', 'letter-spacing': '-0.02em'},
  );

  static final headline = Styles(
    fontSize: 32.px,
    fontWeight: .w600,
    raw: {'line-height': '40px', 'letter-spacing': '0.01em'},
  );

  static final headlineM = Styles(
    fontSize: 28.px,
    fontWeight: .w600,
    raw: {'line-height': '36px', 'letter-spacing': '0.01em'},
  );

  static final title = Styles(
    fontSize: 22.px,
    fontWeight: .w500,
    raw: {'line-height': '28px'},
  );

  static final bodyLg = Styles(
    fontSize: 16.px,
    fontWeight: .w400,
    raw: {'line-height': '24px', 'letter-spacing': '0.01em'},
  );

  static final body = Styles(
    fontSize: 14.px,
    fontWeight: .w400,
    raw: {'line-height': '20px', 'letter-spacing': '0.01em'},
  );

  static final label = Styles(
    fontSize: 12.px,
    fontWeight: .w500,
    textTransform: TextTransform.upperCase,
    raw: {'line-height': '16px', 'letter-spacing': '0.05em'},
  );
}
