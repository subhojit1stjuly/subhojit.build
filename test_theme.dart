import 'lib/constants/theme.dart';

void main() {
  print('Testing appTheme.styles generation...\n');
  print('Number of style rules: ${appTheme.styles.length}\n');
  
  for (var i = 0; i < appTheme.styles.length && i < 10; i++) {
    print('Rule $i: ${appTheme.styles[i]}');
  }
}
