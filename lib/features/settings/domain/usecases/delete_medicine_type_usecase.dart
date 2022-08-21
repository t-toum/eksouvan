import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class DeleteMedicineTypeUsecase
    implements UseCase<bool, DeleteMedicineTypeParams> {
  final SettingRepository settingRepository;

  DeleteMedicineTypeUsecase(this.settingRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteMedicineTypeParams params) async {
    return await settingRepository.deleteMedicineType(id: params.id);
  }
}

class DeleteMedicineTypeParams extends Equatable {
  final String id;

  const DeleteMedicineTypeParams({required this.id});

  @override
  List<Object?> get props => [id];
}
