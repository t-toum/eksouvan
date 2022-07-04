import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/todo.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasourec.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDatasource homeRemoteDatasource;
  HomeRepositoryImpl(
      {required this.networkInfo, required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      if (await networkInfo.isConnected) {
        final listTodos = await homeRemoteDatasource.getTodos();
        return Right(listTodos);
      } else {
        return const Left(ServerFailure(msg: "No Internet connection"));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }
}