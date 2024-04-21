import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/features/authentication/data/repository/authentication_repository_implementation.dart';
import 'package:bmi_task/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bmi_task/features/authentication/domain/use_cases/sign_in_use_case.dart';

class AuthenticationDi
{
  AuthenticationDi._();

  static void initialize()
  {
    injector.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImplementation(injector()));

    injector.registerFactory(() => SignInUseCase(injector()));
  }
}