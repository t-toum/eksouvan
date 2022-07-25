
import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/features/diagnose/data/datasources/diagnose_remote_datasource.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

@LazySingleton(as: DiagnoseRepository)
class DiagnoseRepositoryImpl extends DiagnoseRepository {
  final DiagnoseRemoteDatasource datasource;

  DiagnoseRepositoryImpl(this.datasource);
  
  @override
  Future<Either<Failure, String>> addDiagnose({required Map<String, dynamic> data, required String patientIs}) async{
   try {
      final result = await datasource.addDiagnose(data: data,patientId: patientIs);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
