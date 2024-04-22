import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/network_info.dart';
import 'package:bmi_task/features/authentication/data/repository/authentication_repository_implementation.dart';
import 'package:bmi_task/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bmi_task/features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthenticationDi
{
  AuthenticationDi._();

  static void initialize()
  {
    injector.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImplementation(NetworkInfoImpl(InternetConnectionChecker())));

    injector.registerFactory(() => SignInUseCase(injector()));
  }
}