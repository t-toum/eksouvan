import 'package:dartz/dartz.dart';
import 'package:eksouvan/features/home/data/datasources/home_local_datasource.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasourec.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDatasource homeRemoteDatasource;
  final HomeLocalDatasource homeLocalDatasource;
  HomeRepositoryImpl(
      {required this.networkInfo,
      required this.homeRemoteDatasource,
      required this.homeLocalDatasource});

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      await homeRemoteDatasource.signOutFirebase();
      final result = await homeLocalDatasource.logOut();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, String?>> getCurrentUser() async {
    try {
      final result = await homeLocalDatasource.getCurrentUser();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(msg: e.msg));
    }
  }
}
