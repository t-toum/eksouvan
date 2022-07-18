import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';

abstract class DiagnoseRepository {
  Future<Either<Failure, bool>> addDiagnose({required DiagnoseModel model});
}
