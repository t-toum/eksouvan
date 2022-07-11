import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';

import 'package:eksouvan/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/register_patient_repository.dart';
import '../datasources/register_patient_remote_datasourec.dart';

@LazySingleton(as: RegisterPaientRepository)
class RegisterPatientRepositoryImpl extends RegisterPaientRepository {
  final RegisterPatientRemoteDatasource registerPatientRemoteDatasource;

  RegisterPatientRepositoryImpl(this.registerPatientRemoteDatasource);
  @override
  Future<Either<Failure, String>> addNewPatient(
      {required PatientModel patientModel}) async {
    try {
      final result = await registerPatientRemoteDatasource.addNewPatient(
          patientModel: patientModel);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
