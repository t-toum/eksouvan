import 'package:eksouvan/core/entities/user.dart';
import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/features/settings/domain/repositories/setting_repository.dart';
import 'package:injectable/injectable.dart';

import '../datasources/setting_local_datasource.dart';
import '../datasources/setting_remote_datasource.dart';

@LazySingleton(as: SettingRepository)
class SettingRepositoryImpl extends SettingRepository {
  final SettingLocalDatasource settingLocalDatasource;
  final SettingRemoteDatasource settingRemoteDatasource;
  SettingRepositoryImpl(
      this.settingLocalDatasource, this.settingRemoteDatasource);

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final result = await settingLocalDatasource.getLanguage();
      return Right(result);
    } on CacheException catch (error) {
      return Left(CacheFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, bool>> setLanguage({required String langCode}) async {
    try {
      final result =
          await settingLocalDatasource.setLanguage(langCode: langCode);
      return Right(result);
    } on CacheException catch (error) {
      return Left(CacheFailure(msg: error.msg));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUser() async {
    try {
      final result = await settingRemoteDatasource.getAllUser();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
