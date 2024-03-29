import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/features/diagnose/data/datasources/diagnose_remote_datasource.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

@LazySingleton(as: DiagnoseRepository)
class DiagnoseRepositoryImpl extends DiagnoseRepository {
  final DiagnoseRemoteDatasource datasource;

  DiagnoseRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> addDiagnose(
      {required DiagnoseModel data}) async {
    try {
      final result = await datasource.addDiagnose(data: data);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, List<Deases>>> getAllDeases() async {
    try {
      final result = await datasource.getAllDeases();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, String>> addDease(
      {required DeasesModel deasesModel}) async {
    try {
      final result = await datasource.addDeases(deasesModel: deasesModel);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, List<Medicine>>> getAllMedicine() async {
    try {
      final result = await datasource.getAllMedicine();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, String>> addNewMedicine(
      {required MedicineModel data}) async {
    try {
      final result = await datasource.addNewMedicine(data: data);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
