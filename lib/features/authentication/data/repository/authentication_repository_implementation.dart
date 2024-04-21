import 'package:bmi_task/core/utils/network_info.dart';
import 'package:bmi_task/features/authentication/domain/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final NetworkInfo networkInfo;

  AuthenticationRepositoryImplementation(this.networkInfo);

  @override
  Future<void> signIn() async {
    if (!(await networkInfo.isConnected)) {
      throw Exception('No internet connection');
    } else {
      await firebaseAuth.signInAnonymously().then((value)
      {
        print(value.user!.uid);
      }).catchError((error)
      {
        throw Exception(error.toString());
      });
    }
  }
}
