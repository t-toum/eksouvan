import 'package:eksouvan/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final FirebaseAuth firebaseAuth;
  AuthService(this.firebaseAuth);
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (error) {
      throw ServerException(msg: error.message ?? "Firebase  auth");
    }
  }
}
