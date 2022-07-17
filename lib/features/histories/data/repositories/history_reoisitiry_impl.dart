import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/features/histories/data/datasources/history_remote_datasource.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';

import 'package:eksouvan/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/history_repository.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl extends HistoryRepository {
  final HistoryRemoteDataSource historyRemoteDataSource;

  HistoryRepositoryImpl(this.historyRemoteDataSource);
  @override
  Future<Either<Failure, List<Patient>>> getAllPatient() async {
    try {
      final result = await historyRemoteDataSource.getAllPatient();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
  
  @override
  Future<Either<Failure, Patient>> getPatient({required String patientId})async {
     try {
      final result = await historyRemoteDataSource.getPatient(patientId: patientId);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
