import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class CreateuserUsecase implements UseCase<String, CreateuserUsecaseParams> {
  final SettingRepository settingRepository;

  CreateuserUsecase(this.settingRepository);

  @override
  Future<Either<Failure, String>> call(CreateuserUsecaseParams params) async {
    return await settingRepository.createUser(
        email: params.email, password: params.password);
  }
}

class CreateuserUsecaseParams extends Equatable {
  final String email;
  final String password;

  const CreateuserUsecaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
