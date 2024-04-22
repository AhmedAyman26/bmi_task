import 'package:bmi_task/core/utils/request_status.dart';
import 'package:equatable/equatable.dart';

class AuthenticationStates extends Equatable
{
  final RequestStatus authenticationState;
  final String? userId;
  final String? errorMessage;

  const AuthenticationStates({this.authenticationState=RequestStatus.initial, this.userId='', this.errorMessage=''});


  AuthenticationStates copyWith({RequestStatus? authenticationState, String? userId, String? errorMessage})
  {
    return AuthenticationStates(
      authenticationState: authenticationState ?? this.authenticationState,
      userId: userId ?? this.userId,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [authenticationState, userId, errorMessage];
}