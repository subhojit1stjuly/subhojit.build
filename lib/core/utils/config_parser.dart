import 'package:jaspr_content/jaspr_content.dart';

/// Custom parser that catches .cfg files in content/ and ignores them
class CfgIgnoreParser extends PageParser {
  @override
  List<Node> parsePage(Page page) {
    return [];
  }

  @override
  Pattern get pattern => RegExp(r'\.cfg$');
}
