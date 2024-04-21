import 'package:bmi_task/features/authentication/domain/repository/authentication_repository.dart';

class SignInUseCase {
  final AuthenticationRepository _authenticationRepository;

  SignInUseCase(this._authenticationRepository);
  Future<void> call() async {
    await _authenticationRepository.signIn();
  }
}