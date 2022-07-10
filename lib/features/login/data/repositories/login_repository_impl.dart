import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/features/login/data/datasources/login_local_datasource.dart';
import 'package:eksouvan/features/login/data/datasources/login_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:eksouvan/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositoies/login_repository.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl(this.loginRemoteDataSource, this.localDataSource);
  @override
  Future<Either<Failure, UserCredential>> getLogin(
      {required String email, required String password}) async {
    try {
      final userCredential = await loginRemoteDataSource.getLogin(
          email: email, password: password);
      return Right(userCredential);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, String?>> getLoginUser() async {
    try {
      final result = await localDataSource.getUserLogin();
      return Right(result);
    } on CacheException catch (error) {
      return Left(CacheFailure(msg: error.msg));
    }
  }
}
