import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';

abstract class DiagnoseRepository {
  Future<Either<Failure, String>> addDiagnose(
      {required  DiagnoseModel data});
  Future<Either<Failure, List<Deases>>> getAllDeases();
  Future<Either<Failure, String>> addDease({required DeasesModel deasesModel});
  Future<Either<Failure, List<Medicine>>> getAllMedicine();
  Future<Either<Failure, String>> addNewMedicine({required MedicineModel data});
}
