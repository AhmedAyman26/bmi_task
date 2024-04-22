import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:bmi_task/features/authentication/presentation/authentication_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  final SignInUseCase _signInUseCase;
  AuthenticationCubit(this._signInUseCase) : super(const AuthenticationStates());

  void signIn() async {
    emit(state.copyWith(authenticationState: RequestStatus.loading));
    try {
      final userId = await _signInUseCase.call();
      emit(state.copyWith(authenticationState: RequestStatus.success,userId: userId));
    }
    catch(e) {
      emit(state.copyWith(authenticationState: RequestStatus.failure,errorMessage: e.toString()));
    }
  }

}