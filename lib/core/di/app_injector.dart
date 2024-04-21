import 'package:bmi_task/core/utils/network_info.dart';
import 'package:bmi_task/features/authentication/di/authentication_di.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;


Future<void> initializeDependencies() async {
  injector.registerFactory<NetworkInfo>(() => NetworkInfoImpl(injector()));
  AuthenticationDi.initialize();
}

Future<void> resetScopeDependencies() async {
  await injector.resetScope();
  await initializeDependencies();
}
