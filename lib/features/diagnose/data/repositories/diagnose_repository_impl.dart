import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/features/diagnose/data/datasources/diagnose_remote_datasource.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DiagnoseRepository)
class DiagnoseRepositoryImpl extends DiagnoseRepository {
  final DiagnoseRemoteDatasource datasource;

  DiagnoseRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, bool>> addDiagnose(
      {required String doc, required PatientModel patient}) async {
    try {
      final result =
          await datasource.addDiagnose(doc: doc, patientModel: patient);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
