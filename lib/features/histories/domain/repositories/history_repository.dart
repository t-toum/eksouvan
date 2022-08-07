import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';

abstract class HistoryRepository{
  Future<Either<Failure,List<Patient>>>getAllPatient();
  Future<Either<Failure,Patient>>getPatient({required String patientId});
  Future<Either<Failure,List<Diagnose>>>getAllDiagnose();
  Future<Either<Failure,Diagnose>>getDiagnose({required String patientId});
}