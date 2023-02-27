import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final sl = GetIt.instance;

@InjectableInit(  
  initializerName: 'init', // default  
  preferRelativeImports: true, // default  
  asExtension: false, // default  
)  
Future<void> configureDependencies({String env = Environment.prod}) async {
  init(sl, environment: env);
}