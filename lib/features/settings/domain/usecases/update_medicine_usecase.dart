import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class UpdateMedicineUsecase implements UseCase<bool, UpdateMedicineParams> {
  final SettingRepository settingRepository;

  UpdateMedicineUsecase(this.settingRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateMedicineParams params) async {
    return await settingRepository.updateMedicine(data: params.data);
  }
}

class UpdateMedicineParams extends Equatable {
  final MedicineModel data;
  const UpdateMedicineParams({required this.data});

  @override
  List<Object?> get props => [data];
}
