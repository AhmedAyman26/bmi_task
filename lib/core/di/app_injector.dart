import 'package:bmi_task/features/authentication/di/authentication_di.dart';
import 'package:bmi_task/features/bmi/di/bmi_di.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;


Future<void> initializeDependencies() async {
  AuthenticationDi.initialize();
  BmiDi.initialize();
}

Future<void> resetScopeDependencies() async {
  await injector.resetScope();
  await initializeDependencies();
}
