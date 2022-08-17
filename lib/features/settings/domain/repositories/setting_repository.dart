import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';

abstract class SettingRepository {
  Future<Either<Failure,bool>> setLanguage({required String langCode});
  Future<Either<Failure,String>> getLanguage();
}
