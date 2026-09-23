import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart'; // This file will be generated automatically

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // Default is $initGetIt or init
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
