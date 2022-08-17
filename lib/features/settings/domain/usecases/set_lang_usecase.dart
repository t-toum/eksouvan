import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class SetLanguageUsecase implements UseCase<bool, SetLanguageParams> {
  final SettingRepository settingRepository;
  SetLanguageUsecase(this.settingRepository);

  @override
  Future<Either<Failure, bool>> call(SetLanguageParams params) async {
    return await settingRepository.setLanguage(langCode: params.langCode);
  }
}

class SetLanguageParams extends Equatable {
  final String langCode;

  const SetLanguageParams({required this.langCode});

  @override
  List<Object?> get props => [langCode];
}
