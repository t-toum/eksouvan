import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';

abstract class HistoryRepository{
  Future<Either<Failure,List<Patient>>>getAllPatient();
  Future<Either<Failure,Patient>>getPatient({required String patientId});
}