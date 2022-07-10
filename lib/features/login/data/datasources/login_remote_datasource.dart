import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/shared_preferences_service.dart';

abstract class LoginRemoteDataSource {
  Future<UserCredential> getLogin(
      {required String email, required String password});
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final AuthService authService;
  final SharedPreferencesService prefService;
  LoginRemoteDataSourceImpl(this.authService, this.prefService);

  @override
  Future<UserCredential> getLogin(
      {required String email, required String password}) async {
    try {
      final userCredential =
          await authService.signIn(email: email, password: password);
      await prefService.setValueString(
          key: SharedPreferenceKey.uidKey, value: userCredential.user?.uid);
      await prefService.setValueString(
          key: SharedPreferenceKey.email, value: userCredential.user?.email);

      return userCredential;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
