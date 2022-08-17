import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class GetLanguageUsecase implements UseCase<String, NoParams> {
  final SettingRepository settingRepository;
  GetLanguageUsecase(this.settingRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await settingRepository.getLanguage();
  }
}
