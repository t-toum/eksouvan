import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/entities/medicine_type.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/models/medicine_type_mode.dart';
import 'package:eksouvan/core/models/user_model.dart';

import '../../../../core/entities/user.dart';

abstract class SettingRepository {
  Future<Either<Failure, List<User>>> getAllUser();
  Future<Either<Failure, bool>> setLanguage({required String langCode});
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, String>> createUser(
      {required String email, required String password});
  Future<Either<Failure, dynamic>> saveUser({required UserModel data});
  Future<Either<Failure, List<MedicineType>>> getMedicineType();
  Future<Either<Failure, dynamic>> addMedicineType(
      {required MedicineTypeMedel data});
  Future<Either<Failure, bool>> deleteMedicineType({required String id});
  Future<Either<Failure, bool>> deleteMedicine({required String id});
  Future<Either<Failure, bool>> updateMedicine({required MedicineModel data});

}
