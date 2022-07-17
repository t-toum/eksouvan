import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';

abstract class DiagnoseRepository {
  Future<Either<Failure, bool>> addDiagnose({required String doc,required PatientModel patient});
}
