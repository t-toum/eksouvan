import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/entities/user.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class GetAllUserUsecase implements UseCase<List<User>, NoParams> {
  final SettingRepository settingRepository;

  GetAllUserUsecase(this.settingRepository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await settingRepository.getAllUser();
  }
}
