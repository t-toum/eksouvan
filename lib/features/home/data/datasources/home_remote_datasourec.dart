import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/services/auth_service.dart';

abstract class HomeRemoteDatasource {
  Future<bool> signOutFirebase();
}

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final AuthService authService;
  final Logger logger;
  HomeRemoteDatasourceImpl(
    this.authService, {
    required this.logger,
  });

  @override
  Future<bool> signOutFirebase()async {
    try {
      final res =await authService.signOut();
      return res;
    } on FirebaseAuthException catch (eror) {
      throw eror.message ?? '';
    }
  }
}
