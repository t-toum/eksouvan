import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/register/data/model/patient_model.dart';

  abstract class RegisterPaientRepository {
  Future<Either<Failure, String>> addNewPatient(
      {required PatientModel patientModel});
}
