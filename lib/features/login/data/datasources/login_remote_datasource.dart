import 'package:eksouvan/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/auth_service.dart';

abstract class LoginRemoteDataSource {
  Future<UserCredential> getLogin(
      {required String email, required String password});
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final AuthService authService;
  LoginRemoteDataSourceImpl(this.authService);

  @override
  Future<UserCredential> getLogin(
      {required String email, required String password}) async {
    try {
      final userCredential =
          await authService.signIn(email: email, password: password);
      return userCredential;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
