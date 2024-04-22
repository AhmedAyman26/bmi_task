import 'package:bmi_task/features/authentication/domain/repository/authentication_repository.dart';

class SignInUseCase {
  final AuthenticationRepository _authenticationRepository;

  SignInUseCase(this._authenticationRepository);
  Future<String> call() async {
    return await _authenticationRepository.signIn();
  }
}