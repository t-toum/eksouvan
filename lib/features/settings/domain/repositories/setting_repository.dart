import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';

import '../../../../core/entities/user.dart';

abstract class SettingRepository {
  Future<Either<Failure,List<User>>>getAllUser();
  Future<Either<Failure,bool>> setLanguage({required String langCode});
  Future<Either<Failure,String>> getLanguage();
}
