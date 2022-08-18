import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/models/user_model.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class SaveUserUsecase implements UseCase<dynamic, SaveUserUsecaseParams> {
  final SettingRepository settingRepository;

  SaveUserUsecase(this.settingRepository);
  @override
  Future<Either<Failure, dynamic>> call(SaveUserUsecaseParams params) async {
    return await settingRepository.saveUser(data: params.data);
  }
}

class SaveUserUsecaseParams extends Equatable {
  final UserModel data;

  const SaveUserUsecaseParams({required this.data});

  @override
  List<Object?> get props => [data];
}
